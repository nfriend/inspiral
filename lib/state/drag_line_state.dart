import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/line.dart';
import 'package:inspiral/state/state.dart';

class DragLineState extends ChangeNotifier {
  static DragLineState _instance;

  factory DragLineState.init(
      {@required Offset initialPosition, @required double initialAngle}) {
    return _instance = DragLineState._internal(
        initialPosition: initialPosition, initialAngle: initialAngle);
  }

  factory DragLineState() {
    assert(_instance != null,
        'The DragLineState.init() factory constructor must be called before using the DragLineState() constructor.');
    return _instance;
  }

  DragLineState._internal(
      {@required Offset initialPosition, @required double initialAngle}) {
    _pivotPositionInCanvasCoordinates = initialPosition;
    _angle = initialAngle;
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

  /// Keeps track of the difference between the angle between the gears
  /// and the angle between the fixed gear and the pointer when the
  /// gear was first dragged. This prevents the gear from "jumping" when
  /// the drag begins.
  double _angleDragOffset = 0;

  gearPointerDown(PointerDownEvent event) {
    double pointerAngle = _getPointerAngle(event);
    _angleDragOffset = pointerAngle - angle;
    _updatePointerPositionAndAngle(event);
  }

  gearPointerMove(PointerMoveEvent event) {
    _updatePointerPositionAndAngle(event);
  }

  fixedGearDrag(Offset rotatingGearDelta) {
    pivotPosition -= rotatingGearDelta;
  }

  void _updatePointerPositionAndAngle(PointerEvent event) {
    pointerPosition = canvas.pixelToCanvasPosition(event.position);
    angle = _getPointerAngle(event) - _angleDragOffset;
  }

  double _getPointerAngle(PointerEvent event) {
    pointerPosition = canvas.pixelToCanvasPosition(event.position);
    final lineAngle = Line(pivotPosition, pointerPosition).angle();

    // Translate the angle into the range [0, 2pi)
    return -lineAngle % (2 * pi);
  }
}
