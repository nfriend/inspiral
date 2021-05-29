import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/line.dart';
import 'package:inspiral/state/helpers/get_drag_line_state_for_version.dart';
import 'package:inspiral/state/persistors/drag_line_state_persistor.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';

final double _pi2 = 2 * pi;

class DragLineState extends InspiralStateObject {
  static DragLineState? _instance;

  factory DragLineState.init() {
    return _instance = DragLineState._internal();
  }

  factory DragLineState() {
    assert(_instance != null,
        'The DragLineState.init() factory constructor must be called before using the DragLineState() constructor.');
    return _instance!;
  }

  DragLineState._internal() : super();

  Offset _pointerPosition = Offset.zero;

  /// Gets the position of the pointer, in canvas coordinates
  Offset get pointerPosition => _pointerPosition;
  set pointerPosition(Offset value) {
    _pointerPosition = value;
    notifyListeners();
  }

  Offset _pivotPositionInCanvasCoordinates = Offset.zero;

  /// Gets the position of the pivot, in canvas coordinates
  Offset get pivotPosition => _pivotPositionInCanvasCoordinates;
  set pivotPosition(Offset value) {
    _pivotPositionInCanvasCoordinates = value;
    notifyListeners();
  }

  double _angle = 0;
  double get angle => _angle;
  set angle(double value) {
    _angle = value;
    notifyListeners();
  }

  /// Keeps track of the difference between the angle between the gears
  /// and the angle between the fixed gear and the pointer when the
  /// gear was first dragged. This prevents the gear from "jumping" when
  /// the drag begins.
  double _angleDragOffset = 0;

  void gearPointerDown(PointerDownEvent event) {
    // Disable any gear interactions if we're currently auto-drawing
    if (allStateObjects.rotatingGear.isAutoDrawing) {
      return;
    }

    var pointerAngle = _getPointerAngle(event);
    _angleDragOffset = pointerAngle - _translateToRange(angle);
    _updatePointerPositionAndAngle(event);
  }

  void gearPointerMove(PointerMoveEvent event) {
    // Disable any gear interactions if we're currently auto-drawing
    if (allStateObjects.rotatingGear.isAutoDrawing) {
      return;
    }

    _updatePointerPositionAndAngle(event);
  }

  void fixedGearDrag(Offset rotatingGearDelta) {
    pivotPosition -= rotatingGearDelta;
  }

  void _updatePointerPositionAndAngle(PointerEvent event) {
    pointerPosition =
        allStateObjects.canvas.pixelToCanvasPosition(event.position);

    // The current angle, translated in the range [0, 2*pi)
    var translatedAngle = _translateToRange(angle);

    // The new angle, translated into the same range
    var translatedNewAngle =
        _translateToRange(_getPointerAngle(event) - _angleDragOffset);

    // This is how many times we've fully rotated (in the positive direction)
    // around the fixed gear. Can be positive or negative.
    var rotationCount = (angle / _pi2).floor();

    var newAngle = translatedNewAngle + rotationCount * _pi2;

    // Detect when we wrap around from 0 to 2*pi or vice versa,
    // and update the angle accordingly
    if ((translatedNewAngle - translatedAngle).abs() > pi) {
      if (translatedNewAngle > translatedAngle) {
        // We crossed over the X axis in the negative direction
        // (e.g. from 0.1 to 6.1)
        newAngle -= _pi2;
      } else {
        // We crossed over the X axis in the positive direction
        // (e.g. from 6.1 to 0.1)
        newAngle += _pi2;
      }
    }

    angle = newAngle;
  }

  /// Gets the angle between the pointer and the pivot position
  double _getPointerAngle(PointerEvent event) {
    var eventPosition =
        allStateObjects.canvas.pixelToCanvasPosition(event.position);
    final lineAngle = Line(pivotPosition, eventPosition).angle();

    var conditionalReverse =
        allStateObjects.fixedGear.definition.isRing ? 1 : -1;

    return _translateToRange(lineAngle) * conditionalReverse;
  }

  /// Translates an angle (in radians) into the range [0, 2pi)
  double _translateToRange(double angle) {
    return angle % _pi2;
  }

  @override
  Future<void> undo(int version) async {
    _applyStateSnapshot(
        await getDragLineStateForVersion(version, allStateObjects));
  }

  @override
  Future<void> redo(int version) async {
    _applyStateSnapshot(
        await getDragLineStateForVersion(version, allStateObjects));
  }

  @override
  void persist(Batch batch) {
    DragLineStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    _applyStateSnapshot(await DragLineStatePersistor.rehydrate(db, this));
  }

  void _applyStateSnapshot(DragLineStateSnapshot snapshot) {
    _pivotPositionInCanvasCoordinates = snapshot.pivotPosition;
    _angle = snapshot.angle;

    notifyListeners();
  }
}
