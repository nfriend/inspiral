import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';

// An arbitrary number that allows even the biggest gear
// combination to always be draggable.
final double allowedDistanceFromCanvasEdge = 900.0;
final Rect dragBounds = Rect.fromLTRB(
    -allowedDistanceFromCanvasEdge,
    -allowedDistanceFromCanvasEdge,
    canvasSize.width + allowedDistanceFromCanvasEdge,
    canvasSize.height + allowedDistanceFromCanvasEdge);

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
  }) : super() {
    definition = initialDefinition;
    position = initialPosition;
  }

  RotatingGearState rotatingGear;
  DragLineState dragLine;
  InkState ink;

  gearPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      final Offset newPosition =
          (canvas.pixelToCanvasPosition(event.position) - dragOffset)
              .clamp(dragBounds);

      rotatingGear.fixedGearDrag(position - newPosition);
      dragLine.fixedGearDrag(position - newPosition);
      position = newPosition;
    }
  }

  /// Swaps the current fixed gear for a new one
  void selectNewGear(GearDefinition newGear) {
    this.definition = newGear;
    this.rotatingGear.initializePosition();
    ink.finishLine();
  }
}
