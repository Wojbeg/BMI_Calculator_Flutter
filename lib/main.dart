import 'package:bmi_flutter/presenter/HomePresenter.dart';
import 'package:bmi_flutter/presenter/ResultPresenter.dart';
import 'package:bmi_flutter/views/screens/home.dart';
import 'package:bmi_flutter/views/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:bmi_flutter/resources/strings.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appBarTitle,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(presenter: HomePresenterImpl()),
        '/result': (context) => Results(presenter: ResultPresenterImpl())
      },
    );
  }
}
