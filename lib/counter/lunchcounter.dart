import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter/foundation.dart';

class LunchCounter extends ChangeNotifier {
  int _counter = HealthApp.sharedPreferences
          .getStringList(HealthApp.userLunchCartList)
          .length -
      1;
  int get count => _counter;

  Future<void> displayResult() async {
    int _counter = HealthApp.sharedPreferences
            .getStringList(HealthApp.userLunchCartList)
            .length -
        1;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
