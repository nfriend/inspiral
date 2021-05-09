import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/line.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/util/get_center_of_mass.dart' as util;
import 'package:vector_math/vector_math_64.dart';

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

/// A class to hold a transform matrix and its individual components
@immutable
class TransformInfo {
  final Matrix4 transform;
  final Matrix4TransformDecomposition transformComponents;

  TransformInfo({@required this.transform, @required this.transformComponents});
}

class PointersState extends InspiralStateObject with WidgetsBindingObserver {
  static PointersState _instance;

  factory PointersState.init() {
    return _instance = PointersState._internal();
  }

  factory PointersState() {
    assert(_instance != null,
        'The PointersState.init() factory constructor must be called before using the PointersState() constructor.');
    return _instance;
  }

  PointersState._internal() : super() {
    // ignore: prefer_collection_literals
    _activePointerIds = LinkedHashSet<int>();

    _activePointerIdsView = UnmodifiableSetView(_activePointerIds);
    _pointerPositions = {};
    _pointerPositionsView = UnmodifiableMapView(_pointerPositions);
    _pointerPreviousPositions = {};
    _pointerPreviousPositionsView =
        UnmodifiableMapView(_pointerPreviousPositions);
    _pointerDeltas = {};
    _pointerDeltasView = UnmodifiableMapView(_pointerDeltas);

    WidgetsBinding.instance.addObserver(this);
  }

  /// When the app is paused and then resumed, reset the state of all our
  /// pointer tracking, since they are no longer up-to-date
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _activePointerIds.removeWhere((element) => true);
      _pointerPositions.removeWhere((key, value) => true);
      _pointerPreviousPositions.removeWhere((key, value) => true);
      _pointerDeltas.removeWhere((key, value) => true);

