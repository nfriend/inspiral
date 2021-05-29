import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/auto_draw_speed.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:inspiral/extensions/extensions.dart';

class SettingsStateRehydrationResult {
  final bool includeBackgroundWhenSaving;
  final bool closeDrawingToolsDrawerOnDrag;
  final bool preventIncompatibleGearPairings;
  final String autoDrawSpeed;

  SettingsStateRehydrationResult(
      {required this.includeBackgroundWhenSaving,
      required this.closeDrawingToolsDrawerOnDrag,
      required this.preventIncompatibleGearPairings,
      required this.autoDrawSpeed});
}

class SettingsStatePersistor {
  static void persist(Batch batch, SettingsState settings) {
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.includeBackgroundWhenSaving:
              settings.includeBackgroundWhenSaving.toInt(),
          Schema.state.closeDrawingToolsDrawerOnDrag:
              settings.closeDrawingToolsDrawerOnDrag.toInt(),
          Schema.state.preventIncompatibleGearPairings:
              settings.preventIncompatibleGearPairings.toInt(),
          Schema.state.autoDrawSpeed: settings.autoDrawSpeed
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<SettingsStateRehydrationResult> rehydrate(
      Database db, SettingsState settings) async {
    Map<String, dynamic> state = (await db.query(Schema.state.toString(),
            where: getWhereClauseForVersion(Schema.state.version, null)))
        .first;

    var autoDrawSpeed = state[Schema.state.autoDrawSpeed] as String?;
    if (!AutoDrawSpeed.all.contains(autoDrawSpeed)) {
      // This should never happen, just handling this here to be extra safe
      autoDrawSpeed = AutoDrawSpeed.slow;
    }

    return SettingsStateRehydrationResult(
        includeBackgroundWhenSaving:
            (state[Schema.state.includeBackgroundWhenSaving] as int).toBool(),
        closeDrawingToolsDrawerOnDrag:
            (state[Schema.state.closeDrawingToolsDrawerOnDrag] as int).toBool(),
        preventIncompatibleGearPairings:
            (state[Schema.state.preventIncompatibleGearPairings] as int)
                .toBool(),
        autoDrawSpeed: autoDrawSpeed!);
  }
}
