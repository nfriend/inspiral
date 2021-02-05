import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/dry_ink_canvas.dart';

class InkState extends ChangeNotifier {
  static InkState _instance;

  factory InkState.init() {
    return _instance = InkState._internal();
  }

  factory InkState() {
    assert(_instance != null,
        'The InkState.init() factory constructor must be called before using the InkState() constructor.');
    return _instance;
  }

  InkState._internal();

  List<Offset> _points = [];
  bool _isBaking = false;
  Map<Offset, Image> _tileImages = {};

  /// The total number of points included in the the drawing.
  int get currentPointCount => _points.length;

  /// All tile images that make up the "dried" ink.
  /// Each tile image is accessed by a key, which is
  /// the position of the tile's top-left corner in canvas coordinates.
  Map<Offset, Image> get tileImages => _tileImages;

  /// A list of Path objects that describe the lines drawn on the Canvas
  List<Offset> get points => _points;

  /// Add a point to the current line.
  /// If there is no current line, a new line is started.
  void addPoint(Offset point) {
    _points.add(point);

    if (currentPointCount > 1000) {
      _bakeImage();
    }

    notifyListeners();
  }

  /// Finish the current line.
  /// Does nothing if there is no current line.
  void finishLine() {
    _bakeImage();
  }

  Future<void> _bakeImage() async {
    if (_isBaking) {
      return;
    }

    _isBaking = true;

    // Operate on a shallow clone of the points, because the baking process
    // is asynchronous, and more points may be added to `_points` while
    // this method is running
    List<Offset> bakedPoints = List<Offset>.from(_points);
    var tilesToUpdate = HashSet<Offset>();
    for (Offset point in bakedPoints) {
      Offset containingTile = Offset(
          (point.dx / tileSize.width).floor() * tileSize.width,
          (point.dy / tileSize.height).floor() * tileSize.height);
      tilesToUpdate.add(containingTile);
    }

    Size renderedSize = tileSize;
    List<Future> allUpdates = [];
    for (Offset tilePosition in tilesToUpdate) {
      var recorder = PictureRecorder();
      var canvas = Canvas(recorder);
      InkTileCanvasPainter(
              position: tilePosition,
              tileImage: tileImages[tilePosition],
              points: points)
          .paint(canvas, renderedSize);

      Picture picture = recorder.endRecording();
      allUpdates.add(picture
          .toImage(renderedSize.width.ceil(), renderedSize.height.ceil())
          .then((Image newImage) {
        tileImages[tilePosition]?.dispose();
        tileImages[tilePosition] = newImage;
      }));
    }

    await Future.wait(allUpdates);

    _points.removeRange(0, bakedPoints.length);
    notifyListeners();
    _isBaking = false;
  }
}