      notifyListeners();
    }
  }

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
  void pointerDown(PointerDownEvent event) {
    var pointerIsNew = _activePointerIds.add(event.pointer);
    if (pointerIsNew) {
      var canvasPointerPosition =
          allStateObjects.canvas.pixelToCanvasPosition(event.position);
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
  void pointerUp(PointerUpEvent event) {
    var pointerWasInSet = _activePointerIds.remove(event.pointer);
    if (pointerWasInSet) {
      _pointerPositions.remove(event.pointer);
      _pointerDeltas.remove(event.pointer);
      _pointerPreviousPositions.remove(event.pointer);
      notifyListeners();
    }
  }

  /// Notifies this state object about a pointer move event. See comment about
  /// `pointerDown` for additional info.
  void pointerMove(PointerMoveEvent event) {
    // For reasons I don't fully understand, it is possible (according to
    // all my Sentry error stacktraces) to have
    // _pointerPreviousPositions[event.pointer] return `null`. I don't
    // understand how or why this happens, but let's check for this edge case
    // here to prevent the errors.
    // Original issue: https://gitlab.com/nfriend/inspiral/-/issues/98.
    if (_pointerPreviousPositions[event.pointer] == null) {
      return;
    }

    if (_pointerPreviousPositions[event.pointer].global != event.position) {
      var originalLocation = _pointerPositions[event.pointer];
      var newLocation = Positions(
          canvas: allStateObjects.canvas.pixelToCanvasPosition(event.position),
          global: event.position);

      _pointerPreviousPositions[event.pointer] =
          _pointerPositions[event.pointer];
      _pointerPositions[event.pointer] = newLocation;
      _pointerDeltas[event.pointer] = newLocation - originalLocation;

      notifyListeners();
    }
  }

  /// Returns the center of mass for all currently active pointers
  Positions getCenterOfMass() {
    return Positions(
        global:
            util.getCenterOfMass(_pointerPositions.values.map((e) => e.global)),
        canvas: util
            .getCenterOfMass(_pointerPositions.values.map((e) => e.canvas)));
  }

  /// Returns the center of mass for the previous position of all
  /// currently active pointers
  Positions getPreviousCenterOfMass() {
    return Positions(
        global: util.getCenterOfMass(
            _pointerPreviousPositions.values.map((e) => e.global)),
        canvas: util.getCenterOfMass(
            _pointerPreviousPositions.values.map((e) => e.canvas)));
  }

  /// Returns a `Vector3` that represents the translation from the previous
  /// positions of the active pointers to the current positions
  Vector3 _getTranslation(
      {@required Offset centerOfMass, @required Offset previousCenterOfMass}) {
    return (centerOfMass - previousCenterOfMass).toVector3();
  }

  /// Returns a rotation (in radians, around the Z axis) that represents the
  /// rotation from the positions of the active pointers
  /// to the current positions
  double _getRotation(
      {@required Offset centerOfMass, @required Offset previousCenterOfMass}) {
    var totalDelta = _activePointerIds.fold<double>(0.0, (sum, pointerId) {
      return sum +
          Line(previousCenterOfMass,
                  _pointerPreviousPositions[pointerId].global)
              .angleTo(Line(centerOfMass, _pointerPositions[pointerId].global));
    });

    return totalDelta / count;
  }

  /// Returns a scale factor that represents the scale transform from the
  /// scale of the previous positions of the active pointers
  /// to the current positions
  double _getScale(
      {@required Offset centerOfMass, @required Offset previousCenterOfMass}) {
    var totalDelta = _activePointerIds.fold<double>(0.0, (sum, pointerId) {
      return sum +
          Line(centerOfMass, _pointerPositions[pointerId].global).length() /
              Line(previousCenterOfMass,
                      _pointerPreviousPositions[pointerId].global)
                  .length();
    });

    return totalDelta / count;
  }

  /// Returns a new scale that is avoids zooming beyond the min and max limits
  double _enforceZoomBounds(
      double scale, Matrix4TransformDecomposition currentTransformComponents) {
    // Enforce bounds on the zoom so that the user can't
    // zoom too far in or out
    if (currentTransformComponents.scale >= maxScale && scale > 1) {
      scale = maxScale / currentTransformComponents.scale;
    } else if (currentTransformComponents.scale <= minScale && scale < 1) {
      scale = minScale / currentTransformComponents.scale;
    }

    return scale;
  }

  /// Returns a new Vector3 that prevents the user from panning too far
  Vector3 _enforcePanBounds(Vector3 translation,
      Matrix4TransformDecomposition currentTransformComponents) {
    // TODO: https://gitlab.com/nfriend/inspiral/-/issues/50
    // For now, there is no limit on how far the canvas can be panned.
    // This is mitigated by the "reset view" option in the side panel,
    // which prevents users from permanently losing the canvas.
    return translation;
  }

  /// Returns a transform that should be applied to the canvas based on the
  /// previous and current positions of all active pointers
  TransformInfo getTransformInfo() {
    // Leaving this uninitialized for now, because we skip the `decompose2D()`
    // logic if `count == 1` because `_enforcePanBounds` doesn't do anything
    // (yet - see comment in the method body). Once `_enforcePanBounds` is
    // implemented, this variable will need to be initialized here.
    Matrix4TransformDecomposition currentTransformComponents;

    if (count == 1) {
      var translation =
          _pointerDeltas[_activePointerIds.first].global.toVector3();
      translation = _enforcePanBounds(translation, currentTransformComponents);
      return TransformInfo(
          transform: Matrix4.identity()..translate(translation),
          transformComponents: Matrix4TransformDecomposition(
              quaternion: Quaternion.identity(),
              scale: 1.0,
              translation: translation.toOffset()));
    } else {
      currentTransformComponents =
          allStateObjects.canvas.transform.decompose2D();

      var previousCoM = getPreviousCenterOfMass().global;
      var currentCoM = getCenterOfMass().global;

      final pivotVector = previousCoM.toVector3();

      var transform = Matrix4.identity();

      // Translate the pivot point to the origin
      transform.translate(pivotVector);

      // Scale
      var scale = _getScale(
          centerOfMass: currentCoM, previousCenterOfMass: previousCoM);
      scale = _enforceZoomBounds(scale, currentTransformComponents);
      transform.scale(scale, scale, 0);

      // Rotate
      var rotation = _getRotation(
          centerOfMass: currentCoM, previousCenterOfMass: previousCoM);
      transform.rotateZ(rotation);

      // Put the origin back in the right spot
      transform.translate(-pivotVector);

      // Translate
      var translation = _getTranslation(
          centerOfMass: currentCoM, previousCenterOfMass: previousCoM);
      translation = _enforcePanBounds(translation, currentTransformComponents);
      transform.translate(translation);

      return TransformInfo(
          transform: transform,
          transformComponents: Matrix4TransformDecomposition(
              quaternion:
                  Quaternion.axisAngle(Vector3(0.0, 0.0, 1.0), rotation),
              scale: scale,
              translation: translation.toOffset()));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
