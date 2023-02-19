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
    return model.loader == true
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ),
          )
        : ListView(
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
                child: model.newsModel!.articles![widget.index!].urlToImage !=
                        null
                    ? Image.network(
                        model.newsModel!.articles![widget.index!].urlToImage!,
                        errorBuilder: (context, url, error) => const SizedBox())
                    : const SizedBox(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                model.newsModel!.articles?[widget.index!].title ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                model.newsModel!.articles?[widget.index!].description ?? '',
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Published at: ${model.newsModel!.articles?[widget.index!].publishedAt!.substring(0, 10) ?? ''}',
              ),
            ],
          );
  }
}
