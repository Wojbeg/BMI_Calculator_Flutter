import 'package:bmi_flutter/presenter/ResultPresenter.dart';
import 'package:bmi_flutter/resources/app_constants.dart';
import 'package:bmi_flutter/views/ResultView.dart';
import 'package:flutter/material.dart';
import 'package:bmi_flutter/resources/strings.dart';

class Results extends StatefulWidget {
  final ResultPresenter presenter;

  const Results({required this.presenter, Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> implements ResultView{

  Map data = {};

  @override
  void initState() {
    super.initState();
    widget.presenter.resultView = this;
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;
    String bmi = data[resultBmiParameter];
    String result = data[resultResultParameter] ;
    String description = data[resultDescriptionParameter];
    int gender = data[resultGenderParameter];

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
      backgroundColor: backgroundLight,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        Strings.appBarTitle,
        style: TextStyle(
            color: appBarTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),),),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Column(
                children: [
                    const Padding(
                    padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Your BMI:',
                        style: TextStyle(
                            color: appBarTextColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      bmi,
                      style: TextStyle(
                          color: gender == 0 ? maleDarkColor : femaleDarkColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle (
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
