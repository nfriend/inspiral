import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';

class FixedGearState extends BaseGearState {
  static FixedGearState _instance;

  factory FixedGearState.init(
      {@required Offset initialPosition,
      @required GearDefinition initialDefinition}) {
    return _instance = FixedGearState._internal(
        initialPosition: initialPosition, initialDefinition: initialDefinition);
  }

  factory FixedGearState() {
    assert(_instance != null,
        'The FixedGearState.init() factory constructor must be called before using the FixedGearState() constructor.');
    return _instance;
  }

  FixedGearState._internal({
    @required Offset initialPosition,
    @required GearDefinition initialDefinition,
  }) {
    definition = initialDefinition;
    position = initialPosition;
  }

  RotatingGearState rotatingGear;
  DragLineState dragLine;

  gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      final newPosition = event.localPosition - dragOffset;

      rotatingGear.fixedGearDrag(position - newPosition);
      dragLine.fixedGearDrag(position - newPosition);
      position = newPosition;
    }
  }

  /// Swaps the current fixed gear for a new one
  void selectNewGear(GearDefinition newGear) {
    this.definition = newGear;
    this.rotatingGear.initializePosition();
  }
}
