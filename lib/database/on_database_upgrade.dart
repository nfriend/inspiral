import 'package:inspiral/database/migrations/upgrades/upgrade_v0_to_v1.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v1_to_v2.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v2_to_v3.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v3_to_v4.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v4_to_v5.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v5_to_v6.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v6_to_v7.dart';
import 'package:inspiral/database/migrations/upgrades/upgrade_v7_to_v8.dart';
import 'package:quiver/iterables.dart';
import 'package:sqflite/sqlite_api.dart';

const Map<int, Future<void> Function(Database)> upgradeFunctions = {
  0: upgradeV0ToV1,
  1: upgradeV1ToV2,
  2: upgradeV2ToV3,
  3: upgradeV3ToV4,
  4: upgradeV4ToV5,
  5: upgradeV5ToV6,
  6: upgradeV6ToV7,
  7: upgradeV7ToV8
};

Future<void> onDatabaseUpgrade(
    Database db, int oldVersion, int newVersion) async {
  for (var version in range(oldVersion, newVersion)) {
    print('Upgrading database from version $oldVersion to $newVersion');
    await upgradeFunctions[version as int]!(db);
  }
}
