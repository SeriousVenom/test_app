import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InternetErrorView extends StatelessWidget {
  const InternetErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
        child: SafeArea(
            child: Scaffold(
          body: SizedBox(
            child: Center(
              child: Text(
                'Network access is required for the application to work',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        )));
  }
}
