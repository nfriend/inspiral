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
    print("checkpoint 1");
    Database db = await getDatabase();
    print("checkpoint 2");

    Iterable<int> colorIdsToDelete = (await db.query(Schema.colors.toString(),
            columns: [Schema.colors.id],
            where:
                "${Schema.colors.type} = '${ColorsTableType.canvas}' OR ${Schema.colors.type} = '${ColorsTableType.pen}'"))
        .map((row) => row[Schema.colors.id]);
    print("colorIdsToDelete: ${colorIdsToDelete.join(', ')}");
    print("checkpoint 3");

    int activePenColorId, activeCanvasColorId;

    for (int i = 0; i < colors.availablePenColors.length; i++) {
      TinyColor color = colors.availablePenColors[i];

      int colorId = await db.insert(Schema.colors.toString(), {
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.pen,
        Schema.colors.order: i
      });

      if (colors.penColor == color) {
        activePenColorId = colorId;
      }
    }

    print("checkpoint 4");

    for (int i = 0; i < colors.availableCanvasColors.length; i++) {
      TinyColor color = colors.availableCanvasColors[i];

      int colorId = await db.insert(Schema.colors.toString(), {
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.canvas,
        Schema.colors.order: i
      });

      if (colors.backgroundColor == color) {
        activeCanvasColorId = colorId;
      }
    }

    print("checkpoint 5");

    await db.update(Schema.state.toString(), {
      Schema.state.selectedPenColor: activePenColorId,
      Schema.state.selectedCanvasColor: activeCanvasColorId
    });

    print("checkpoint 6");

    int numRowsDeleted = await db.delete(Schema.colors.toString(),
        where: "${Schema.colors.id} IN (${colorIdsToDelete.join(', ')})");

    print("numRowsDeleted: ${numRowsDeleted}");

    print("checkpoint 7");

    // TEMP
    var allPenColors = await db.query(Schema.colors.toString(),
        where: '${Schema.colors.type} = "${ColorsTableType.pen}"');
    print("pen color count: ${allPenColors.length}");
  }

  static Future<ColorStateRehydrationResult> rehydrate(
      ColorState colors) async {
    List<TinyColor> availablePenColors = [];
    List<TinyColor> availableCanvasColors = [];

    Database db = await getDatabase();

    final List<Map<String, dynamic>> rows = await db
        .query(Schema.colors.toString(), orderBy: '"${Schema.colors.order}"');

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
