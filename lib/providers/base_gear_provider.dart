import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';

abstract class BaseGearProvider extends ChangeNotifier {
  BaseGearProvider(
      {@required Offset initialPosition,
      @required GearDefinition initialGearDefinition}) {
    this._position = initialPosition;
    this._definition = initialGearDefinition;
  }

  Offset _position;
  Offset get position => _position;
  set position(Offset value) {
    _position = value;
    notifyListeners();
  }

  GearDefinition _definition;
  GearDefinition get definition => _definition;
  set definition(GearDefinition value) {
    _definition = value;
    notifyListeners();
  }

  PointersProvider pointers;

  CanvasProvider canvas;

  Offset dragOffset = Offset.zero;

  /// The "device ID" of the pointer doing the dragging
  int draggingPointerId = -1;

  /// Whether or not the gear is currently being dragged
  bool get isDragging => draggingPointerId > -1 && pointers.count == 1;

  gearPointerDown(PointerDownEvent event) {
    if (!isDragging) {
      draggingPointerId = event.device;

      dragOffset = event.localPosition - position;
    }
  }

  globalPointerDown(PointerDownEvent event) {
    if (pointers.count == 2) {
      draggingPointerId = -1;
    }
  }

  gearPointerUp(PointerUpEvent event) {
    if (event.device == draggingPointerId) {
      draggingPointerId = -1;
    }
  }
}
