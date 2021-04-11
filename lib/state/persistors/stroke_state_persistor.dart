import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';

class StrokeStateRehydrationResult {
  final double width;
  final StrokeStyle style;

  StrokeStateRehydrationResult({@required this.width, @required this.style});
}

class StrokeStatePersistor {
  static void persist(Batch batch, StrokeState stroke) {
    String style = stroke.style == StrokeStyle.normal ? 'normal' : 'airbrush';

    batch.update(Schema.state.toString(), {
      Schema.state.strokeWidth: stroke.width,
      Schema.state.strokeStyle: style
    });
  }

  static Future<StrokeStateRehydrationResult> rehydrate(
      Database db, StrokeState stroke) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    StrokeStyle style = StrokeStyle.normal;

    if (state[Schema.state.strokeStyle] == 'airbrush') {
      style = StrokeStyle.airbrush;
    }

    return StrokeStateRehydrationResult(
        width: state[Schema.state.strokeWidth], style: style);
  }
}
