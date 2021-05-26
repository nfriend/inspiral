import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

class ColorStateSnapshot {
  final List<TinyColor> availablePenColors;
  final List<TinyColor> availableCanvasColors;
  final TinyColor penColor;
  final TinyColor canvasColor;

  ColorStateSnapshot(
      {@required this.availablePenColors,
      @required this.availableCanvasColors,
      @required this.penColor,
      @required this.canvasColor});
}

Future<ColorStateSnapshot> getColorStateForVersion(int version) async {
  var db = await getDatabase();

  var availablePenColors = <TinyColor>[];
  var availableCanvasColors = <TinyColor>[];

  final List<Map<String, dynamic>> allRows = await db.query(
      Schema.colors.toString(),
      orderBy: '"${Schema.colors.order}"',
      where: getWhereClauseForVersion(Schema.colors.version, version));

  if (allRows.isEmpty) {
    return ColorStateSnapshot(
        availablePenColors: defaultPenColors,
        availableCanvasColors: defaultCanvasColors,
        penColor: defaultSelectedPenColor,
        canvasColor: defaultSelectedCanvasColor);
  } else {
    for (var attrs in allRows) {
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
      WHERE ${getWhereClauseForVersion(Schema.state.version, version, tableAlias: 's')}
    ''')).first;

    var penColor = availablePenColors.firstWhere(
        (color) => color.toHexString() == state[Schema.state.selectedPenColor],
        orElse: () => TinyColor(Colors.transparent));
    var canvasColor = availableCanvasColors.firstWhere(
        (color) =>
            color.toHexString() == state[Schema.state.selectedCanvasColor],
        orElse: () => TinyColor(Colors.white));

    return ColorStateSnapshot(
        availablePenColors: availablePenColors,
        availableCanvasColors: availableCanvasColors,
        penColor: penColor,
        canvasColor: canvasColor);
  }
}
