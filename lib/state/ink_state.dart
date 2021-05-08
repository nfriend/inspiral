import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/bake_image.dart' as helpers;
import 'package:inspiral/state/persistors/ink_state_persistor.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/state/undoers/ink_state_undoer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite/sqlite_api.dart';

class InkState extends InspiralStateObject {
  static InkState _instance;

  factory InkState.init() {
    return _instance = InkState._internal();
  }

  factory InkState() {
    assert(_instance != null,
        'The InkState.init() factory constructor must be called before using the InkState() constructor.');
    return _instance;
  }

  InkState._internal() : super();

  ColorState colors;
  StrokeState stroke;
  CanvasState canvas;
  UndoRedoState undoRedo;

  final List<InkLine> _lines = [];

  final Map<Offset, Image> _tileImages = {};
  final Map<Offset, String> _tilePositionToDatabaseId = {};
  final Map<Offset, Image> _unsavedTiles = {};

  Offset _lastPoint;

  /// Whether or not this state object is currently in the "ink baking" state
  bool get isBaking => _isBaking;
  bool _isBaking = false;
  set isBaking(bool value) {
    _isBaking = value;
    notifyListeners();
  }

  /// The total number of points included in the the drawing.
  int get currentPointCount =>
      _lines.fold(0, (sum, line) => sum + line.pointCount);

  /// All tile images that make up the "dried" ink.
  /// Each tile image is accessed by a key, which is
  /// the position of the tile's top-left corner in canvas coordinates.
  Map<Offset, Image> get tileImages => _tileImages;

  /// A map of positions to the database ID of the Image data at that position
  Map<Offset, String> get tilePositionToDatabaseId => _tilePositionToDatabaseId;

  /// A map of positions to Image data that has not yet been persisted
  Map<Offset, Image> get unsavedTiles => _unsavedTiles;

  /// A list of Path objects that describe the lines drawn on the Canvas
  List<InkLine> get lines => _lines;

  /// Returns the last point of the current line, or `null`
  /// if there is no current line
  Offset get lastPoint => _lastPoint;

  /// A `Future` that allows other processes to wait until any async canvas
  /// manipulation (undo or baking) is complete and run code after.
  Future<void> pendingCanvasManipulation = Future<void>.value();

  /// Add points to the current line.
  /// If there is no current line, a new one is created.
  void addPoints(List<Offset> points) {
    if (_lines.isEmpty) {
      _lines.add(InkLine(
          color: colors.penColor.color,
          strokeWidth: stroke.width,
          strokeStyle: stroke.style));
    }

    _lines.last.addPoints(points);

    if (points.isNotEmpty) {
      _lastPoint = points.last;
    }

    if (currentPointCount > 1000) {
      bakeImage();
    }

    notifyListeners();
  }

  /// Finish the current line.
  /// Does nothing if there is no current line.
  void finishLine() {
    if (_lines.isNotEmpty) {
      _lines.add(InkLine(
          color: colors.penColor.color,
          strokeWidth: stroke.width,
          strokeStyle: stroke.style));
      bakeImage();
    }

    _lastPoint = null;
  }

  /// Triggers all un-baked points to be rasterized into the background tiles.
  /// If there is already another `bakeImage` process in progress, this method
  /// exits immediately and does nothing.
  /// To simply trigger a `bakeImage` without caring about when it finishes,
  /// call `_bakeImage` synchronously:
  ///
  /// ink.bakeImage();
  ///
  /// If instead it's important that a process wait until the image is fully
  /// baked (for example, when sharing or saving an image),
  /// first await `pendingCanvasManipulation`, and then await `bakeImage`:
  ///
  /// await ink.pendingCanvasManipulation;
  /// await ink.bakeImage;
  ///
  /// This will gaurantee all unbaked points (at call time) have been baked
  /// into the background tile images.
  ///
  /// Important note: the two lines above don't gaurantee the tiles
  /// have been rendered to the screen. See how this is done in
  /// `save_share_image.dart` using `addPostFrameCallback`
  /// for a complete example.
  Future<void> bakeImage() async {
    if (isBaking ||
        undoRedo.isUndoing ||
        lines.isEmpty ||
        currentPointCount == 0) {
      return;
    }

    isBaking = true;

    var pendingCanvasManipulationCompleter = Completer();
    pendingCanvasManipulation = pendingCanvasManipulationCompleter.future;

    notifyListeners();

    try {
      var updatedTiles = await helpers.bakeImage(
          lines: lines,
          tileImages: _tileImages,
          tilePositionToDatabaseId: _tilePositionToDatabaseId,
          tileSize: canvas.tileSize);

      // Add all the updated tiles to the list of "unsaved" tiles.
      // These tiles will be persisted very soon when the "snapshot"
      // method is triggered by the call to "createSnapshot" below.
      _unsavedTiles.addAll(updatedTiles);

      await undoRedo.createSnapshot();
    } catch (err, stackTrace) {
      // Explicitly catching/handling errors here since `bakeImage` is often
      // called in synchronous contexts, and the return value is ignored.
      // This causes errors to be silently swallowed.
      print('an error occured while baking the image: $err');
      await Sentry.captureException(err, stackTrace: stackTrace);
    } finally {
      // Regardless of success or failure, set `isBaking` back to `false`
      // to prevent blocking future calls to `isBaking`.
      isBaking = false;

      notifyListeners();

      pendingCanvasManipulationCompleter.complete();
    }
  }

  /// Erases the canvas, including both baked and unbaked lines.
  void eraseCanvas() {
    if (isBaking || undoRedo.isUndoing) {
      return;
    }

    // This operation is synchronous, so no need to involve
    // `pendingCanvasManipulation` here

    _tileImages.removeAll();
    _tilePositionToDatabaseId.removeAll();
    _lines.removeAll();
    undoRedo.clearAllSnapshots();

    notifyListeners();

    bakeImage();
  }

  @override
  Future<void> undo(int version) async {
    var pendingCanvasManipulationCompleter = Completer();
    pendingCanvasManipulation = pendingCanvasManipulationCompleter.future;

    notifyListeners();

    await InkStateUndoer.undo(version, this);

    notifyListeners();

    pendingCanvasManipulationCompleter.complete();
  }

  @override
  Future<void> redo(int version) async {
    var pendingCanvasManipulationCompleter = Completer();
    pendingCanvasManipulation = pendingCanvasManipulationCompleter.future;

    notifyListeners();

    await InkStateUndoer.redo(version, this);

    notifyListeners();

    pendingCanvasManipulationCompleter.complete();
  }

  @override
  Future<void> snapshot(int version, Batch batch) async {
    await InkStateUndoer.snapshot(version, batch, this);
  }

  @override
  Future<void> cleanUpOldRedoSnapshots(int version, Batch batch) async {
    await InkStateUndoer.cleanUpOldRedoSnapshots(version, batch);
  }

  @override
  void persist(Batch batch) {
    InkStatePersistor.persist(batch, this);
  }

  @override
  Future<void> rehydrate(Database db, BuildContext context) async {
    var result = await InkStatePersistor.rehydrate(db, this);
    _tileImages
      ..removeAll()
      ..addAll(result.tileImages);
    _lines
      ..removeAll()
      ..addAll(result.lines);
    _tilePositionToDatabaseId
      ..removeAll()
      ..addAll(result.tilePositionToDatabaseId);
  }
}
