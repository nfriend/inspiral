import 'package:flutter/material.dart';

class InkState extends ChangeNotifier {
  static InkState _instance;

  factory InkState.init() {
    return _instance = InkState._internal();
  }

  factory InkState() {
    assert(_instance != null,
        'The InkState.init() factory constructor must be called before using the InkState() constructor.');
    return _instance;
  }

  InkState._internal();

  List<Path> _paths = [];
  Path _currentPath;

  int _totalPointCount = 0;

  /// The total number of points included in the the drawing. This is only
  /// used for debugging purposes.
  int get totalPointCount => _totalPointCount;

  /// A list of Path objects that describe the lines drawn on the Canvas
  List<Path> get paths => _paths;

  /// Add a point to the current line.
  /// If there is no current line, a new line is started.
  void addPoint(Offset point) {
    if (_currentPath == null) {
      _currentPath = Path();
      _currentPath.moveTo(point.dx, point.dy);
      _paths.add(_currentPath);
    }

    _currentPath.lineTo(point.dx, point.dy);
    _totalPointCount++;

    notifyListeners();
  }

  /// Finish the current line.
  /// Does nothing if there is no current line.
  void finishLine() {
    _currentPath = null;
  }
}
