import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
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
      {@required this.lastSelectedPenColor,
      @required this.lastSelectedCanvasColor});
}

class ColorPickerStatePersistor {
  static void persist(Batch batch, ColorPickerState colorPicker) {
    Uuid uuid = Uuid();

    // Remove references to avoid foreign key constraint errors below
    batch.update(Schema.state.toString(), {
      Schema.state.lastSelectedPenColor: null,
      Schema.state.lastSelectedCanvasColor: null
    });

    batch.delete(Schema.colors.toString(),
        where:
            "${Schema.colors.type} = '${ColorsTableType.lastSelectedPen}' OR ${Schema.colors.type} = '${ColorsTableType.lastSelectedCanvas}'");

    String lastPenColorId = uuid.v4();
    batch.insert(Schema.colors.toString(), {
      Schema.colors.id: lastPenColorId,
      Schema.colors.value: colorPicker.lastSelectedCustomPenColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedPen
    });

    String lastCanvasColorId = uuid.v4();
    batch.insert(Schema.colors.toString(), {
      Schema.colors.id: lastCanvasColorId,
      Schema.colors.value:
          colorPicker.lastSelectedCustomCanvasColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedCanvas
    });

    batch.update(Schema.state.toString(), {
      Schema.state.lastSelectedPenColor: lastPenColorId,
      Schema.state.lastSelectedCanvasColor: lastCanvasColorId,
    });
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
    ''')).first;

    return ColorPickerStateRehydrationResult(
        lastSelectedPenColor:
            tinyColorFromHexString(state[Schema.state.lastSelectedPenColor]),
        lastSelectedCanvasColor: tinyColorFromHexString(
            state[Schema.state.lastSelectedCanvasColor]));
  }
}
