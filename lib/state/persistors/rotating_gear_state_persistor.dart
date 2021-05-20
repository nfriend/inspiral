import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_rotating_gear_state_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/rotating_gear_state.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:sqflite/sqlite_api.dart';

class RotatingGearStatePersistor {
  static void persist(Batch batch, RotatingGearState rotatingGear) {
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.rotatingGearAngle: rotatingGear.lastAngle,
          Schema.state.rotatingGearDefinitionId: rotatingGear.definition.id,
          Schema.state.rotatingGearActiveHoleName: rotatingGear.activeHole.name,
          Schema.state.gearsAreVisible: rotatingGear.isVisible.toInt(),
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<RotatingGearStateSnapshot> rehydrate(
      Database db, RotatingGearState rotatingGear) async {
    return await getRotatingGearStateForVersion(null);
  }
}
