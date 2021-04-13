import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/state/ink_state.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import 'package:inspiral/extensions/extensions.dart';

class InkStateRehydrationResult {
  final List<InkLine> lines;

  InkStateRehydrationResult({@required this.lines});
}

class InkStatePersistor {
  static void persist(Batch batch, InkState ink) {
    Uuid uuid = Uuid();

    batch.delete(Schema.points.toString());
    batch.delete(Schema.lineSegments.toString());
    batch.delete(Schema.inkLines.toString());
    batch.delete(Schema.colors.toString(),
        where: "${Schema.colors.type} = '${ColorsTableType.ink}'");

    for (int i = 0; i < ink.lines.length; i++) {
      InkLine line = ink.lines[i];
      String inkLineId = uuid.v4();
      String colorId = uuid.v4();

      batch.insert(Schema.colors.toString(), {
        Schema.colors.id: colorId,
        Schema.colors.value: line.color.toHexString(),
        Schema.colors.type: ColorsTableType.ink
      });

      batch.insert(Schema.inkLines.toString(), {
        Schema.inkLines.id: inkLineId,
        Schema.inkLines.strokeWidth: ink.stroke.width,
        Schema.inkLines.strokeStyle:
            ink.stroke.style == StrokeStyle.normal ? 'normal' : 'airbrush',
        Schema.inkLines.colorId: colorId,
        Schema.inkLines.order: i
      });

      for (int j = 0; j < line.points.length; j++) {
        List<Offset> segment = line.points[j];
        String segmentId = uuid.v4();

        batch.insert(Schema.lineSegments.toString(), {
          Schema.lineSegments.id: segmentId,
          Schema.lineSegments.inkLineId: inkLineId,
          Schema.lineSegments.order: j
        });

        for (int k = 0; k < segment.length; k++) {
          Offset point = segment[k];
          String pointId = uuid.v4();

          batch.insert(Schema.points.toString(), {
            Schema.points.id: pointId,
            Schema.points.lineSegmentId: segmentId,
            Schema.points.x: point.dx,
            Schema.points.y: point.dy,
            Schema.points.order: k
          });
        }
      }
    }
  }

  static Future<InkStateRehydrationResult> rehydrate(
      Database db, InkState ink) async {
    List<Map<String, dynamic>> inkLines = await db.rawQuery('''
      SELECT
        il.${Schema.inkLines.id} AS ${Schema.inkLines.id},
        il.${Schema.inkLines.strokeWidth} AS ${Schema.inkLines.strokeWidth},
        il.${Schema.inkLines.strokeStyle} AS ${Schema.inkLines.strokeStyle},
        c.${Schema.colors.value} AS ${Schema.inkLines.colorId}
      FROM
        ${Schema.inkLines} il
      LEFT JOIN ${Schema.colors} c ON c.${Schema.colors.id} = il.${Schema.inkLines.colorId}
      ORDER BY il."${Schema.inkLines.order}" ASC
    ''');

    List<Map<String, dynamic>> segments = await db.query(
        Schema.lineSegments.toString(),
        orderBy: '"${Schema.lineSegments.order}" ASC');

    List<Map<String, dynamic>> points = await db.query(Schema.points.toString(),
        orderBy: '"${Schema.points.order}" ASC');

    List<InkLine> lines = inkLines.map((inkLine) {
      InkLine newInkLine = new InkLine(
          color: colorFromHexString(inkLine[Schema.inkLines.colorId]),
          strokeWidth: inkLine[Schema.inkLines.strokeWidth],
          strokeStyle: inkLine[Schema.inkLines.strokeStyle] == 'normal'
              ? StrokeStyle.normal
              : StrokeStyle.airbrush);

      segments
          .where((segment) =>
              segment[Schema.lineSegments.inkLineId] ==
              inkLine[Schema.inkLines.id])
          .forEach((segment) {
        List<Offset> pointsToAdd = points
            .where((point) =>
                point[Schema.points.lineSegmentId] ==
                segment[Schema.lineSegments.id])
            .map((point) =>
                Offset(point[Schema.points.x], point[Schema.points.y]))
            .toList();

        newInkLine.addPoints(pointsToAdd);
        newInkLine.startNewPath();
      });

      return newInkLine;
    }).toList();

    return InkStateRehydrationResult(lines: lines);
  }
}
