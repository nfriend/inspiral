import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/line.dart';
import 'package:inspiral/state/state.dart';

final double pi2 = 2 * pi;

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
    _angleDragOffset = pointerAngle - _translateToRange(angle);
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

    // The current angle, translated in the range [0, 2*pi)
    double translatedAngle = _translateToRange(angle);

    // The new angle, translated into the same range
    double translatedNewAngle =
        _translateToRange(_getPointerAngle(event) - _angleDragOffset);

    // This is how many times we've fully rotated (in the positive direction)
    // around the fixed gear. Can be positive or negative.
    int rotationCount = (angle / pi2).floor();

    double newAngle = translatedNewAngle + rotationCount * pi2;

    // Detect when we wrap around from 0 to 2*pi or vice versa,
    // and update the angle accordingly
    if ((translatedNewAngle - translatedAngle).abs() > pi) {
      if (translatedNewAngle > translatedAngle) {
        // We crossed over the X axis in the negative direction
        // (e.g. from 0.1 to 6.1)
        newAngle -= pi2;
      } else {
        // We crossed over the X axis in the positive direction
        // (e.g. from 6.1 to 0.1)
        newAngle += pi2;
      }
    }

    angle = newAngle;
  }

  /// Gets the angle between the pointer and the pivot position
  double _getPointerAngle(PointerEvent event) {
    Offset eventPosition = canvas.pixelToCanvasPosition(event.position);
    final lineAngle = Line(pivotPosition, eventPosition).angle();

    return -_translateToRange(lineAngle);
  }

  /// Translates an angle (in radians) into the range [0, 2pi)
  double _translateToRange(double angle) {
    return angle % pi2;
  }
}
