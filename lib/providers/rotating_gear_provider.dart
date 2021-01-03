import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';

class RotatingGearProvider extends BaseGearProvider {
  RotatingGearProvider({
    @required Offset initialOffset,
    @required GearDefinition initialGearDefinition,
  }) : super(
            initialPosition: initialOffset,
            initialGearDefinition: initialGearDefinition);

  FixedGearProvider fixedGear;

  DragLineProvider dragLine;

  double currentAngle = 0;

  // The contact point of the fixed gear. This value is only used internally
  // in this class, but we expose it publicly here to allow it to be rendered
  // on the debug canvas for debugging purposes.
  ContactPoint _fixedGearContactPoint;
  ContactPoint get fixedGearContactPoint => _fixedGearContactPoint;
  set fixedGearContactPoint(ContactPoint value) {
    _fixedGearContactPoint = value;
    notifyListeners();
  }

  // Same comment as above
  ContactPoint _rotatingGearContactPoint;
  ContactPoint get rotatingGearContactPoint => _rotatingGearContactPoint;
  set rotatingGearContactPoint(ContactPoint value) {
    _rotatingGearContactPoint = value;
    notifyListeners();
  }

  fixedGearDrag(Offset rotatingGearDelta) {
    position -= rotatingGearDelta;
  }

  gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      double fixedGearTooth = fixedGear.definition.angleToTooth(dragLine.angle);

      fixedGearContactPoint = fixedGear.definition
          .toothToContactPoint(fixedGearTooth)
            ..position += fixedGear.position;

      rotatingGearContactPoint = definition.toothToContactPoint(fixedGearTooth)
        ..position += position;
    }
  }
}
