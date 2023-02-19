import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:test_app/UI/sport_plug/sportPlug_model.dart';

import 'newsPlug_view.dart';

class SportNewsViewModel extends BaseViewModel {
  SportNewsViewModel(BuildContext context);
  bool loader = true;

  List<String> newsTittle = [
    "XFL 2023 schedule, scores: Times, dates and matchups for the entire regular season and playoffs - CBS Sports",
    "NHL Stadium Series | Carolina Hurricanes play Washington Capitals inside Carter Finley Stadium - WTVD-TV",
    "NASCAR Xfinity Series opener ends with Sam Mayer going from the lead to upside down in wild crash - Yahoo Sports",
    "Maggie MacNeil Splits 45.26 to Lift LSU to a 2nd Relay Win at SECs - SwimSwam",
    "Kansas, Big 12 highlight biggest winners from men's college basketball - USA TODAY",
    "Report: Cardinals hire Eagles LBs coach Nick Rallis as defensive coordinator - Arizona Sports",
    "NBA All-Star Saturday 2023: Mac McClung wins Slam Dunk with 3 50 dunks; Damian Lillard wins 3-Point Contest; Team Jazz wins Skills - Yahoo Sports",
    "Mac McClung dominates field to win NBA's slam dunk contest - ESPN",
    "Michigan basketball tops Michigan State, 84-72, on emotional night - Detroit Free Press",
    "Charles Barkley on Kevin Durant joining the Suns: 'He should lead that team' - Fox News",
    "Hometown Team Utah wins All-Star skills challenge - ESPN",
    "Lucas Henveaux Breaks Cal Record in His 2nd NCAA Meet (And That Was Just the Beginning) - SwimSwam",
    "Silver doesn't 'buy into' load management being an NBA problem - ESPN",
    "Lillard secures 'a goal of mine,' wins NBA 3-point contest - ESPN",
    "Ghana soccer player Christian Atsu found dead in rubble of Turkey earthquake, agent says - KABC-TV",
  ];
  List<String> newsDescription = [
    "XFL 2020 schedule: Dates, times and matchup information as league readies to kickoff following Super Bowl LIV",
    "Martin Necas, Jesperi Kotkaniemi, Teuvo Teravainen and Paul Stastny found the back of the net for the Canes.",
    "The crash handed Austin Hill a second straight win at Daytona.",
    "After an off year in 2022, Maggie MacNeil's best might be yet to come in 2023. On Saturday, she swam the fastest-ever 100 free by a woman at the SEC Championships.",
    "While Kansas rallied from 13 down at halftime to beat Baylor, Michigan State hosted Michigan, which showed support after last week's campus shooting.",
    "The Cardinals are hiring 29-year-old Eagles LBs coach Nick Rallis as their defensive coordinator, NFL Network's Tom Pelissero reported.",
    "Follow Yahoo Sports for live updates from Salt Lake City on all three events.",
    "Mac McClung dominated the NBA's slam dunk contest, earning 50s for three of his four dunks.",
    "After struggling to close games all season, Michigan basketball finished Saturday on a 12-0 run to beat Michigan State 84-72 in Ann Arbor.",
    "Charles Barkley has not shied away from dishing out criticism, especially as it pertains to Kevin Durant. But, Barkley says the Suns presents Durant with a special opportunity.",
    "The Utah Jazz group of Jordan Clarkson, Walker Kessler and Collin Sexton beat out Team Antetokounmpo and Team Rookies to win the All-Star skills challenge.",
    "Lucas Henveaux is so new that we don't have a picture of him yet; Destin Lasco (above) won three events, though - including a 1:38 in the 200 back.",
    "In addressing many topics at All-Star Weekend on Saturday, commissioner Adam Silver pushed back on the notion that load management is a problem in the NBA, saying \"I don't buy into\" the idea that players should simply just be playing more.",
    "Trail Blazers star Damian Lillard won the 3-point contest at the NBA's All-Star Saturday Night in Salt Lake City, topping Pacers teammates Buddy Hield and Tyrese Haliburton in the final round and saying afterward that the title was \"a goal of mine.\"",
    "Christian Atsu, the Ghana international forward who played for Premier League clubs Chelsea and Newcastle, has died in the earthquake in Turkey. He was 31.",
  ];
  List<String> newsImage = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
    'assets/9.jpg',
    'assets/10.jpg',
    'assets/11.jpg',
    'assets/12.jpg',
    'assets/13.jpg',
    'assets/14.jpg',
    'assets/15.jpg'
  ];
  List<String> newsDate = [
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
    "2023-02-19",
  ];

  Future onReady() async {}

  void remoteConfig() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // final remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig.setConfigSettings(RemoteConfigSettings(
    //   fetchTimeout: const Duration(minutes: 1),
    //   minimumFetchInterval: const Duration(hours: 1),
    // ));
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
