import 'package:inspiral/constants.dart';
import 'package:inspiral/database/on_database_create.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/// Returns a `Database` instance that is ready to read/write local data
Future<Database> getDatabase() async {
  var databasePath = join(await getDatabasesPath(), localDatabaseName);

  var database = await openDatabase(databasePath, version: 1,
      onConfigure: (Database db) async {
    await db.execute('PRAGMA foreign_keys = ON;');
  }, onCreate: onDatabaseCreate, onDowngrade: onDatabaseDowngradeDelete);

  return database;
}
