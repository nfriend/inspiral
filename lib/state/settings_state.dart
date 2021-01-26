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

  bool _debug = !kReleaseMode;

  /// Whether or not to show various debugging aids
  bool get debug => _debug;
  set debug(bool value) {
    _debug = value;
    notifyListeners();
  }
}
