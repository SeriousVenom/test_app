import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:test_app/UI/sport_plug/sportPlug_viewmodel.dart';

class SportNewsView extends StatefulWidget {
  const SportNewsView({Key? key}) : super(key: key);

  @override
  State<SportNewsView> createState() => _SportNewsView();
}

class _SportNewsView extends State<SportNewsView> {
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
}

_sportNewsView(BuildContext context, SportNewsViewModel model) {
  return Container(
    color: Colors.white,
    child: ListView(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.refresh),
            ),
          ),
        ),
        ListView.builder(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
          itemCount: model.newsTittle.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                model.choiceNewsIndex(context, index);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey.shade900.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 15)),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(model.newsImage[index])),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          model.newsTittle[index],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.newsDescription[index],
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
