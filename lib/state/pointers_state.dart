import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';

/// A class to hold a position in two coordinate systems
@immutable
class Positions {
  /// This position in global (logical pixel) coordinates
  final Offset global;

  /// This position in canvas coordinates
  final Offset canvas;

  Positions({@required this.global, @required this.canvas});

  /// Creates a `Positions` with both `canvas` and `global` set to `Offset.zero`
  factory Positions.zero() {
    return Positions(canvas: Offset.zero, global: Offset.zero);
  }

  Positions operator -(Positions other) {
    return Positions(
        global: global - other.global, canvas: canvas - other.canvas);
  }
}

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

  PointersState._internal() {
    _activePointerIds = LinkedHashSet<int>();
    _activePointerIdsView = UnmodifiableSetView(_activePointerIds);
    _pointerPositions = {};
    _pointerPositionsView = UnmodifiableMapView(_pointerPositions);
    _pointerPreviousPositions = {};
    _pointerPreviousPositionsView =
        UnmodifiableMapView(_pointerPreviousPositions);
    _pointerDeltas = {};
    _pointerDeltasView = UnmodifiableMapView(_pointerDeltas);
  }

  CanvasState canvas;

  LinkedHashSet<int> _activePointerIds;
  UnmodifiableSetView<int> _activePointerIdsView;
  Map<int, Positions> _pointerPositions;
  UnmodifiableMapView<int, Positions> _pointerPositionsView;
  Map<int, Positions> _pointerPreviousPositions;
  UnmodifiableMapView<int, Positions> _pointerPreviousPositionsView;
  Map<int, Positions> _pointerDeltas;
  UnmodifiableMapView<int, Positions> _pointerDeltasView;

  // The set of all active pointer IDs,
  // orderd by when the the pointer was pressed
  Set<int> get activePointerIds => _activePointerIdsView;

  /// A map of pointer ID to its last known position.
  /// Positions are in canvas coordinates.
  Map<int, Positions> get pointerPositions => _pointerPositionsView;

  /// A map of pointer ID to its second-to-last known position.
  /// Positions are in canvas coordinates.
  /// If a pointer has not yet had two positions recorded,
  /// `Offset.zero` will be returned.
  Map<int, Positions> get pointerPreviousPositions =>
      _pointerPreviousPositionsView;

  /// A map of pointer ID to its delta from its previous location.
  /// Deltas are in canvas coordinates.
  /// If the pointer has not yet moved (for example, if it has
  /// only experienced a `pointerDown`, not a `pointerMove`),
  /// its delta will be `Offset.zero`.
  Map<int, Positions> get pointerDeltas => _pointerDeltasView;

  int get count => _activePointerIds.length;

  /// Notifies this state object about a pointer down event. This method
  /// can be called multiple times per event (for example, it's okay if a
  /// child and a parent _both_ call this method as a result of a single event).
  /// This should be one of the first methods called as a result of a pointer
  /// event, because it updates pointer IDs used by other state object
  /// to determine whether or not to react to pointer events.
  pointerDown(PointerDownEvent event) {
    bool pointerIsNew = _activePointerIds.add(event.pointer);
    if (pointerIsNew) {
      Offset canvasPointerPosition =
          canvas.pixelToCanvasPosition(event.position);
      _pointerPositions[event.pointer] =
          Positions(canvas: canvasPointerPosition, global: event.position);
      _pointerDeltas[event.pointer] = Positions.zero();
      _pointerPreviousPositions[event.pointer] =
          _pointerPositions[event.pointer];
      notifyListeners();
    }
  }

  /// Notifies this state object about a pointer up event. See comment about
  /// `pointerDown` for additional info.
  pointerUp(PointerUpEvent event) {
    bool pointerWasInSet = _activePointerIds.remove(event.pointer);
    if (pointerWasInSet) {
      _pointerPositions.remove(event.pointer);
      _pointerDeltas.remove(event.pointer);
      _pointerPreviousPositions.remove(event.pointer);
      notifyListeners();
    }
  }

  /// Notifies this state object about a pointer move event. See comment about
  /// `pointerDown` for additional info.
  pointerMove(PointerMoveEvent event) {
    if (_pointerPreviousPositions[event.pointer].global != event.position) {
      Positions originalLocation = _pointerPositions[event.pointer];
      Positions newLocation = Positions(
          canvas: canvas.pixelToCanvasPosition(event.position),
          global: event.position);

      _pointerPreviousPositions[event.pointer] =
          _pointerPositions[event.pointer];
      _pointerPositions[event.pointer] = newLocation;
      _pointerDeltas[event.pointer] = newLocation - originalLocation;

      notifyListeners();
    }
  }
}
