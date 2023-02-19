import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'mainScreen_viewmodel.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  State<MainScreenView> createState() => _MainScreenView();
}

class _MainScreenView extends State<MainScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      viewModelBuilder: () => MainScreenViewModel(context),
      onViewModelReady: (viewModel) => viewModel.onReady(context),
      builder: (context, model, chile) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
            child: WillPopScope(
              onWillPop: () async {
                model.controller!.goBack();
                return false;
              },
              child: Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                //bottomNavigationBar: customBottomBar(context, model),
                body: _mainScreenView(context, model),
              ),
            ));
      },
    );
  }

  _mainScreenView(BuildContext context, MainScreenViewModel model) {
    return model.isLoading
        ? Center(child: CircularProgressIndicator())
        : WebViewWidget(controller: model.controller!);
  }
}
