import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';

class StrokeState extends ChangeNotifier {
  static StrokeState _instance;

  factory StrokeState.init({@required double initialWidth}) {
    return _instance = StrokeState._internal(initialWidth: initialWidth);
  }

  factory StrokeState() {
    assert(_instance != null,
        'The StrokeState.init() factory constructor must be called before using the StrokeState() constructor.');
    return _instance;
  }

  StrokeState._internal({@required double initialWidth}) {
    _width = initialWidth;
  }

  InkState ink;

  /// The current width of the line
  double _width;
  double get width => _width;
  set width(double value) {
    _width = value;
    ink.finishLine();
    notifyListeners();
  }
}
