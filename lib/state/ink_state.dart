import 'dart:collection';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/util/util.dart';

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

  List<InkLine> _lines = [];
  bool _isBaking = false;
  Map<Offset, Image> _tileImages = {};

  /// The total number of points included in the the drawing.
  int get currentPointCount =>
      _lines.fold(0, (sum, line) => sum + line.points.length);

  /// All tile images that make up the "dried" ink.
  /// Each tile image is accessed by a key, which is
  /// the position of the tile's top-left corner in canvas coordinates.
  Map<Offset, Image> get tileImages => _tileImages;

  /// A list of Path objects that describe the lines drawn on the Canvas
  List<InkLine> get lines => _lines;

  /// Add points to the current line.
  /// If there is no current line, a new one is created.
  void addPoints(List<Offset> points) {
    if (_lines.isEmpty) {
      _lines.add(InkLine()
        ..color = getRandomColor()
        ..strokeWidth = getRandomStrokeWidth());
    }

    _lines.last.addPoints(points);

    if (currentPointCount > 1000) {
      _bakeImage();
    }

    notifyListeners();
  }

  /// Finish the current line.
  /// Does nothing if there is no current line.
  void finishLine() {
    if (_lines.isNotEmpty) {
      _lines.add(InkLine()
        ..color = getRandomColor()
        ..strokeWidth = getRandomStrokeWidth());
      _bakeImage();
    }
  }

  Future<void> _bakeImage() async {
    if (_isBaking) {
      return;
    }

    _isBaking = true;

    // Operate on a shallow clone of the points, because the baking process
    // is asynchronous, and more points may be added to `_points` while
    // this method is running
    List<InkLine> bakedLines =
        _lines.map((line) => InkLine.from(line)).toList();

    // Determine which tiles need to update
    var tilesToUpdate = _getTilesToUpdate(bakedLines);

    Size renderedSize = tileSize;
    List<Future> allUpdates = [];
    for (Offset tilePosition in tilesToUpdate) {
      var recorder = PictureRecorder();
      var canvas = Canvas(recorder);
      DryInkTilePainter(
              position: tilePosition,
              tileImage: tileImages[tilePosition],
              lines: lines)
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

    // TEMP: To make sure we're handling this async process correctly
    await Future.delayed(Duration(seconds: 3));

    // Remove all the completed lines
    if (bakedLines.length > 1) {
      _lines.removeRange(0, bakedLines.length - 1);
    }

    // Remove all the baked points from the current line
    _lines.first.removePointRange(0, bakedLines.last.points.length);

    notifyListeners();
    _isBaking = false;
  }

  /// Determines which tiles need to update by matching each point up
  /// with the appropriate tile
  Set<Offset> _getTilesToUpdate(List<InkLine> linesToBake) {
    var tilesToUpdate = HashSet<Offset>();

    for (InkLine line in linesToBake) {
      for (Offset point in line.points) {
        double surroundingPointDistance =
            max(maxStrokeWidth, maxLineSegmentLength);

        // Expand the search radius slightly. Otherwise a line with a very
        // wide stroke might brush a corner or edge of another tile, but
        // because the point itself isn't in the tile, the tile wouldn't
        // be considered as needing updating.
        List<Offset> surroundingPoints = [
          point + Offset(-surroundingPointDistance, 0),
          point + Offset(surroundingPointDistance, 0),
          point + Offset(0, -surroundingPointDistance),
          point + Offset(0, surroundingPointDistance)
        ];

        // Find the correct tile for each point
        // (Each tile is keyed by the position of its top-left corner)
        for (Offset nearbyPoint in surroundingPoints) {
          Offset containingTile = Offset(
              (nearbyPoint.dx / tileSize.width).floor() * tileSize.width,
              (nearbyPoint.dy / tileSize.height).floor() * tileSize.height);
          tilesToUpdate.add(containingTile);
        }
      }
    }

    return tilesToUpdate;
  }
}
