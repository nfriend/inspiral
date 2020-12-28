import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';

abstract class BaseGearModel extends ChangeNotifier {
  BaseGearModel(
      {@required Offset initialOffset,
      @required GearDefinition initialGearDefinition}) {
    this._offset = initialOffset;
    this._gearDefinition = initialGearDefinition;
  }

  Offset _offset;
  Offset get offset => _offset;
  set offset(Offset value) {
    _offset = value;
    notifyListeners();
  }

  GearDefinition _gearDefinition;
  GearDefinition get gearDefinition => _gearDefinition;
  set gearDefinition(GearDefinition value) {
    _gearDefinition = value;
    notifyListeners();
  }

  Offset dragOffset = Offset(0, 0);

  /// The "device ID" of the pointer doing the dragging
  /// A value of -1 indicates that the gear is not
  /// currently being dragged.
  int draggingPointerId = -1;

  /// The number of currently active pointers
  int pointerCount = 0;

  /// Whether or not the gear is currently being dragged
  bool get isDragging => draggingPointerId > -1 && pointerCount == 1;

  gearPointerDown(PointerDownEvent event) {
    if (!isDragging) {
      draggingPointerId = event.device;

      dragOffset = event.position - offset;
    }
  }

  globalPointerDown(PointerDownEvent event) {
    pointerCount++;
  }

  globalPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && pointerCount == 1) {
      offset = event.position - dragOffset;
    }
  }

  globalPointerUp(PointerUpEvent event) {
    pointerCount--;

    if (event.device == draggingPointerId) {
      draggingPointerId = -1;
    }
  }
}
