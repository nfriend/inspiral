import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

class ColorState extends BaseState {
  static ColorState _instance;

  factory ColorState.init(
      {@required TinyColor lastSelectedCustomPenColor,
      @required TinyColor lastSelectedCustomCanvasColor}) {
    return _instance = ColorState._internal(
        lastSelectedCustomPenColor: lastSelectedCustomPenColor,
        lastSelectedCustomCanvasColor: lastSelectedCustomCanvasColor);
  }

  factory ColorState() {
    assert(_instance != null,
        'The ColorState.init() factory constructor must be called before using the ColorState() constructor.');
    return _instance;
  }

  ColorState._internal(
      {@required this.lastSelectedCustomPenColor,
      @required this.lastSelectedCustomCanvasColor})
      : super() {
    _backgroundColor = TinyColor(Colors.white);
    _penColor = TinyColor(Colors.transparent);
    _availablePenColors = [];
    _unmodifiableAvailablePenColors = UnmodifiableListView(_availablePenColors);
    _availableCanvasColors = [];
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
    notifyListeners();
  }

  /// The current color of the pen
  TinyColor _penColor;
  TinyColor get penColor => _penColor;
  set penColor(TinyColor value) {
    _penColor = value;
    _updateDependentColors();
    ink.finishLine();
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
    int colorIndex = _availablePenColors.indexOf(color);
    bool colorWasRemoved = _availablePenColors.remove(color);

    if (penColor == color && colorWasRemoved) {
      if (_availablePenColors.length > 0) {
        // If there are still colors left, select the next closest color
        int newColorIndex = min(colorIndex, _availablePenColors.length - 1);
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
    lastSelectedCustomCanvasColor = color;
    notifyListeners();
  }

  /// Removes an existing colors from the list of available canvas colors
  void removeCanvasColor(TinyColor color) {
    int colorIndex = _availableCanvasColors.indexOf(color);
    bool colorWasRemoved = _availableCanvasColors.remove(color);

    if (backgroundColor == color && colorWasRemoved) {
      if (_availableCanvasColors.length > 0) {
        int newColorIndex = min(colorIndex, _availableCanvasColors.length - 1);
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

  @override
  Future<void> persist() async {
    Database db = await getDatabase();

    await db.delete(Schema.colors.toString());

    int activePenColorId, activeCanvasColorId;

    for (TinyColor color in availablePenColors) {
      int colorId = await db.insert(Schema.colors.toString(), {
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.pen
      });

      if (penColor == color) {
        activePenColorId = colorId;
      }
    }

    for (TinyColor color in availableCanvasColors) {
      int colorId = await db.insert(Schema.colors.toString(), {
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.canvas
      });

      if (backgroundColor == color) {
        activeCanvasColorId = colorId;
      }
    }

    await db.insert(Schema.state.toString(), {
      Schema.state.selectedPenColor: activePenColorId,
      Schema.state.selectedCanvasColor: activeCanvasColorId
    });
  }

  @override
  Future<void> rehydrate() async {
    Database db = await getDatabase();

    // Remove all the current items from the list
    _availablePenColors.removeWhere((_) => true);

    final List<Map<String, dynamic>> rows =
        await db.query(Schema.colors.toString());

    for (Map<String, dynamic> attrs in rows) {
      TinyColor newColor =
          TinyColor(Color(int.parse(attrs[Schema.colors.value], radix: 16)));

      if (attrs[Schema.colors.type] == ColorsTableType.pen) {
        _availablePenColors.add(newColor);
      } else if (attrs[Schema.colors.type] == ColorsTableType.canvas) {
        _availableCanvasColors.add(newColor);
      }
    }

    Map<String, dynamic> state = (await db.rawQuery('''
      SELECT
        c1.${Schema.colors.value} AS ${Schema.state.selectedPenColor},
        c2.${Schema.colors.value} AS ${Schema.state.selectedCanvasColor}
      FROM
        ${Schema.state} s
      JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.selectedPenColor}
      JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.selectedCanvasColor}
    ''')).first;

    penColor = _availablePenColors.firstWhere(
        (color) => color.toHexString() == state[Schema.state.selectedPenColor],
        orElse: () => TinyColor(Colors.transparent));
    backgroundColor = _availableCanvasColors.firstWhere(
        (color) =>
            color.toHexString() == state[Schema.state.selectedCanvasColor],
        orElse: () => TinyColor(Colors.white));

    _updateDependentColors();

    notifyListeners();
  }
}
