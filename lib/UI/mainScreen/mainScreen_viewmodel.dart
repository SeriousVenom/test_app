import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../sport_plug/sportPlug_view.dart';

class MainScreenViewModel extends BaseViewModel {
  MainScreenViewModel(BuildContext context);
  bool isLoading = true;
  String? customURL;
  String? appURL;
  final storage = const FlutterSecureStorage();
  WebViewController? controller;

  Future onReady(context) async {
    checkFunc(context);
  }

  checkFunc(context) async {
    appURL = await storage.read(key: 'url1');
    if (appURL == null || appURL == '') {
      await Firebase.initializeApp();
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      await remoteConfig.fetchAndActivate();
      customURL = remoteConfig.getString('customURL1');
      var isEmu = await checkIsEmu();
      print(customURL);
      print(isEmu);

      // if (customURL != '' || isEmu == true) {
      //   print('NOT WEBVIEW');
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SportNewsView()),
      //   );
      // } else {
      //   await storage.write(key: 'url1', value: customURL);
      // }
    }
    isLoading = false;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(customURL!)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(customURL!));
    print(appURL);
    notifyListeners();
  }

  checkIsEmu() async {
    final em = await DeviceInfoPlugin().androidInfo;

    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;

    var result = (em.fingerprint.startsWith("generic") ||
        phoneModel.contains("google_sdk") ||
        phoneModel.contains("droid4x") ||
        phoneModel.contains("Emulator") ||
        phoneModel.contains("Android SDK built for x86") ||
        em.manufacturer.contains("Genymotion") ||
        buildHardware == "goldfish" ||
        buildHardware == "vbox86" ||
        buildProduct == "sdk" ||
        buildProduct == "google_sdk" ||
        buildProduct == "sdk_x86" ||
        buildProduct == "vbox86p" ||
        em.brand.contains('google') ||
        em.board.toLowerCase().contains("nox") ||
        em.bootloader.toLowerCase().contains("nox") ||
        buildHardware.toLowerCase().contains("nox") ||
        !em.isPhysicalDevice ||
        buildProduct.toLowerCase().contains("nox"));

    if (result) return true;
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic"));
    if (result) return true;
    result = result || ("google_sdk" == buildProduct);
    return result;
  }

  void remoteConfig() async {
    await Firebase.initializeApp();
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    await remoteConfig.fetchAndActivate();
    customURL = remoteConfig.getString('customURL1');
    await storage.write(key: 'url', value: customURL);
    print(customURL);
    notifyListeners();
  }
}
