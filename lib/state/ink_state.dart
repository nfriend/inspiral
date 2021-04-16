import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/bake_image.dart';
import 'package:inspiral/state/helpers/get_tiles_for_version.dart';
import 'package:inspiral/state/persistors/ink_state_persistor.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:inspiral/state/state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite/sqlite_api.dart';

class InkState extends ChangeNotifier with Persistable {
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

  final List<InkLine> _lines = [];
  bool _isBaking = false;
  bool _isUndoing = false;
  final Map<Offset, Image> _tileImages = {};
  final Map<Offset, String> _tilePositionToDatabaseId = {};
  Offset _lastPoint;

  /// The total number of points included in the the drawing.
  int get currentPointCount =>
      _lines.fold(0, (sum, line) => sum + line.pointCount);

  /// All tile images that make up the "dried" ink.
  /// Each tile image is accessed by a key, which is
  /// the position of the tile's top-left corner in canvas coordinates.
  Map<Offset, Image> get tileImages => _tileImages;

  /// A list of Path objects that describe the lines drawn on the Canvas
  List<InkLine> get lines => _lines;

  /// Returns the last point of the current line, or `null`
  /// if there is no current line
  Offset get lastPoint => _lastPoint;

  /// The most recent snapshot version number. Used to keep track of the
  /// undo/redo stack.
  int get lastSnapshotVersion => _lastSnapshotVersion;
  int _lastSnapshotVersion;

  /// Whether or not there is content that can be undone, and
  /// if it's okay to call undo right now (i.e., there are no
  /// pending operations that would prevent an undo).
  bool get undoAvailable =>
      !_isBaking &&
      !_isUndoing &&
      (lastSnapshotVersion > 0 || currentPointCount > 0);

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
      _bakeImage();
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
      _bakeImage();
    }

    _lastPoint = null;
  }

  Future<void> _bakeImage() async {
    if (_isBaking || _isUndoing || currentPointCount == 0) {
      return;
    }

    _isBaking = true;

    try {
      await bakeImage(
          lines: lines,
          tileImages: _tileImages,
          tilePositionToDatabaseId: _tilePositionToDatabaseId,
          snapshotVersion: lastSnapshotVersion + 1);

      // Wait to actually increment this variable until `bakeImage` is done.
      // This _usually_ doesn't matter, but there's potential the app could be
      // closed while `bakeImage` is running. This would trigger the state
      // object to be persisted, opening up the possibility that the version
      // will be recorded without the `bakeImage` ever finishing.
      _lastSnapshotVersion++;
    } catch (err, stackTrace) {
      // Explicitly catching/handling errors here since `_bakeImage` is often
      // called in synchronous contexts, and the return value is ignored.
      // This causes errors to be silently swallowed.
      await Sentry.captureException(err, stackTrace: stackTrace);
    } finally {
      // Regardless of success or failure, set `_isBaking` back to `false`
      // to prevent blocking future calls to `_isBaking`.
      _isBaking = false;

      notifyListeners();
    }
  }

  /// Erases the canvas, including both baked and unbaked lines.
  Future<void> eraseCanvas() async {
    _tileImages.removeAll();
    _tilePositionToDatabaseId.removeAll();
    _lines.removeAll();
    _lastSnapshotVersion = 0;

    notifyListeners();
  }

  Future<void> undo() async {
    if (_isUndoing || _isBaking) {
      return;
    }

    _isUndoing = true;

    if (currentPointCount > 0) {
      // If there are any "unbaked" points, erase these first.

      _lines.removeAll();
    } else {
      // Otherwise, rollback the actual baked tiles to a previous version

      _lastSnapshotVersion--;

      var tileVersionResult = await getTilesForVersion(lastSnapshotVersion);

      _tileImages
        ..removeAll()
        ..addAll(tileVersionResult.tileImages);
      _lines.removeAll();
      _tilePositionToDatabaseId
        ..removeAll()
        ..addAll(tileVersionResult.tilePositionToDatabaseId);
    }

    _isUndoing = false;

    notifyListeners();
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
    _lastSnapshotVersion = result.lastSnapshotVersion;
  }
}
