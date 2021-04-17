import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/helpers/get_tiles_to_update.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

/// Renders the provided lines into `Image` tiles.
///
/// Heads up: All parameters of this function are mutated
/// when this function is called.
Future<void> bakeImage(
    {@required List<InkLine> lines,
    @required Map<Offset, Image> tileImages,
    @required Map<Offset, String> tilePositionToDatabaseId,
    @required Size tileSize,
    @required int snapshotVersion}) async {
  // This function assumes that `lines` has at least one `InkLine`.
  // If it does not, there is no need to bake the lines - there
  // is nothing to bake, so exit early.
  if (lines.isEmpty) {
    return;
  }

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
  var allUpdates = <Future>[];

  var batch = (await getDatabase()).batch();

  // Delete all snapshot records that are no longer in the history stack
  batch.delete(Schema.tileSnapshots.toString(),
      where: '${Schema.tileSnapshots.version} >= $snapshotVersion');

  // Delete all rows not referenced by a snapshot
  batch.rawDelete('''
    DELETE FROM ${Schema.tileData}
    WHERE ${Schema.tileData.id} NOT IN (
      SELECT ${Schema.tileSnapshots.tileDataId}
      FROM ${Schema.tileSnapshots}
      WHERE ${Schema.tileSnapshots.tileDataId} IS NOT NULL
    )
  ''');

  for (var tilePosition in tilesToUpdate) {
    var recorder = PictureRecorder();
    var canvas = Canvas(recorder);
    DryInkTilePainter(
            position: tilePosition,
            tileImage: tileImages[tilePosition],
            lines: linesToBake)
        .paint(canvas, renderedSize);

    var picture = recorder.endRecording();
    allUpdates.add(_processPicture(
        picture: picture,
        renderedSize: renderedSize,
        updatedTileImages: updatedTileImages,
        tilePosition: tilePosition,
        tilePositionToDatabaseId: tilePositionToDatabaseId,
        batch: batch));
  }

  await Future.wait(allUpdates);

  for (var tilePositionAndId in tilePositionToDatabaseId.entries) {
    batch.insert(Schema.tileSnapshots.toString(), {
      Schema.tileSnapshots.id: _uuid.v4(),
      Schema.tileSnapshots.tileDataId: tilePositionAndId.value,
      Schema.tileSnapshots.version: snapshotVersion
    });
  }

  await batch.commit(noResult: true);

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
}

// This chunk of code was extracted from the function above to allow it to
// use async/await. Previously, it had to use `.then()`s, since we deal
// with `Future`s explicitly above. Because this isn't a very natural
// abstraction, it takes a bunch of parameters - pretty much all of the
// internal state of the function above.
Future<void> _processPicture(
    {@required Picture picture,
    @required Size renderedSize,
    @required Map<Offset, Image> updatedTileImages,
    @required Offset tilePosition,
    @required Map<Offset, String> tilePositionToDatabaseId,
    @required Batch batch}) async {
  var newImage = await picture.toImage(
      renderedSize.width.ceil(), renderedSize.height.ceil());

  updatedTileImages[tilePosition] = newImage;

  var byteData = await newImage.toByteData(format: ImageByteFormat.png);
  var bytes = byteData.buffer.asUint8List();
  var id = _uuid.v4();

  batch.insert(Schema.tileData.toString(), {
    Schema.tileData.id: id,
    Schema.tileData.x: tilePosition.dx,
    Schema.tileData.y: tilePosition.dy,
    Schema.tileData.bytes: bytes
  });

  tilePositionToDatabaseId[tilePosition] = id;
}
