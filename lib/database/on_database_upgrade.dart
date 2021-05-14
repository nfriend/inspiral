import 'package:inspiral/database/migrations/upgrades/upgrade_v0_to_v1.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v1_to_v2.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v2_to_v3.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v3_to_v4.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v4_to_v5.dart';
import 'package:quiver/iterables.dart';
import 'package:sqflite/sqlite_api.dart';

const Map<int, Function(Batch)> upgradeFunctions = {
  0: upgradeV0ToV1,
  1: upgradeV1ToV2,
  2: upgradeV2ToV3,
  3: upgradeV3ToV4,
  4: upgradeV4ToV5
};

Future<void> onDatabaseUpgrade(
    Database db, int oldVersion, int newVersion) async {
  var batch = db.batch();

  for (var version in range(oldVersion, newVersion)) {
    print('Upgrading database from version $oldVersion to $newVersion');
    upgradeFunctions[version](batch);
  }

  await batch.commit();
}
