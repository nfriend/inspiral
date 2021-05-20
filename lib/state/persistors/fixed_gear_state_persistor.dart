import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/helpers/get_fixed_gear_state_for_version.dart';
import 'package:inspiral/state/helpers/get_where_clause_for_version.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:inspiral/extensions/extensions.dart';

class FixedGearStatePersistor {
  static void persist(Batch batch, FixedGearState fixedGear) {
    batch.update(
        Schema.state.toString(),
        {
          Schema.state.fixedGearPositionX: fixedGear.position.dx,
          Schema.state.fixedGearPositionY: fixedGear.position.dy,
          Schema.state.fixedGearRotation: fixedGear.rotation,
          Schema.state.fixedGearDefinitionId: fixedGear.definition.id,
          Schema.state.gearsAreVisible: fixedGear.isVisible.toInt(),
          Schema.state.fixedGearIsLocked: fixedGear.isLocked.toInt()
        },
        where: getWhereClauseForVersion(Schema.state.version, null));
  }

  static Future<FixedGearStateSnapshot> rehydrate(
      Database db, FixedGearState fixedGear) async {
    return await getFixedGearStateForVersion(null, fixedGear.allStateObjects);
  }
}
