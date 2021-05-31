import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_tiles_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:inspiral/extensions/extensions.dart';

const Uuid _uuid = Uuid();

class InkStateUndoer {
  static Future<void> cleanUpOldRedoSnapshots(int version, Batch batch) async {
    // Delete all snapshot records that are no longer in the history stack
    batch.delete(Schema.tileSnapshots.toString(),
        where: '${Schema.tileSnapshots.version} >= $version');

    // Delete all rows not referenced by a snapshot
    batch.rawDelete('''
      DELETE FROM ${Schema.tileData}
      WHERE ${Schema.tileData.id} NOT IN (
        SELECT ${Schema.tileSnapshots.tileDataId}
        FROM ${Schema.tileSnapshots}
        WHERE ${Schema.tileSnapshots.tileDataId} IS NOT NULL
      )
    ''');
  }

  static Future<void> snapshot(int version, Batch batch, InkState ink) async {
    // Rasterize any un-baked points before creating a new snapshot
    await ink.pendingCanvasManipulation;
    await ink.bakeImage();

    var allIdsInVersion = <String>[];
    var allUpdates = <Future>[];

    for (var entry in ink.tileImages.entries) {
      var tilePosition = entry.key;
      var tileImage = entry.value;
      var tileDatabaseId = ink.tilePositionToDatabaseId[tilePosition];

      if (ink.unsavedTiles.containsKey(tilePosition)) {
        // This tile hasn't yet been saved to the database, so do this now.
        tileDatabaseId = _uuid.v4();

        allUpdates.add(tileImage
            .toByteData(format: ImageByteFormat.png)
            .then((ByteData? byteData) {
          if (byteData == null) {
            throw 'snapshotting a tile `Image` as a PNG returned `null`';
          }

          var bytes = byteData.buffer.asUint8List();

          batch.insert(Schema.tileData.toString(), {
            Schema.tileData.id: tileDatabaseId,
            Schema.tileData.x: tilePosition.dx,
            Schema.tileData.y: tilePosition.dy,
            Schema.tileData.bytes: bytes
          });

          ink.tilePositionToDatabaseId[tilePosition] = tileDatabaseId!;
          ink.unsavedTiles.remove(tilePosition);
        }));
      }

      if (tileDatabaseId == null) {
        throw '`tileDatabaseId` cannot be null';
      }

      allIdsInVersion.add(tileDatabaseId);
    }

    await Future.wait(allUpdates);

    for (var tileDatabaseId in allIdsInVersion) {
      batch.insert(Schema.tileSnapshots.toString(), {
        Schema.tileSnapshots.id: _uuid.v4(),
        Schema.tileSnapshots.tileDataId: tileDatabaseId,
        Schema.tileSnapshots.version: version
      });
    }
  }

  static Future<void> undo(int version, InkState ink) async {
    await _undoOrRedo(version, ink);
  }

  static Future<void> redo(int version, InkState ink) async {
    await _undoOrRedo(version, ink);
  }

  static Future<void> _undoOrRedo(int version, InkState ink) async {
    try {
      var tileVersionResult = await getTilesForVersion(version);

      ink.tileImages
        ..removeAll()
        ..addAll(tileVersionResult.tileImages);
      ink.lines.removeAll();
      ink.tilePositionToDatabaseId
        ..removeAll()
        ..addAll(tileVersionResult.tilePositionToDatabaseId);
    } catch (err, stackTrace) {
      // See note about explicitly catching errors in `bakeImage` method
      // in InkState
      await Sentry.captureException(err, stackTrace: stackTrace);
    }
  }
}
