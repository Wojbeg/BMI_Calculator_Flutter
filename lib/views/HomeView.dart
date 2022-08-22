import 'package:bmi_flutter/views/View.dart';
import 'package:bmi_flutter/util/Gender.dart';

class HomeView implements View {
  void updateGender(Gender setGender) {}
  void updateHeight(double height) {}
  void updateWeight(int weight) {}

  void navigateToResult(String bmi, String result, String description, int genderIndex) {}
}