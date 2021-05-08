import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/get_tiles_to_update.dart';

/// Renders the provided lines into `Image` tiles, and returns a mapping
/// of tile position => Image for each tile that was updated.
///
/// Heads up: All parameters of this function are mutated
/// when this function is called.
Future<Map<Offset, Image>> bakeImage(
    {@required List<InkLine> lines,
    @required Map<Offset, Image> tileImages,
    @required Map<Offset, String> tilePositionToDatabaseId,
    @required Size tileSize}) async {
  // Operate on a shallow clone of the points, because the baking process
  // is asynchronous, and more points may be added to `_points` while
  // this method is running
  var linesToBake = lines.map((line) => InkLine.from(line)).toList();

  // Indicate to the current line that it should "split" the current path
  // right now and mark the location of the split, so that we can remove
  // all points prior to this split after the points have been baked.
  lines.last.markAndSplitCurrentPath();

  // Determine which tiles need to update
  var tilesToUpdate =
      getTilesToUpdate(linesToBake: linesToBake, tileSize: tileSize);

  var renderedSize = tileSize;
  var updatedTileImages = <Offset, Image>{};

  for (var tilePosition in tilesToUpdate) {
    var recorder = PictureRecorder();
    var canvas = Canvas(recorder);
    DryInkTilePainter(
            position: tilePosition,
            tileImage: tileImages[tilePosition],
            lines: linesToBake)
        .paint(canvas, renderedSize);

    var picture = recorder.endRecording();

    var newImage = await picture.toImage(
        renderedSize.width.ceil(), renderedSize.height.ceil());

    updatedTileImages[tilePosition] = newImage;
  }

  // Update all the tile images with the new ones generated above
  for (var entry in updatedTileImages.entries) {
    tileImages[entry.key]?.dispose();
    tileImages[entry.key] = entry.value;
  }

  // Remove all the completed lines (all lines except the last)
  if (linesToBake.length > 1) {
    lines.removeRange(0, linesToBake.length - 1);
  }

  // Remove all the baked points from the current line
  lines.first.removePointsUpToMarkedSplit();

  return updatedTileImages;
}
