import 'package:flutter/material.dart';

class PointersState extends ChangeNotifier {
  static PointersState _instance;

  factory PointersState.init() {
    return _instance = PointersState._internal();
  }

  factory PointersState() {
    assert(_instance != null,
        'The PointersState.init() factory constructor must be called before using the PointersState() constructor.');
    return _instance;
  }

  PointersState._internal();

  Set<int> _activePointerIds = {};

  int get count => _activePointerIds.length;

  /// Adds a pointer ID to the set of pointer IDs. `notifyListeners()`
  /// is only called if the pointer ID didn't already exist in the set.
  void _addPointer(int pointerId) {
    bool pointerIsNew = _activePointerIds.add(pointerId);
    if (pointerIsNew) {
      notifyListeners();
    }
  }

  /// Removes a pointer ID from the set of pointer IDs. `notifyListeners()`
  /// is only called if the pointer actually existed in the set.
  void _removePointer(int pointerId) {
    bool pointerWasInSet = _activePointerIds.remove(pointerId);
    if (pointerWasInSet) {
      notifyListeners();
    }
  }

  /// Notifies this state object about a pointer down event. This method
  /// can be called multiple times per event (for example, it's okay if a
  /// child and a parent _both_ call this method as a result of a single event).
  /// This should be one of the first methods called as a result of a pointer
  /// event, because it updates pointer IDs used by other state object
  /// to determine whether or not to react to pointer events.
  pointerDown(PointerDownEvent event) {
    _addPointer(event.pointer);
  }

  /// Notifies this state object about a pointer up event. See comment about
  /// `pointerDown` for additional info.
  pointerUp(PointerUpEvent event) {
    _removePointer(event.pointer);
  }
}
