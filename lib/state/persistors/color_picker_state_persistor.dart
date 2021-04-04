import 'package:flutter/material.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

class ColorPickerStateRehydrationResult {
  final TinyColor lastSelectedPenColor;
  final TinyColor lastSelectedCanvasColor;

  ColorPickerStateRehydrationResult(
      {@required this.lastSelectedPenColor,
      @required this.lastSelectedCanvasColor});
}

class ColorPickerStatePersistor {
  static Future<void> persist(ColorPickerState colorPicker) async {
    Database db = await getDatabase();

    Iterable<int> colorIdsToDelete = (await db.query(Schema.colors.toString(),
            columns: [Schema.colors.id],
            where:
                "${Schema.colors.type} = '${ColorsTableType.lastSelectedPen}' OR ${Schema.colors.type} = '${ColorsTableType.lastSelectedCanvas}'"))
        .map((row) => row[Schema.colors.id]);

    int lastPenColorId = await db.insert(Schema.colors.toString(), {
      Schema.colors.value: colorPicker.lastSelectedCustomPenColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedPen
    });

    int lastCanvasColorId = await db.insert(Schema.colors.toString(), {
      Schema.colors.value:
          colorPicker.lastSelectedCustomCanvasColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedCanvas
    });

    await db.update(Schema.state.toString(), {
      Schema.state.lastSelectedPenColor: lastPenColorId,
      Schema.state.lastSelectedCanvasColor: lastCanvasColorId,
    });

    await db.delete(Schema.colors.toString(),
        where: "${Schema.colors.id} IN (${colorIdsToDelete.join(', ')})");
  }

  static Future<ColorPickerStateRehydrationResult> rehydrate(
      ColorPickerState colorPicker) async {
    Database db = await getDatabase();

    Map<String, dynamic> state = (await db.rawQuery('''
      SELECT
        c1.${Schema.colors.value} AS ${Schema.state.lastSelectedPenColor},
        c2.${Schema.colors.value} AS ${Schema.state.lastSelectedCanvasColor}
      FROM
        ${Schema.state} s
      JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.lastSelectedPenColor}
      JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.lastSelectedCanvasColor}
    ''')).first;

    return ColorPickerStateRehydrationResult(
        lastSelectedPenColor:
            tinyColorFromHexString(state[Schema.state.lastSelectedPenColor]),
        lastSelectedCanvasColor: tinyColorFromHexString(
            state[Schema.state.lastSelectedCanvasColor]));
  }
}
