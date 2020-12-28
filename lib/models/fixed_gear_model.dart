import 'package:flutter/material.dart';
import 'package:inspiral/models/base_gear_model.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/rotating_gear_model.dart';

class FixedGearModel extends BaseGearModel {
  FixedGearModel({
    @required Offset initialOffset,
    @required GearDefinition initialGearDefinition,
  }) : super(
            initialPosition: initialOffset,
            initialGearDefinition: initialGearDefinition);

  RotatingGearModel rotatingGear;

  @override
  globalPointerMove(PointerMoveEvent event) {
    if (this.isDragging) {
      rotatingGear.fixedGearDrag(position - (event.position - dragOffset));
    }

    super.globalPointerMove(event);
  }
}
