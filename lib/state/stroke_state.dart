import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/models/ink_line.dart';

class StrokeState extends ChangeNotifier {
  static StrokeState _instance;

  factory StrokeState.init(
      {@required double initialWidth,
      StrokeStyle initialStyle = StrokeStyle.normal}) {
    return _instance = StrokeState._internal(
        initialWidth: initialWidth, initialStyle: initialStyle);
  }

  factory StrokeState() {
    assert(_instance != null,
        'The StrokeState.init() factory constructor must be called before using the StrokeState() constructor.');
    return _instance;
  }

  StrokeState._internal(
      {@required double initialWidth, @required StrokeStyle initialStyle}) {
    _width = initialWidth;
    _style = initialStyle;
  }

  InkState ink;

  /// The current width of the line
  double _width;
  double get width => _width;

  /// The current style of the line
  StrokeStyle _style;
  StrokeStyle get style => _style;

  /// Updates the width and style of the current stroke
  void setStroke({double width, StrokeStyle style}) {
    _width = width;
    _style = style;
    ink.finishLine();
    notifyListeners();
  }
}
