import 'package:inspiral/constants.dart';
import 'package:inspiral/database/on_database_upgrade.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> _databaseFuture;

/// Returns a `Database` instance that is ready to read/write local data
/// A database name and version can optionally be supplied. These parameters
/// should only be used in tests.
Future<Database>/*!*/ getDatabase(
    {int version = localDatabaseVersion,
    String databaseName = localDatabaseName}) async {
  // If this is the first time calling this function (if the Future is null)
  // or if the database is closed, (re)open the database and return the
  // Future. The "closed" case should only happen if the app is "restarted"
  // using the RestartWidget, which is only used as a debug feature.
  if (_databaseFuture == null || !(await _databaseFuture).isOpen) {
    var databasePath = join(await getDatabasesPath(), databaseName);

    _databaseFuture = openDatabase(databasePath, version: version,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON;');
    }, onUpgrade: onDatabaseUpgrade, onDowngrade: onDatabaseDowngradeDelete);
  }

  return _databaseFuture;
}
