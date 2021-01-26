import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

class RotatingGearState extends BaseGearState {
  static RotatingGearState _instance;

  factory RotatingGearState.init(
      {@required double initialAngle,
      @required GearDefinition initialDefinition}) {
    return _instance = RotatingGearState._internal(
        initialAngle: initialAngle, initialDefinition: initialDefinition);
  }

  factory RotatingGearState() {
    assert(_instance != null,
        'The RotatingGearState.init() factory constructor must be called before using the RotatingGearState() constructor.');
    return _instance;
  }

  RotatingGearState._internal(
      {@required double initialAngle,
      @required GearDefinition initialDefinition}) {
    definition = initialDefinition;
    _initialAngle = initialAngle;
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

    position = _rotateToAngle(_initialAngle);

    _hasInitializedPosition = true;
  }

  FixedGearState fixedGear;
  DragLineState dragLine;

  double currentAngle = 0;

  fixedGearDrag(Offset rotatingGearDelta) {
    position -= rotatingGearDelta;
  }

  gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      position = _rotateToAngle(dragLine.angle);
    }
  }

  Offset _rotateToAngle(double angle) {
    double fixedGearTooth = fixedGear.definition.angleToTooth(angle);

    fixedGear.contactPoint = fixedGear.definition
        .toothToContactPoint(fixedGearTooth)
        .translated(fixedGear.position);

    ContactPoint rotatingGearRelativeContactPoint =
        definition.toothToContactPoint(fixedGearTooth, isRotating: true);

    rotation = rotatingGearRelativeContactPoint.direction -
        fixedGear.contactPoint.direction;

    Offset rotatingGearPosition = (fixedGear.contactPoint.position +
            rotatingGearRelativeContactPoint.position)
        .rotated(rotation, fixedGear.contactPoint.position);

    contactPoint = rotatingGearRelativeContactPoint
        .translated(rotatingGearPosition)
        .rotated(-rotation + pi, fixedGear.contactPoint.position);

    return rotatingGearPosition;
  }
}
