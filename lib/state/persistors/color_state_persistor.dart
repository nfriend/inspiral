import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/state/helpers/get_color_state_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
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
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.selectedPenColor: null,
          Schema.state.selectedCanvasColor: null
        },
        where: getWhereClauseForVersion(Schema.state.version, null));

    batch.delete(Schema.colors.toString(),
        where:
            "(${Schema.colors.type} = '${ColorsTableType.canvas}' OR ${Schema.colors.type} = '${ColorsTableType.pen}') AND ${getWhereClauseForVersion(Schema.colors.version, null)}");

    String activePenColorId, activeCanvasColorId;

    for (var i = 0; i < colors.availablePenColors.length; i++) {
      var color = colors.availablePenColors[i].color;

      var rowId = uuid.v4();
      batch.insert(Schema.colors.toString(), {
        Schema.colors.id: rowId,
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.pen,
        Schema.colors.order: i,
        Schema.colors.version: null
      });

      if (colors.penColor.color == color) {
        activePenColorId = rowId;
      }
    }

    for (var i = 0; i < colors.availableCanvasColors.length; i++) {
      var color = colors.availableCanvasColors[i].color;

      var rowId = uuid.v4();
      batch.insert(Schema.colors.toString(), {
        Schema.colors.id: rowId,
        Schema.colors.value: color.toHexString(),
        Schema.colors.type: ColorsTableType.canvas,
        Schema.colors.order: i,
        Schema.colors.version: null
      });

      if (colors.backgroundColor.color == color) {
        activeCanvasColorId = rowId;
      }
    }

    batch.update(
        Schema.state.toString(),
        {
          Schema.state.selectedPenColor: activePenColorId,
          Schema.state.selectedCanvasColor: activeCanvasColorId
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<ColorStateSnapshot> rehydrate(
      Database db, ColorState colors) async {
    return getColorStateForVersion(null);
  }
}
