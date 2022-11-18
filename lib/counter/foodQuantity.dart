import 'package:flutter/foundation.dart';

class FoodQuantity with ChangeNotifier {
  int _numberOfFoods = 0;

  int get numberOfFoods => _numberOfFoods;

  display(int no)
  {
    _numberOfFoods = no;
    notifyListeners();
  }
}

