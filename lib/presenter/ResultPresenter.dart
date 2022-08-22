import 'package:bmi_flutter/presenter/PresenterInterface.dart';
import 'package:bmi_flutter/views/ResultView.dart';

abstract class ResultPresenter implements Presenter {
  set resultView(ResultView view) {}
}

class ResultPresenterImpl implements ResultPresenter {
  late ResultView _view;

  @override
  set resultView(ResultView view) {
    _view = view;
  }
}