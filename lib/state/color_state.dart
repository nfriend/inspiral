import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorState extends ChangeNotifier {
  static ColorState _instance;

  factory ColorState.init(
      {@required TinyColor initialBackgroundColor,
      @required TinyColor initialPenColor}) {
    return _instance = ColorState._internal(
        initialBackgroundColor: initialBackgroundColor,
        initialPenColor: initialPenColor);
  }

  factory ColorState() {
    assert(_instance != null,
        'The ColorState.init() factory constructor must be called before using the ColorState() constructor.');
    return _instance;
  }

  ColorState._internal(
      {@required TinyColor initialBackgroundColor,
      @required TinyColor initialPenColor}) {
    _backgroundColor = initialBackgroundColor;
    _penColor = initialPenColor;

    _updateDependentColors();
  }

  /// The current background color of the canvas
  TinyColor _backgroundColor;
  TinyColor get backgroundColor => _backgroundColor;
  set backgroundColor(TinyColor value) {
    _backgroundColor = value;
    _updateDependentColors();
    notifyListeners();
  }

  /// The current color of the pen
  TinyColor _penColor;
  TinyColor get penColor => _penColor;
  set penColor(TinyColor value) {
    _penColor = value;
    _updateDependentColors();
    notifyListeners();
  }

  bool get isDark => _backgroundColor.isDark();

  /// The background color of UI elements (tabs, modals, etc)
  TinyColor get uiBackgroundColor => _uiBackgroundColor;
  TinyColor _uiBackgroundColor;

  /// The primary color for the current theme
  TinyColor get primaryColor => _primaryColor;
  TinyColor _primaryColor;

  /// The accent color for the current theme
  TinyColor get accentColor => _accentColor;
  TinyColor _accentColor;

  /// The splash color for ink effects
  TinyColor get splashColor => _splashColor;
  TinyColor _splashColor;

  /// The highlight color for the current theme
  TinyColor get highlightColor => _highlightColor;
  TinyColor _highlightColor;

  /// The background color of the entire app
  TinyColor get appBackgroundColor => _appBackgroundColor;
  TinyColor _appBackgroundColor;

  /// The color of the canvas's shadow against the app's background
  TinyColor get canvasShadowColor => _canvasShadowColor;
  TinyColor _canvasShadowColor;

  /// Updates all dependt colors based on the background and pen colors
  void _updateDependentColors() {
    double penHue = penColor.toHsl().h;

    double luminance = isDark ? 0.25 : 0.7;

    _uiBackgroundColor =
        TinyColor.fromHSL(HslColor(h: penHue, s: 0.8, l: luminance, a: 200.0));

    _primaryColor =
        TinyColor.fromHSL(HslColor(h: penHue, s: 0.8, l: luminance, a: 255.0));

    _splashColor =
        isDark ? _uiBackgroundColor.lighten(30) : _uiBackgroundColor.darken(30);
    _highlightColor =
        isDark ? _uiBackgroundColor.lighten(5) : _uiBackgroundColor.darken(5);

    _accentColor = _primaryColor.complement();

    _appBackgroundColor =
        isDark ? backgroundColor.lighten() : backgroundColor.darken();

    _canvasShadowColor =
        isDark ? backgroundColor.lighten(20) : backgroundColor.darken(20);
  }
}
