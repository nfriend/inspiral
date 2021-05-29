import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

class ColorPickerStateRehydrationResult {
  final TinyColor lastSelectedPenColor;
  final TinyColor lastSelectedCanvasColor;

  ColorPickerStateRehydrationResult(
      {required this.lastSelectedPenColor,
      required this.lastSelectedCanvasColor});
}

class ColorPickerStatePersistor {
  static void persist(Batch batch, ColorPickerState colorPicker) {
    var uuid = Uuid();

    // Remove references to avoid foreign key constraint errors below
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.lastSelectedPenColor: null,
          Schema.state.lastSelectedCanvasColor: null
        },
        where: getWhereClauseForVersion(Schema.state.version, null));

    batch.delete(Schema.colors.toString(),
        where:
            "(${Schema.colors.type} = '${ColorsTableType.lastSelectedPen}' OR ${Schema.colors.type} = '${ColorsTableType.lastSelectedCanvas}') AND ${getWhereClauseForVersion(Schema.colors.version, null)}");

    var lastPenColorId = uuid.v4();
    batch.insert(Schema.colors.toString(), {
      Schema.colors.id: lastPenColorId,
      Schema.colors.value: colorPicker.lastSelectedCustomPenColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedPen,
      Schema.colors.version: null
    });

    var lastCanvasColorId = uuid.v4();
    batch.insert(Schema.colors.toString(), {
      Schema.colors.id: lastCanvasColorId,
      Schema.colors.value:
          colorPicker.lastSelectedCustomCanvasColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedCanvas,
      Schema.colors.version: null
    });

    batch.update(
        Schema.state.toString(),
        {
          Schema.state.lastSelectedPenColor: lastPenColorId,
          Schema.state.lastSelectedCanvasColor: lastCanvasColorId,
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<ColorPickerStateRehydrationResult> rehydrate(
      Database db, ColorPickerState colorPicker) async {
    Map<String, dynamic> state = (await db.rawQuery('''
      SELECT
        c1.${Schema.colors.value} AS ${Schema.state.lastSelectedPenColor},
        c2.${Schema.colors.value} AS ${Schema.state.lastSelectedCanvasColor}
      FROM
        ${Schema.state} s
      LEFT JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.lastSelectedPenColor}
      LEFT JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.lastSelectedCanvasColor}
      WHERE ${getWhereClauseForVersion(Schema.state.version, null, tableAlias: 's')}
    ''')).first;

    return ColorPickerStateRehydrationResult(
        lastSelectedPenColor: tinyColorFromHexString(
            state[Schema.state.lastSelectedPenColor] as String),
        lastSelectedCanvasColor: tinyColorFromHexString(
            state[Schema.state.lastSelectedCanvasColor] as String));
  }
}
