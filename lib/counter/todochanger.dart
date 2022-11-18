import 'package:flutter/foundation.dart';

class TodoChanger extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  displayResult(int v) {
    _counter = v;
    notifyListeners();
    ;
  }
}
