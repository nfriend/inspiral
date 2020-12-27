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

  bool isDragging;

  Offset dragOffset;

  gearPointerDown(PointerDownEvent event) {
    isDragging = true;

    dragOffset = event.position - offset;
  }

  globalPointerUp(PointerUpEvent event) {
    isDragging = false;
  }

  globalPointerMove(PointerMoveEvent event) {
    if (isDragging) {
      offset = event.position - dragOffset;
    }
  }
}
