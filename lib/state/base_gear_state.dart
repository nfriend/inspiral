import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/state/state.dart';

abstract class BaseGearState extends ChangeNotifier with Persistable {
  Offset _position = canvasCenter;
  Offset get position => _position;
  set position(Offset value) {
    _position = value;
    notifyListeners();
  }

  double _rotation = 0;
  double get rotation => _rotation;
  set rotation(double value) {
    _rotation = value;
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

  /// Whether or not this gear is visible in the UI
  bool get isVisible => _isVisible;
  bool _isVisible = true;
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  PointersState pointers;
  CanvasState canvas;
  SettingsState settings;
  SelectorDrawerState selectorDrawer;

  Offset dragOffset = Offset.zero;

  /// The "device ID" of the pointer doing the dragging
  int draggingPointerId = -1;

  /// Whether or not the gear is currently being dragged
  bool get isDragging => draggingPointerId > -1 && pointers.count == 1;

  gearPointerDown(PointerDownEvent event) {
    if (!isDragging) {
      draggingPointerId = event.device;

      dragOffset = canvas.pixelToCanvasPosition(event.position) - position;

      if (settings.closeDrawingToolsDrawerOnDrag) {
        selectorDrawer.closeDrawer();
      }

      notifyListeners();
    }
  }

  gearPointerUp(PointerUpEvent event) {
    if (event.device == draggingPointerId) {
      draggingPointerId = -1;
      notifyListeners();
    }
  }
}
