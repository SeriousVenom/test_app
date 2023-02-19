import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:test_app/UI/webview/webView_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({Key? key}) : super(key: key);

  @override
  State<AppWebView> createState() => _AppWebView();
}

class _AppWebView extends State<AppWebView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebViewModel>.reactive(
      viewModelBuilder: () => WebViewModel(context),
      onViewModelReady: (viewModel) => viewModel.onReady(context),
      builder: (context, model, chile) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
          child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            //bottomNavigationBar: customBottomBar(context, model),
            body: _webView(context, model),
          ),
        );
      },
    );
  }

  _webView(BuildContext context, WebViewModel model) {
    bool isLoading = true;
  }
}
