import 'package:flutter/material.dart';

class PointersProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  set count(int value) {
    _count = value;
    notifyListeners();
  }

  globalPointerDown(Offset pointerPosition, PointerDownEvent event) {
    count++;
  }

  globalPointerUp(Offset pointerPosition, PointerUpEvent event) {
    count--;
  }
}
