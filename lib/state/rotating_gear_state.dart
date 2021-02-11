import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

/// A utility class to hold the results of a rotation calculation
@immutable
class RotationResult {
  /// The ContactPoint of the fixed gear
  final ContactPoint fixedGearContactPoint;

  /// The ContactPoint of the rotating gear
  final ContactPoint rotatingGearContactPoint;

  /// The position of the rotating gear
  final Offset rotatingGearPosition;

  /// The rotation of the rotating gear
  final double rotatingGearRotation;

  /// The position of the pen, relative to the canvas
  final Offset penPosition;

  const RotationResult(
      {@required this.fixedGearContactPoint,
      @required this.rotatingGearContactPoint,
      @required this.rotatingGearPosition,
      @required this.rotatingGearRotation,
      @required this.penPosition});
}

class RotatingGearState extends BaseGearState {
  static RotatingGearState _instance;

  factory RotatingGearState.init(
      {@required double initialAngle,
      @required GearDefinition initialDefinition,
      @required GearHole initialActiveHole}) {
    return _instance = RotatingGearState._internal(
        initialAngle: initialAngle,
        initialDefinition: initialDefinition,
        initialActiveHole: initialActiveHole);
  }

  factory RotatingGearState() {
    assert(_instance != null,
        'The RotatingGearState.init() factory constructor must be called before using the RotatingGearState() constructor.');
    return _instance;
  }

  RotatingGearState._internal(
      {@required double initialAngle,
      @required GearDefinition initialDefinition,
      @required GearHole initialActiveHole}) {
    definition = initialDefinition;
    _initialAngle = initialAngle;
    _lastAngle = initialAngle;
    activeHole = initialActiveHole;
  }

  // This weird initialization logic is necessary because
  // RotatingGearProvider and FixedGearProvider have references to each other,
  // so the gear's initial position can't be computed in this class's
  // constructor. So instead, this method is called by a consumer when
  // we know all dependencies have been resolved.
  bool _hasInitializedPosition = false;
  double _initialAngle;
  void initializePosition() {
    if (_hasInitializedPosition) return;

    RotationResult result = _getRotationForAngle(_initialAngle);
    _updateGearState(result);
    _lastPoint = result.rotatingGearPosition;

    _hasInitializedPosition = true;
  }

  double _lastAngle;
  Offset _lastPoint;
  Offset _relativePenPosition;

  FixedGearState fixedGear;
  DragLineState dragLine;
  InkState ink;

  GearHole _activeHole;
  GearHole get activeHole => _activeHole;
  set activeHole(GearHole value) {
    _activeHole = value;

    _relativePenPosition =
        Offset(cos(_activeHole.angle), -sin(_activeHole.angle)) *
            _activeHole.distance *
            scaleFactor;

    notifyListeners();
  }

  /// The position of the pen, relative to the center of the rotating gear
  Offset get relativePenPosition => _relativePenPosition;

  fixedGearDrag(Offset rotatingGearDelta) {
    position -= rotatingGearDelta;
  }

  gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      RotationResult result = _getRotationForAngle(dragLine.angle);
      _updateGearState(result);
      _drawPoints(result, dragLine.angle);
    }
  }

  @override
  gearPointerUp(PointerUpEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      ink.finishLine();
    }

    super.gearPointerUp(event);
  }

  /// Updates all state variables with the provide rotation calculation results
  void _updateGearState(RotationResult result) {
    rotation = result.rotatingGearRotation;
    position = result.rotatingGearPosition;

    fixedGear.contactPoint = result.fixedGearContactPoint;
    contactPoint = result.rotatingGearContactPoint;
  }

  /// Calculates the effect of a rotation to the provided angle
  RotationResult _getRotationForAngle(double angle) {
    double fixedGearTooth = fixedGear.definition.angleToTooth(angle);

    ContactPoint fixedGearContactPoint = fixedGear.definition
        .toothToContactPoint(fixedGearTooth)
        .translated(fixedGear.position);

    ContactPoint rotatingGearRelativeContactPoint =
        definition.toothToContactPoint(fixedGearTooth, isRotating: true);

    double rotatingGearRotation = rotatingGearRelativeContactPoint.direction -
        fixedGearContactPoint.direction +
        pi;

    Offset rotatingGearPosition = (fixedGearContactPoint.position +
            rotatingGearRelativeContactPoint.position)
        .rotated(rotatingGearRotation - pi, fixedGearContactPoint.position);

    double penAngle = rotatingGearRotation - activeHole.angle;
    Offset penPosition = Offset(cos(penAngle), sin(penAngle)) *
            activeHole.distance *
            scaleFactor +
        rotatingGearPosition;

    ContactPoint rotatingGearContactPoint = rotatingGearRelativeContactPoint
        .translated(rotatingGearPosition)
        .rotated(-rotatingGearRotation, fixedGearContactPoint.position);

    return RotationResult(
        rotatingGearContactPoint: rotatingGearContactPoint,
        fixedGearContactPoint: fixedGearContactPoint,
        rotatingGearPosition: rotatingGearPosition,
        rotatingGearRotation: rotatingGearRotation,
        penPosition: penPosition);
  }

  /// Draws points to the canvas based on the provided angle.
  /// If the provided point is too close to the previous point, no point is
  /// drawn. If the provided point is within the correct range of the previous
  /// point, a single point is drawn. If the provided point is too far
  /// from the previous point, a number of intermediate points are drawn
  /// to keep the drawn line from appearing choppy.
  void _drawPoints(RotationResult result, double angle) {
    double segmentLength = Line(result.penPosition, _lastPoint).length();

    // If the point is too close to the last drawn point, don't draw a new one
    if (segmentLength < minLineSegmentLength) {
      return;
    }

    // If the point is in the correct range from the last point, draw it
    if (segmentLength <= maxLineSegmentLength) {
      ink.addPoints([result.penPosition]);
      _lastAngle = angle;
      _lastPoint = result.penPosition;
      return;
    }

    // Otherwise, the point is too far away from the last point.
    // Calculate some intermediate points to avoid choppy lines.

    List<Offset> pointsToAdd = [];

    // Approximate the amount of intermediate angles we need to calculate.
    // This isn't mathematically precise - it assumes a 1:1 correlation
    // between angle size and segment size (which is not true), but it's
    // close enough for this purpose.
    int segmentsToDraw = (segmentLength / maxLineSegmentLength).ceil();
    double angleDelta = (angle - _lastAngle) / segmentsToDraw;
    for (int i = 1; i <= segmentsToDraw; i++) {
      RotationResult incrementalResult =
          _getRotationForAngle(_lastAngle + angleDelta * i);
      pointsToAdd.add(incrementalResult.penPosition);
    }

    ink.addPoints(pointsToAdd);
    _lastAngle = angle;
    _lastPoint = result.penPosition;
  }
}
