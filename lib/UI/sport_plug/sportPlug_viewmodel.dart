import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:test_app/UI/sport_plug/sportPlug_model.dart';

import 'newsPlug_view.dart';

class SportNewsViewModel extends BaseViewModel {
  SportNewsViewModel(BuildContext context);
  NewsModel? newsModel;
  int? newsIndex;
  bool loader = true;

  Future onReady() async {
    getNews();
  }

  void getNews() async {
    String newsURL =
        'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=077401012ab6476380b3f64e7044ff13';
    final httpResponse = await http.get(Uri.parse(newsURL));
    var jsonResponse = json.decode(httpResponse.body);
    newsModel = NewsModel.fromJson(jsonResponse);
    loader = false;
    notifyListeners();
  }

  void choiceNewsIndex(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewsView(
                index: index,
              )),
    );
    notifyListeners();
  }
}
