import 'dart:math';

class Calculator {

  Calculator({required this.height, required this.weight});

  final int height;
  final int weight;

  double _bmi = 0;

  String calculate() {
    _bmi = weight / pow(height/100, 2);
    return _bmi.toStringAsFixed(2);
  }

  String getResult() {
    if(_bmi >= 30) {
      return 'Obese';
    } else if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi >= 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getDescription(){
    if(_bmi >= 30) {
      return 'You are obese, exercise more, change your diet, see the doctor!';
    } else if (_bmi >= 25) {
      return 'You are overweight, exercise more, change your diet.';
    } else if (_bmi >= 18.5) {
      return 'You have a good body weight. Keep it up!';
    } else {
      return 'You are underweight. Change your diet and eat more!';
    }
  }
}