import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';

class RotatingGearProvider extends BaseGearProvider {
  RotatingGearProvider(
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

  FixedGearProvider fixedGear;
  DragLineProvider dragLine;

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

    rotation = rotatingGearRelativeContactPoint.direction +
        fixedGear.contactPoint.direction -
        2 * angle;

    Offset rotatingGearPosition = (fixedGear.contactPoint.position +
            rotatingGearRelativeContactPoint.position)
        .rotated(rotation, fixedGear.contactPoint.position);

    contactPoint = rotatingGearRelativeContactPoint
        .translated(rotatingGearPosition)
        .rotated(-rotation + pi, fixedGear.contactPoint.position);

    return rotatingGearPosition;
  }
}
