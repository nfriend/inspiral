import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/helpers/get_color_state_for_version.dart';
import 'package:inspiral/state/persistors/color_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

class ColorState extends InspiralStateObject {
  static ColorState _instance;

  factory ColorState.init() {
    return _instance = ColorState._internal();
  }

  factory ColorState() {
    assert(_instance != null,
        'The ColorState.init() factory constructor must be called before using the ColorState() constructor.');
    return _instance;
  }

  ColorState._internal() : super() {
    _availablePenColors = [];
    _unmodifiableAvailablePenColors = UnmodifiableListView(_availablePenColors);
    _availableCanvasColors = [];
    _unmodifiableAvailableCanvasColors =
        UnmodifiableListView(_availableCanvasColors);
  }

  /// The current background color of the canvas
  TinyColor _backgroundColor;
  TinyColor get backgroundColor => _backgroundColor;
  set backgroundColor(TinyColor value) {
    _backgroundColor = value;
    _updateDependentColors();
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
    notifyListeners();
  }

  /// The current color of the pen
  TinyColor _penColor;
  TinyColor get penColor => _penColor;
  set penColor(TinyColor value) {
    _penColor = value;
    _updateDependentColors();
    allStateObjects.ink.finishLine();
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
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

  List<TinyColor> _availablePenColors;
  UnmodifiableListView<TinyColor> _unmodifiableAvailablePenColors;
  List<TinyColor> get availablePenColors => _unmodifiableAvailablePenColors;

  /// Adds a new color to the end of the list of available
  /// pen colors and selects it
  void addAndSelectPenColor(TinyColor color) {
    _availablePenColors.add(color);
    penColor = color;
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
    notifyListeners();
  }

  /// Removes an existing colors from the list of available pen colors
  void removePenColor(TinyColor color) {
    var colorIndex = _availablePenColors.indexOf(color);
    var colorWasRemoved = _availablePenColors.remove(color);

    if (penColor == color && colorWasRemoved) {
      allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;

      if (_availablePenColors.isNotEmpty) {
        // If there are still colors left, select the next closest color
        var newColorIndex = min(colorIndex, _availablePenColors.length - 1);
        penColor = _availablePenColors[newColorIndex];
      } else {
        penColor = TinyColor(Colors.transparent);
      }
    }

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
    allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;
    notifyListeners();
  }

  /// Removes an existing colors from the list of available canvas colors
  void removeCanvasColor(TinyColor color) {
    var colorIndex = _availableCanvasColors.indexOf(color);
    var colorWasRemoved = _availableCanvasColors.remove(color);

    if (backgroundColor == color && colorWasRemoved) {
      allStateObjects.undoRedo.createSnapshotBeforeNextDraw = true;

      if (_availableCanvasColors.isNotEmpty) {
        var newColorIndex = min(colorIndex, _availableCanvasColors.length - 1);
        backgroundColor = _availableCanvasColors[newColorIndex];
      } else {
        // We _should_ never hit this code path - the UI should prevent
        // the final color from being deleted.
        backgroundColor = TinyColor(Colors.white);
      }
    }

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

  /// The color of disabled text
  TinyColor get disabledTextColor => TinyColor(Colors.grey);

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

    _primaryColor = TinyColor(Colors.red);

    _splashColor =
        isDark ? _uiBackgroundColor.lighten(30) : _uiBackgroundColor.darken(30);

    _highlightColor = _splashColor;

    _accentColor = _primaryColor.spin(240).lighten();

    _accentSplashColor =
        isDark ? _accentColor.lighten(30) : _accentColor.darken(10);

    _appBackgroundColor =
        isDark ? backgroundColor.lighten() : backgroundColor.darken();

    _canvasShadowColor =
        isDark ? backgroundColor.lighten(20) : backgroundColor.darken(20);
  }

  // Resets all available colors and selections to their factory defaults.
  void reset() {
    _applyStateSnapshot(ColorStateSnapshot(
        availablePenColors: defaultPenColors,
        availableCanvasColors: defaultCanvasColors,
        penColor: defaultSelectedPenColor,
        canvasColor: defaultSelectedCanvasColor));
  }

  @override
  Future<void> undo(int version) async {
    _applyStateSnapshot(await getColorStateForVersion(version));
  }

  @override
  Future<void> redo(int version) async {
    _applyStateSnapshot(await getColorStateForVersion(version));
  }

  @override
  void persist(Batch batch) {
    ColorStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    _applyStateSnapshot(await ColorStatePersistor.rehydrate(db, this));
  }

  void _applyStateSnapshot(ColorStateSnapshot snapshot) {
    _availablePenColors
      ..removeAll()
      ..addAll(snapshot.availablePenColors);
    _availableCanvasColors
      ..removeAll()
      ..addAll(snapshot.availableCanvasColors);
    _penColor = snapshot.penColor;
    _backgroundColor = snapshot.canvasColor;

    _updateDependentColors();
    notifyListeners();
  }
}
