import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  static SettingsState _instance;

  factory SettingsState.init() {
    return _instance = SettingsState._internal();
  }

  factory SettingsState() {
    assert(_instance != null,
        'The SettingsState.init() factory constructor must be called before using the SettingsState() constructor.');
    return _instance;
  }

  SettingsState._internal();

  /// Whether or not to show various debugging aids
  bool get debug => _debug;
  bool _debug = !kReleaseMode;
  set debug(bool value) {
    _debug = value;
    notifyListeners();
  }

  /// Whether or not to include the background color when saving images
  bool get includeBackgroundWhenSaving => _includeBackgroundWhenSaving;
  bool _includeBackgroundWhenSaving = true;
  set includeBackgroundWhenSaving(bool value) {
    _includeBackgroundWhenSaving = value;
    notifyListeners();
  }

  /// Whether or not to close the drawing tools drawer (and keep it closed)
  /// when either gear is dragged
  bool get closeDrawingToolsDrawerOnDrag => _closeDrawingToolsDrawerOnDrag;
  bool _closeDrawingToolsDrawerOnDrag = false;
  set closeDrawingToolsDrawerOnDrag(bool value) {
    _closeDrawingToolsDrawerOnDrag = value;
    notifyListeners();
  }
}
