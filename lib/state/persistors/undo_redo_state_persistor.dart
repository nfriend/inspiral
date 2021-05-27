import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inspiral/extensions/extensions.dart';

class UndoRedoStateRehydrationResult {
  final int currentSnapshotVersion;
  final int maxSnapshotVersion;
  final bool createSnapshotBeforeNextDraw;

  UndoRedoStateRehydrationResult(
      {@required this.currentSnapshotVersion,
      @required this.maxSnapshotVersion,
      @required this.createSnapshotBeforeNextDraw});
}

class UndoRedoStatePersistor {
  static void persist(Batch batch, UndoRedoState undoRedo) {
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.currentSnapshotVersion: undoRedo.currentSnapshotVersion,
          Schema.state.maxSnapshotVersion: undoRedo.maxSnapshotVersion,
          Schema.state.createSnapshotBeforeNextDraw:
              undoRedo.createSnapshotBeforeNextDraw.toInt()
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<UndoRedoStateRehydrationResult> rehydrate(Database db) async {
    Map<String, dynamic> state = (await db.query(Schema.state.toString(),
            columns: [
              Schema.state.currentSnapshotVersion,
              Schema.state.maxSnapshotVersion,
              Schema.state.createSnapshotBeforeNextDraw
            ],
            where: getWhereClauseForVersion(Schema.state.version, null)))
        .first;

    return UndoRedoStateRehydrationResult(
        currentSnapshotVersion:
            state[Schema.state.currentSnapshotVersion] as int,
        maxSnapshotVersion: state[Schema.state.maxSnapshotVersion] as int,
        createSnapshotBeforeNextDraw:
            (state[Schema.state.createSnapshotBeforeNextDraw] as int).toBool());
  }
}
