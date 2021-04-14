import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/bake_image.dart';
import 'package:inspiral/state/persistors/ink_state_persistor.dart';
import 'package:inspiral/state/persistors/persistable.dart';
import 'package:inspiral/state/state.dart';
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

  List<InkLine> _lines = [];
  bool _isBaking = false;
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
    if (_isBaking) {
      return;
    }

    _isBaking = true;

    await bakeImage(
        lines: lines,
        tileImages: _tileImages,
        tilePositionToDatabaseId: _tilePositionToDatabaseId);

    _isBaking = false;

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
      ..removeWhere((key, value) => true)
      ..addAll(result.tileImages);
    _lines = result.lines;
  }
}
