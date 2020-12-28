import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/pointer_model.dart';

abstract class BaseGearModel extends ChangeNotifier {
  BaseGearModel(
      {@required Offset initialPosition,
      @required GearDefinition initialGearDefinition}) {
    this._position = initialPosition;
    this._gearDefinition = initialGearDefinition;
  }

  Offset _position;
  Offset get position => _position;
  set position(Offset value) {
    _position = value;
    notifyListeners();
  }

  GearDefinition _gearDefinition;
  GearDefinition get gearDefinition => _gearDefinition;
  set gearDefinition(GearDefinition value) {
    _gearDefinition = value;
    notifyListeners();
  }

  PointersModel pointers;

  Offset dragOffset = Offset(0, 0);

  /// The "device ID" of the pointer doing the dragging
  int draggingPointerId = -1;

  /// Whether or not the gear is currently being dragged
  bool get isDragging => draggingPointerId > -1 && pointers.count == 1;

  gearPointerDown(PointerDownEvent event) {
    if (!isDragging) {
      draggingPointerId = event.device;

      dragOffset = event.position - position;
    }
  }

  globalPointerMove(PointerMoveEvent event) {
    if (event.device == draggingPointerId && isDragging) {
      position = event.position - dragOffset;
    }
  }

  globalPointerUp(PointerUpEvent event) {
    if (event.device == draggingPointerId) {
      draggingPointerId = -1;
    }
  }
}
