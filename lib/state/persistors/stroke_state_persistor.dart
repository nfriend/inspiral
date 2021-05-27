import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/stroke_style.dart';
import 'package:inspiral/state/helpers/get_stroke_state_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';

class StrokeStatePersistor {
  static void persist(Batch batch, StrokeState stroke) {
    var style = stroke.style == StrokeStyle.normal
        ? StrokeStyleType.normal
        : StrokeStyleType.airbrush;

    batch.update(
        Schema.state.toString(),
        {
          Schema.state.strokeWidth: stroke.width,
          Schema.state.strokeStyle: style
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<StrokeStateSnapshot> rehydrate(
      Database db, StrokeState stroke) async {
    return await getStrokeStateForVersion(null);
  }
}
