import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqflite.dart';

class UndoRedoStateRehydrationResult {
  final int currentSnapshotVersion;
  final int maxSnapshotVersion;

  UndoRedoStateRehydrationResult(
      {@required this.currentSnapshotVersion,
      @required this.maxSnapshotVersion});
}

class UndoRedoStatePersistor {
  static void persist(Batch batch, UndoRedoState undoRedo) {
    batch.update(Schema.state.toString(), {
      Schema.state.currentSnapshotVersion: undoRedo.currentSnapshotVersion,
      Schema.state.maxSnapshotVersion: undoRedo.maxSnapshotVersion
    });
  }

  static Future<UndoRedoStateRehydrationResult> rehydrate(Database db) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    return UndoRedoStateRehydrationResult(
        currentSnapshotVersion:
            state[Schema.state.currentSnapshotVersion] as int,
        maxSnapshotVersion: state[Schema.state.maxSnapshotVersion] as int);
  }
}
