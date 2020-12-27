import 'package:flutter/material.dart';
import 'package:inspiral/models/base_gear_model.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
import 'package:inspiral/models/gear_definition.dart';

class RotatingGearModel extends BaseGearModel {
  RotatingGearModel(
      {@required Offset initialOffset,
      @required GearDefinition initialGearDefinition})
      : super(
            initialOffset: initialOffset,
            initialGearDefinition: initialGearDefinition);

  FixedGearModel fixedGear;

  @override
  globalPointerMove(PointerMoveEvent event) {
    if (this.isDragging) {
      fixedGear.rotatingGearDrag(offset - (event.position - dragOffset));
    }

    super.globalPointerMove(event);
  }
}
