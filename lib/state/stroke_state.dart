import 'package:flutter/material.dart';
import 'package:inspiral/state/persistors/stroke_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:sqflite/sqlite_api.dart';

class StrokeState extends InspiralStateObject {
  static StrokeState _instance;

  factory StrokeState.init() {
    return _instance = StrokeState._internal();
  }

  factory StrokeState() {
    assert(_instance != null,
        'The StrokeState.init() factory constructor must be called before using the StrokeState() constructor.');
    return _instance;
  }

  StrokeState._internal() : super();

  InkState ink;

  /// The current width of the line
  double _width;
  double get width => _width;

  /// The current style of the line
  StrokeStyle _style;
  StrokeStyle get style => _style;

  /// Updates the width and style of the current stroke
  void setStroke({double width, StrokeStyle style}) {
    _width = width;
    _style = style;
    ink.finishLine();
    notifyListeners();
  }

  @override
  void persist(Batch batch) {
    StrokeStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    var result = await StrokeStatePersistor.rehydrate(db, this);

    setStroke(style: result.style, width: result.width);
  }
}
