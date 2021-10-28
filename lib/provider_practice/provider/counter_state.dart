

import 'package:flutter/material.dart';

class CounterState extends ChangeNotifier{
  int counter= 0;



  counterIncrement() {
    counter++;
    notifyListeners();
  }

}
