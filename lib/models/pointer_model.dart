import 'package:flutter/material.dart';

class PointersModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  set count(int value) {
    _count = value;
    notifyListeners();
  }

  globalPointerDown(PointerDownEvent event) {
    count++;
  }

  globalPointerUp(PointerUpEvent event) {
    count--;
  }
}
