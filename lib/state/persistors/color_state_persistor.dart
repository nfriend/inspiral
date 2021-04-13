import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

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
  static void persist(Batch batch, ColorState colors) {
    var uuid = Uuid();

    // Remove references to avoid foreign key constraint errors below
    batch.update(Schema.state.toString(), {
      Schema.state.selectedPenColor: null,
      Schema.state.selectedCanvasColor: null
    });

    batch.delete(Schema.colors.toString(),
        where:
            "${Schema.colors.type} = '${ColorsTableType.canvas}' OR ${Schema.colors.type} = '${ColorsTableType.pen}'");

    String activePenColorId, activeCanvasColorId;

    for (var i = 0; i < colors.availablePenColors.length; i++) {
      var color = colors.availablePenColors[i];

      var rowId = uuid.v4();
      batch.insert(Schema.colors.toString(), {
        Schema.colors.id: rowId,
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.pen,
        Schema.colors.order: i
      });

      if (colors.penColor == color) {
        activePenColorId = rowId;
      }
    }

    for (var i = 0; i < colors.availableCanvasColors.length; i++) {
      var color = colors.availableCanvasColors[i];

      var rowId = uuid.v4();
      batch.insert(Schema.colors.toString(), {
        Schema.colors.id: rowId,
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.canvas,
        Schema.colors.order: i
      });

      if (colors.backgroundColor == color) {
        activeCanvasColorId = rowId;
      }
    }

    batch.update(Schema.state.toString(), {
      Schema.state.selectedPenColor: activePenColorId,
      Schema.state.selectedCanvasColor: activeCanvasColorId
    });
  }

  static Future<ColorStateRehydrationResult> rehydrate(
      Database db, ColorState colors) async {
    var availablePenColors = <TinyColor>[];
    var availableCanvasColors = <TinyColor>[];

    final List<Map<String, dynamic>> rows = await db
        .query(Schema.colors.toString(), orderBy: '"${Schema.colors.order}"');

    for (var attrs in rows) {
      var newColor =
          tinyColorFromHexString(attrs[Schema.colors.value] as String);

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
      LEFT JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.selectedPenColor}
      LEFT JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.selectedCanvasColor}
    ''')).first;

    var penColor = availablePenColors.firstWhere(
        (color) => color.toHexString() == state[Schema.state.selectedPenColor],
        orElse: () => TinyColor(Colors.transparent));
    var canvasColor = availableCanvasColors.firstWhere(
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
