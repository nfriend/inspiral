import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:inspiral/extensions/extensions.dart';

class SettingsStateRehydrationResult {
  final bool includeBackgroundWhenSaving;
  final bool closeDrawingToolsDrawerOnDrag;

  SettingsStateRehydrationResult(
      {@required this.includeBackgroundWhenSaving,
      @required this.closeDrawingToolsDrawerOnDrag});
}

class SettingsStatePersistor {
  static Future<void> persist(Batch batch, SettingsState settings) async {
    batch.update(Schema.state.toString(), {
      Schema.state.includeBackgroundWhenSaving:
          settings.includeBackgroundWhenSaving.toInt(),
      Schema.state.closeDrawingToolsDrawerOnDrag:
          settings.closeDrawingToolsDrawerOnDrag.toInt()
    });
  }

  static Future<SettingsStateRehydrationResult> rehydrate(
      Database db, SettingsState settings) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    return SettingsStateRehydrationResult(
      includeBackgroundWhenSaving:
          (state[Schema.state.includeBackgroundWhenSaving] as int).toBool(),
      closeDrawingToolsDrawerOnDrag:
          (state[Schema.state.closeDrawingToolsDrawerOnDrag] as int).toBool(),
    );
  }
}
