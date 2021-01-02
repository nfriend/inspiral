import 'package:flutter/material.dart';
import 'package:inspiral/providers/providers.dart';

class DragLineProvider extends ChangeNotifier {
  DragLineProvider({
    @required Offset initialOffset,
  }) {
    _pivotPositionInCanvasCoordinates = initialOffset;
  }

  CanvasProvider canvas;

  RotatingGearProvider rotatingGear;

  Offset _pointerPosition = Offset.zero;

  /// Gets the position of the pointer, in canvas coordinates
  Offset get pointerPosition => _pointerPosition;
  set pointerPosition(Offset value) {
    _pointerPosition = value;
    notifyListeners();
  }

  Offset _pivotPositionInCanvasCoordinates = Offset.zero;

  /// Gets the position of the pivot, in canvas coordinates
  Offset get pivotPosition => _pivotPositionInCanvasCoordinates;
  set pivotPosition(Offset value) {
    _pivotPositionInCanvasCoordinates = value;
    notifyListeners();
  }

  gearPointerDown(PointerDownEvent event) {
    _updatePointerPosition(event);
  }

  gearPointerMove(PointerMoveEvent event) {
    _updatePointerPosition(event);
  }

  fixedGearDrag(Offset rotatingGearDelta) {
    pivotPosition -= rotatingGearDelta;
  }

  _updatePointerPosition(PointerEvent event) {
    // event.localPosition is given relative to the gear itself (not the
    // canvas), so in order to translate this into canvas coordinates, we need
    // to add the rotating gear's position and subtract half its size.
    pointerPosition = event.localPosition +
        rotatingGear.position -
        rotatingGear.definition.size.center(Offset.zero);
  }
}
