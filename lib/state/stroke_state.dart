import 'package:flutter/material.dart';
import 'package:inspiral/models/stroke_style.dart';
import 'package:inspiral/state/helpers/get_stroke_state_for_version.dart';
import 'package:inspiral/state/persistors/stroke_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';

class StrokeState extends InspiralStateObject {
  static StrokeState? _instance;

  factory StrokeState.init() {
    return _instance = StrokeState._internal();
  }

  factory StrokeState() {
    assert(_instance != null,
        'The StrokeState.init() factory constructor must be called before using the StrokeState() constructor.');
    return _instance!;
  }

  StrokeState._internal() : super();

  /// The current width of the line
  late double _width;
  double get width => _width;

  /// The current style of the line
  late StrokeStyle _style;
  StrokeStyle get style => _style;

  /// Updates the width and style of the current stroke
  void setStroke({required double width, required StrokeStyle style}) {
    _width = width;
    _style = style;
    allStateObjects.ink.finishLine();
    allStateObjects.undoRedo.createQuickSnapshotBeforeNextDraw = true;
    notifyListeners();
  }

  @override
  Future<void> undo(int version) async {
    _applyStateSnapshot(await getStrokeStateForVersion(version));
  }

  @override
  Future<void> redo(int version) async {
    _applyStateSnapshot(await getStrokeStateForVersion(version));
  }

  @override
  void persist(Batch batch) {
    StrokeStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    _applyStateSnapshot(await StrokeStatePersistor.rehydrate(db, this));
  }

  // This method is very similar to `setStroke` above, with one small
  // difference - it doesn't call `allStateObjects.ink.finishLine()`.
  void _applyStateSnapshot(StrokeStateSnapshot snapshot) {
    _width = snapshot.width;
    _style = snapshot.style;

    notifyListeners();
  }
}
