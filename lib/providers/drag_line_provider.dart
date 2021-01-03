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
    pointerPosition = canvas.pixelToCanvasPosition(event.position);
  }
}
