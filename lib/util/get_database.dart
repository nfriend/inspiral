import 'package:inspiral/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/// Returns a `Database` instance that is ready to read/write local data
Future<Database> getDatabase() async {
  String databasePath = join(await getDatabasesPath(), localDatabaseName);

  Database database = await openDatabase(databasePath, version: 1,
      onCreate: (Database db, int version) async {
    Batch batch = db.batch();
    _createTablePenColorsV1(batch);
    await batch.commit();
  }, onDowngrade: onDatabaseDowngradeDelete);

  return database;
}

void _createTablePenColorsV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS penColors');
  batch.execute('''
    CREATE TABLE penColors(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      value STRING,
      isActive INTEGER
    )
  ''');
  batch.execute('''
    INSERT INTO penColors (value, isActive)
    VALUES
      ('66FF0000', 1),
      ('B3FF9500', 0),
      ('B3FFFF00', 0),
      ('80009600', 0),
      ('660000FF', 0),
      ('80960096', 0),
      ('CCFFFFFF', 0),
      ('CCC8C8C8', 0),
      ('CC969696', 0),
      ('CC646464', 0)
  ''');
}
