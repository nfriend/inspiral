import 'package:flutter/material.dart';
import 'package:inspiral/state/persistors/color_picker_state_persistor.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorPickerState extends ChangeNotifier with Persistable {
  static ColorPickerState _instance;

  factory ColorPickerState.init() {
    return _instance = ColorPickerState._internal();
  }

  factory ColorPickerState() {
    assert(_instance != null,
        'The ColorPickerState.init() factory constructor must be called before using the ColorPickerState() constructor.');
    return _instance;
  }

  ColorPickerState._internal() : super();

  /// The last custom pen color selected in the color picker dialog
  TinyColor get lastSelectedCustomPenColor => _lastSelectedCustomPenColor;
  TinyColor _lastSelectedCustomPenColor;
  set lastSelectedCustomPenColor(TinyColor value) {
    _lastSelectedCustomPenColor = value;
    notifyListeners();
  }

  /// The last custom canvas color selected in the color picker dialog
  TinyColor get lastSelectedCustomCanvasColor => _lastSelectedCustomCanvasColor;
  TinyColor _lastSelectedCustomCanvasColor;
  set lastSelectedCustomCanvasColor(TinyColor value) {
    _lastSelectedCustomCanvasColor = value;
    notifyListeners();
  }

  @override
  void persist(Batch batch) async {
    ColorPickerStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db) async {
    ColorPickerStateRehydrationResult result =
        await ColorPickerStatePersistor.rehydrate(db, this);

    _lastSelectedCustomPenColor = result.lastSelectedPenColor;
    _lastSelectedCustomCanvasColor = result.lastSelectedCanvasColor;
  }
}
