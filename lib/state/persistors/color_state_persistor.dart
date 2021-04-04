import 'package:flutter/material.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

class ColorStateRehydrationResult {
  final List<TinyColor> availablePenColors;
  final List<TinyColor> availableCanvasColors;
  final TinyColor penColor;
  final TinyColor canvasColor;

  ColorStateRehydrationResult(
      {@required this.availablePenColors,
      @required this.availableCanvasColors,
      @required this.penColor,
      @required this.canvasColor});
}

class ColorStatePersistor {
  static Future<void> persist(ColorState colors) async {
    Database db = await getDatabase();

    Iterable<int> colorIdsToDelete = (await db.query(Schema.colors.toString(),
            columns: [Schema.colors.id],
            where:
                "${Schema.colors.type} = '${ColorsTableType.canvas}' OR ${Schema.colors.type} = '${ColorsTableType.pen}'"))
        .map((row) => row[Schema.colors.id]);

    int activePenColorId, activeCanvasColorId;

    for (TinyColor color in colors.availablePenColors) {
      int colorId = await db.insert(Schema.colors.toString(), {
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.pen
      });

      if (colors.penColor == color) {
        activePenColorId = colorId;
      }
    }

    for (TinyColor color in colors.availableCanvasColors) {
      int colorId = await db.insert(Schema.colors.toString(), {
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.canvas
      });

      if (colors.backgroundColor == color) {
        activeCanvasColorId = colorId;
      }
    }

    await db.update(Schema.state.toString(), {
      Schema.state.selectedPenColor: activePenColorId,
      Schema.state.selectedCanvasColor: activeCanvasColorId
    });

    await db.delete(Schema.colors.toString(),
        where: "${Schema.colors.id} IN (${colorIdsToDelete.join(', ')})");
  }

  static Future<ColorStateRehydrationResult> rehydrate(
      ColorState colors) async {
    List<TinyColor> availablePenColors = [];
    List<TinyColor> availableCanvasColors = [];

    Database db = await getDatabase();

    final List<Map<String, dynamic>> rows =
        await db.query(Schema.colors.toString());

    for (Map<String, dynamic> attrs in rows) {
      TinyColor newColor = tinyColorFromHexString(attrs[Schema.colors.value]);

      if (attrs[Schema.colors.type] == ColorsTableType.pen) {
        availablePenColors.add(newColor);
      } else if (attrs[Schema.colors.type] == ColorsTableType.canvas) {
        availableCanvasColors.add(newColor);
      }
    }

    Map<String, dynamic> state = (await db.rawQuery('''
      SELECT
        c1.${Schema.colors.value} AS ${Schema.state.selectedPenColor},
        c2.${Schema.colors.value} AS ${Schema.state.selectedCanvasColor}
      FROM
        ${Schema.state} s
      JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.selectedPenColor}
      JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.selectedCanvasColor}
    ''')).first;

    TinyColor penColor = availablePenColors.firstWhere(
        (color) => color.toHexString() == state[Schema.state.selectedPenColor],
        orElse: () => TinyColor(Colors.transparent));
    TinyColor canvasColor = availableCanvasColors.firstWhere(
        (color) =>
            color.toHexString() == state[Schema.state.selectedCanvasColor],
        orElse: () => TinyColor(Colors.white));

    return ColorStateRehydrationResult(
        availablePenColors: availablePenColors,
        availableCanvasColors: availableCanvasColors,
        penColor: penColor,
        canvasColor: canvasColor);
  }
}
