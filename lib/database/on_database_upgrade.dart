import 'package:inspiral/database/migrations/upgrades/upgrade_v0_to_v1.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v1_to_v2.dart';
import 'package:quiver/iterables.dart';
import 'package:sqflite/sqlite_api.dart';

const Map<int, Function(Batch)> upgradeFunctions = {
  0: upgradeV0ToV1,
  1: upgradeV1ToV2,
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
