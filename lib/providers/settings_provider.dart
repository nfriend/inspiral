import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _debug = !kReleaseMode;

  /// Whether or not to show various debugging aids
  bool get debug => _debug;
  set debug(bool value) {
    _debug = value;
    notifyListeners();
  }
}
