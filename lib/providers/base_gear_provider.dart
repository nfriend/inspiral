import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/providers/providers.dart';

abstract class BaseGearProvider extends ChangeNotifier {
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

  // The most recent contact point of the gear. These value(s) _could_ be
  // computed and used internally in RotatingGearProvider, but we expose it
  // publicly here to allow it to be rendered on the debug canvas for debugging
  // purposes.
  ContactPoint _contactPoint;
  ContactPoint get contactPoint => _contactPoint;
  set contactPoint(ContactPoint value) {
    _contactPoint = value;
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
