import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorState extends ChangeNotifier {
  static ColorState _instance;

  factory ColorState.init(
      {@required TinyColor initialBackgroundColor,
      @required TinyColor initialPenColor,
      @required List<TinyColor> initialAvailablePenColors,
      @required List<TinyColor> initialAvailableCanvasColors,
      @required TinyColor lastSelectedCustomPenColor,
      @required TinyColor lastSelectedCustomCanvasColor}) {
    return _instance = ColorState._internal(
        initialBackgroundColor: initialBackgroundColor,
        initialPenColor: initialPenColor,
        initialAvailablePenColors: initialAvailablePenColors,
        initialAvailableCanvasColors: initialAvailableCanvasColors,
        lastSelectedCustomPenColor: lastSelectedCustomPenColor,
        lastSelectedCustomCanvasColor: lastSelectedCustomCanvasColor);
  }

  factory ColorState() {
    assert(_instance != null,
        'The ColorState.init() factory constructor must be called before using the ColorState() constructor.');
    return _instance;
  }

  ColorState._internal(
      {@required TinyColor initialBackgroundColor,
      @required TinyColor initialPenColor,
      @required List<TinyColor> initialAvailablePenColors,
      @required List<TinyColor> initialAvailableCanvasColors,
      @required this.lastSelectedCustomPenColor,
      @required this.lastSelectedCustomCanvasColor}) {
    _backgroundColor = initialBackgroundColor;
    _penColor = initialPenColor;
    _availablePenColors = initialAvailablePenColors;
    _unmodifiableAvailablePenColors = UnmodifiableListView(_availablePenColors);
    _availableCanvasColors = initialAvailableCanvasColors;
    _unmodifiableAvailableCanvasColors =
        UnmodifiableListView(_availableCanvasColors);

    _updateDependentColors();
  }

  InkState ink;

  /// The current background color of the canvas
  TinyColor _backgroundColor;
  TinyColor get backgroundColor => _backgroundColor;
  set backgroundColor(TinyColor value) {
    _backgroundColor = value;
    _updateDependentColors();
    showCanvasColorDeleteButtons = false;
    notifyListeners();
  }

  /// The current color of the pen
  TinyColor _penColor;
  TinyColor get penColor => _penColor;
  set penColor(TinyColor value) {
    _penColor = value;
    _updateDependentColors();
    ink.finishLine();
    showPenColorDeleteButtons = false;
    notifyListeners();
  }

  /// Whether or not to show the delete button on the pen colors
  bool get showPenColorDeleteButtons => _showPenColorDeleteButtons;
  bool _showPenColorDeleteButtons = false;
  set showPenColorDeleteButtons(bool value) {
    _showPenColorDeleteButtons = value;
    notifyListeners();
  }

  /// Whether or not to show the delete button on the canvas colors
  bool get showCanvasColorDeleteButtons => _showCanvasColorDeleteButtons;
  bool _showCanvasColorDeleteButtons = false;
  set showCanvasColorDeleteButtons(bool value) {
    _showCanvasColorDeleteButtons = value;
    notifyListeners();
  }

  /// The last custom canvas color selected in the color picker dialog
  TinyColor lastSelectedCustomCanvasColor;

  /// The last custom pen color selected in the color picker dialog
  TinyColor lastSelectedCustomPenColor;

  List<TinyColor> _availablePenColors;
  UnmodifiableListView<TinyColor> _unmodifiableAvailablePenColors;
  List<TinyColor> get availablePenColors => _unmodifiableAvailablePenColors;

  /// Adds a new color to the end of the list of available
  /// pen colors and selects it
  void addAndSelectPenColor(TinyColor color) {
    _availablePenColors.add(color);
    penColor = color;
    lastSelectedCustomPenColor = color;
    notifyListeners();
  }

  /// Removes an existing colors from the list of available pen colors
  void removePenColor(TinyColor color) {
    _availablePenColors.remove(color);
    notifyListeners();
  }

  List<TinyColor> _availableCanvasColors;
  UnmodifiableListView<TinyColor> _unmodifiableAvailableCanvasColors;
  List<TinyColor> get availableCanvasColors =>
      _unmodifiableAvailableCanvasColors;

  /// Adds a new color to the end of the list of available
  /// canvas colors and selects it
  void addAndSelectCanvasColor(TinyColor color) {
    _availableCanvasColors.add(color);
    backgroundColor = color;
    lastSelectedCustomCanvasColor = color;
    notifyListeners();
  }

  /// Removes an existing colors from the list of available canvas colors
  void removeCanvasColor(TinyColor color) {
    _availableCanvasColors.remove(color);
    notifyListeners();
  }

  bool get isDark => _backgroundColor.isDark();

  /// The background color of UI elements (buttons, tabs, modals, etc)
  TinyColor get uiBackgroundColor => _uiBackgroundColor;
  TinyColor _uiBackgroundColor;

  /// The color of the text in the UI
  TinyColor get uiTextColor => _uiTextColor;
  TinyColor _uiTextColor;

  /// The color of the buttons in the UI
  TinyColor get buttonColor => _buttonColor;
  TinyColor _buttonColor;

  /// The color of "active" (selected) UI elements
  TinyColor get activeColor => _activeColor;
  TinyColor _activeColor;

  /// The color of text on "active" (selected) UI elements
  TinyColor get activeTextColor => _activeTextColor;
  TinyColor _activeTextColor;

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

    _uiBackgroundColor =
        isDark ? TinyColor(Color(0xCC555555)) : TinyColor(Color(0xCCCCCCCC));

    _uiTextColor =
        isDark ? TinyColor(Colors.white70) : TinyColor(Colors.black87);

    _buttonColor =
        isDark ? _uiBackgroundColor.lighten() : _uiBackgroundColor.darken();

    _activeColor =
        isDark ? TinyColor(Color(0xCCFFFFFF)) : TinyColor(Color(0xAA333333));

    _activeTextColor =
        isDark ? TinyColor(Colors.black) : TinyColor(Colors.white);

    _primaryColor = TinyColor.fromHSL(
        HslColor(h: penHue, s: penSaturation, l: luminance, a: 255.0));

    _splashColor =
        isDark ? _uiBackgroundColor.lighten(30) : _uiBackgroundColor.darken(30);

    _highlightColor = TinyColor(Colors.transparent);

    _accentColor = _primaryColor.spin(240).lighten();

    _accentSplashColor =
        isDark ? _accentColor.lighten(30) : _accentColor.darken(10);

    _appBackgroundColor =
        isDark ? backgroundColor.lighten() : backgroundColor.darken();

    _canvasShadowColor =
        isDark ? backgroundColor.lighten(20) : backgroundColor.darken(20);
  }
}
