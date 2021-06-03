import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_tiles_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
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

  /// Takes a full snapshot of the ink by first baking the image and then
  /// persisting the baked tiles as a snapshot
  static Future<void> fullSnapshot(
      int version, Batch batch, InkState ink) async {
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

  /// Performs a "quick" snapshot. Unlike `fullSnapshot`, this method
  /// does _not_ bake the lines before creating a snapshot. In fact, this method
  /// simply clones the previous snapshot. This is because the "quick" snapshot
  /// is only used for snapshoting changes to non-ink changes. This allows
  /// quick snapshots to complete very quickly since there is no need to
  /// bake the image as part of taking the snapshot.
  static Future<void> quickSnapshot(
      int version, Batch batch, InkState ink) async {
    final db = await getDatabase();

    // Get a list of all _current_ tile snapshots
    final currentSnapshotRows = await db.query(Schema.tileSnapshots.toString(),
        where: getWhereClauseForVersion(
            Schema.tileSnapshots.version, version - 1));

    // For each row, insert a clone with a new ID and the current version
    for (var row in currentSnapshotRows) {
      batch.insert(Schema.tileSnapshots.toString(), {
        Schema.tileSnapshots.id: _uuid.v4(),
        Schema.tileSnapshots.tileDataId: row[Schema.tileSnapshots.tileDataId],
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
