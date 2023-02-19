import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'UI/sport_plug/sportPlug_view.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SportNewsView(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
