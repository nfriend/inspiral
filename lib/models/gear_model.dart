import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';

class GearModel extends ChangeNotifier {
  GearModel(
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

  bool _isDragging;

  Offset _dragOffset;

  gearPointerDown(PointerDownEvent event) {
    _isDragging = true;

    _dragOffset = event.position - _offset;
  }

  globalPointerUp(PointerUpEvent event) {
    _isDragging = false;
  }

  globalPointerMove(PointerMoveEvent event) {
    if (_isDragging) {
      _offset = event.position - _dragOffset;

      notifyListeners();
    }
  }
}
