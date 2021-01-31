import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class BackgroundState extends ChangeNotifier {
  static BackgroundState _instance;

  factory BackgroundState.init({@required Color initialColor}) {
    return _instance = BackgroundState._internal(initialColor: initialColor);
  }

  factory BackgroundState() {
    assert(_instance != null,
        'The BackgroundState.init() factory constructor must be called before using the BackgroundState() constructor.');
    return _instance;
  }

  BackgroundState._internal({@required Color initialColor}) {
    _color = TinyColor(initialColor);
  }

  TinyColor _color;

  /// The current background color of the canvas, as a TinyColor instance
  TinyColor get color => _color;
  void setBackgroundColor(Color color) {
    _color = TinyColor(color);
    notifyListeners();
  }
}
