import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';

class FixedGearProvider extends BaseGearProvider {
  FixedGearProvider({
    @required Offset initialOffset,
    @required GearDefinition initialGearDefinition,
  }) : super(
            initialPosition: initialOffset,
            initialGearDefinition: initialGearDefinition);

  RotatingGearProvider rotatingGear;

  @override
  globalPointerMove(Offset pointerPosition, PointerMoveEvent event) {
    if (this.isDragging) {
      rotatingGear.fixedGearDrag(position - (pointerPosition - dragOffset));
    }

    super.globalPointerMove(pointerPosition, event);
  }
}
