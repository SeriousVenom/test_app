import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:test_app/UI/sport_plug/sportPlug_viewmodel.dart';

class NewsView extends StatefulWidget {
  final int? index;
  const NewsView({Key? key, required this.index}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsView();
}

class _NewsView extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SportNewsViewModel>.reactive(
      viewModelBuilder: () => SportNewsViewModel(context),
      onViewModelReady: (viewModel) => viewModel.onReady(),
      builder: (context, model, chile) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark),
          child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            //bottomNavigationBar: customBottomBar(context, model),
            body: _sportNewsView(context, model),
          ),
        );
      },
    );
  }

  _sportNewsView(BuildContext context, SportNewsViewModel model) {
    return ListView(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 70),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(model.newsImage[widget.index!]),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.newsTittle[widget.index!],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.newsDescription[widget.index!],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Published at: ${model.newsDate[widget.index!]}',
        ),
      ],
    );
  }
}
