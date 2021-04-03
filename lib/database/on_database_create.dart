import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqlite_api.dart';

Future<void> onDatabaseCreate(Database db, int version) async {
  Batch batch = db.batch();
  _createTableColorsV1(batch);
  _createTableStateV1(batch);
  await batch.commit(continueOnError: false);
}

void _createTableColorsV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.colors}');
  batch.execute('''
    CREATE TABLE ${Schema.colors}(
      ${Schema.colors.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Schema.colors.value} TEXT CHECK(LENGTH(value) = 8) NOT NULL,
      ${Schema.colors.type} TEXT CHECK(type IN ('${ColorsTableType.pen}', '${ColorsTableType.canvas}')) NOT NULL
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.colors} (${Schema.colors.id}, ${Schema.colors.value}, ${Schema.colors.type})
    VALUES
      (1, '66FF0000', '${ColorsTableType.pen}'),
      (2, 'B3FF9500', '${ColorsTableType.pen}'),
      (3, 'B3FFFF00', '${ColorsTableType.pen}'),
      (4, '80009600', '${ColorsTableType.pen}'),
      (5, '660000FF', '${ColorsTableType.pen}'),
      (6, '80960096', '${ColorsTableType.pen}'),
      (7, 'CCFFFFFF', '${ColorsTableType.pen}'),
      (8, 'CCC8C8C8', '${ColorsTableType.pen}'),
      (9, 'CC969696', '${ColorsTableType.pen}'),
      (10, 'CC646464', '${ColorsTableType.pen}'),
      (12, 'FFFFFFFF', '${ColorsTableType.canvas}'),
      (13, 'FFF0F0F0', '${ColorsTableType.canvas}'),
      (14, 'FFE3E3E3', '${ColorsTableType.canvas}'),
      (15, 'FFF7EFDA', '${ColorsTableType.canvas}'),
      (16, 'FF3B2507', '${ColorsTableType.canvas}'),
      (17, 'FF0E1247', '${ColorsTableType.canvas}'),
      (18, 'FF333333', '${ColorsTableType.canvas}'),
      (19, 'FF121212', '${ColorsTableType.canvas}');
  ''');
}

void _createTableStateV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.state}');
  batch.execute('''
    CREATE TABLE ${Schema.state}(
      ${Schema.state.selectedPenColor} INTEGER NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.selectedCanvasColor} INTEGER NULL REFERENCES ${Schema.colors}(${Schema.colors.id})
    )
  ''');
  batch.execute('''
    INSERT INTO ${Schema.state} (${Schema.state.selectedPenColor}, ${Schema.state.selectedCanvasColor})
    VALUES
      (1, 12)
  ''');
}
