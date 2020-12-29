import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

class FixedGearModel extends BaseGearModel {
  FixedGearModel({
    @required Offset initialOffset,
    @required GearDefinition initialGearDefinition,
  }) : super(
            initialPosition: initialOffset,
            initialGearDefinition: initialGearDefinition);

  RotatingGearModel rotatingGear;

  @override
  globalPointerMove(Offset pointerPosition, PointerMoveEvent event) {
    if (this.isDragging) {
      rotatingGear.fixedGearDrag(position - (pointerPosition - dragOffset));
    }

    super.globalPointerMove(pointerPosition, event);
  }
}
