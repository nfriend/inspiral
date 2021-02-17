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

  /// The background color of UI elements (buttons, tabs, modals, etc)
  TinyColor get uiBackgroundColor => _uiBackgroundColor;
  TinyColor _uiBackgroundColor;

  /// The pen color without any transparency
  TinyColor get penColorWithoutAlpha => _penColorWithoutAlpha;
  TinyColor _penColorWithoutAlpha;

  /// The color of the text in the UI
  TinyColor get uiTextColor => _uiTextColor;
  TinyColor _uiTextColor;

  /// The color of the text in the UI when appearing on the accent background
  TinyColor get uiTextAccentColor => _uiTextAccentColor;
  TinyColor _uiTextAccentColor;

  /// The primary color for the current theme
  TinyColor get primaryColor => _primaryColor;
  TinyColor _primaryColor;

  /// The accent color for the current theme
  TinyColor get accentColor => _accentColor;
  TinyColor _accentColor;

  /// The splash color for ink effects
  TinyColor get splashColor => _splashColor;
  TinyColor _splashColor;

  /// The splash color for ink effects on the accent color
  TinyColor get accentSplashColor => _accentSplashColor;
  TinyColor _accentSplashColor;

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
    HslColor penHsl = penColor.toHsl();
    double penHue = penHsl.h;
    double penSaturation = penHsl.s;

    // Reduce the bottom range of the luminance to avoid complete black
    double luminance = penHsl.l * .9 + 0.1;

    _uiBackgroundColor = TinyColor.fromHSL(
        HslColor(h: penHue, s: penSaturation, l: luminance, a: 220.0));

    _uiTextColor = _uiBackgroundColor.isDark()
        ? TinyColor(Colors.white70)
        : TinyColor(Colors.black87);

    _penColorWithoutAlpha = TinyColor.fromHSL(
        HslColor(h: penHue, s: penSaturation, l: luminance, a: 255.0));

    _primaryColor = TinyColor.fromHSL(
        HslColor(h: penHue, s: penSaturation, l: luminance, a: 255.0));

    _splashColor =
        isDark ? _uiBackgroundColor.lighten(30) : _uiBackgroundColor.darken(10);
    _highlightColor =
        isDark ? _uiBackgroundColor.lighten(5) : _uiBackgroundColor.darken(5);

    _accentColor = _primaryColor.spin(240).lighten();

    _uiTextAccentColor = _accentColor.isDark()
        ? TinyColor(Colors.white70)
        : TinyColor(Colors.black87);

    _accentSplashColor =
        isDark ? _accentColor.lighten(30) : _accentColor.darken(10);

    _appBackgroundColor =
        isDark ? backgroundColor.lighten() : backgroundColor.darken();

    _canvasShadowColor =
        isDark ? backgroundColor.lighten(20) : backgroundColor.darken(20);
  }
}
