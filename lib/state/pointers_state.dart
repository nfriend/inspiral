import 'package:flutter/material.dart';

class PointersState extends ChangeNotifier {
  static PointersState _instance;

  factory PointersState.init() {
    assert(_instance == null,
        'The PointersState.init() factory constructor should not be called more than once.');
    return _instance = PointersState._internal();
  }

  factory PointersState() {
    assert(_instance != null,
        'The PointersState.init() factory constructor must be called before using the PointersState() constructor.');
    return _instance;
  }

  PointersState._internal();

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
