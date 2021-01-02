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
  DragLineProvider dragLine;

  gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      final newPosition = event.localPosition - dragOffset;

      rotatingGear.fixedGearDrag(position - newPosition);
      dragLine.fixedGearDrag(position - newPosition);
      position = newPosition;
    }
  }
}
