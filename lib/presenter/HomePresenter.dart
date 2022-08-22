import 'package:bmi_flutter/presenter/PresenterInterface.dart';
import 'package:bmi_flutter/util/Gender.dart';
import 'package:bmi_flutter/models/HomeModel.dart';
import 'package:bmi_flutter/views/HomeView.dart';
import 'package:bmi_flutter/util/calculator.dart';

abstract class HomePresenter implements Presenter {
  set homeView(HomeView view){}

  void onGenderSelected(Gender gender){}
  void onHeightSelected(double height){}
  void onWeightSelected(int weight){}
  void onCalculateClicked(){}
}

class HomePresenterImpl implements HomePresenter {
  final HomeModel _model;
  late HomeView _view;

  HomePresenterImpl(): _model = HomeModel();

  @override
  set homeView(HomeView view) {
    _view = view;
  }

  @override
  void onCalculateClicked() {
    Calculator calculator = Calculator(height: _model.height.toInt(), weight: _model.weight);
    String bmi = calculator.calculate();

    _view.navigateToResult(bmi, calculator.getResult(), calculator.getDescription(), _model.selectedGender.index);
  }

  @override
  void onGenderSelected(Gender gender) {
    _model.selectedGender = gender;

    _view.updateGender(_model.selectedGender);
  }

  @override
  void onHeightSelected(double height) {
    _model.height = height;

    _view.updateHeight(_model.height);
  }

  @override
  void onWeightSelected(int weight) {
    _model.weight = weight;

    _view.updateWeight(_model.weight);
  }


}
