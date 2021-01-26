import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/line.dart';
import 'package:inspiral/state/state.dart';

class DragLineState extends ChangeNotifier {
  static DragLineState _instance;

  factory DragLineState.init({@required Offset initialPosition}) {
    return _instance =
        DragLineState._internal(initialPosition: initialPosition);
  }

  factory DragLineState() {
    assert(_instance != null,
        'The DragLineState.init() factory constructor must be called before using the DragLineState() constructor.');
    return _instance;
  }

  DragLineState._internal({
    @required Offset initialPosition,
  }) {
    _pivotPositionInCanvasCoordinates = initialPosition;
  }

  CanvasState canvas;

  RotatingGearState rotatingGear;

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

  gearPointerDown(PointerDownEvent event) {
    _updatePointerPositionAndAngle(event);
  }

  gearPointerMove(PointerMoveEvent event) {
    _updatePointerPositionAndAngle(event);
  }

  fixedGearDrag(Offset rotatingGearDelta) {
    pivotPosition -= rotatingGearDelta;
  }

  _updatePointerPositionAndAngle(PointerEvent event) {
    pointerPosition = canvas.pixelToCanvasPosition(event.position);
    final lineAngle = Line(pivotPosition, pointerPosition).angle();

    // Translate the angle into the range [0, 2)
    angle = (lineAngle * -1 + (2 * pi)) % (2 * pi);
  }
}
