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
      ${Schema.colors.type} TEXT CHECK(type IN (
        '${ColorsTableType.pen}',
        '${ColorsTableType.canvas}',
        '${ColorsTableType.lastSelectedPen}',
        '${ColorsTableType.lastSelectedCanvas}'
      )) NOT NULL,
      "${Schema.colors.order}" INTEGER NOT NULL DEFAULT 1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.colors} (
      ${Schema.colors.id},
      ${Schema.colors.value},
      ${Schema.colors.type},
      "${Schema.colors.order}"
    )
    VALUES
      (1, '66FF0000', '${ColorsTableType.pen}', 1),
      (2, 'B3FF9500', '${ColorsTableType.pen}', 2),
      (3, 'B3FFFF00', '${ColorsTableType.pen}', 3),
      (4, '80009600', '${ColorsTableType.pen}', 4),
      (5, '660000FF', '${ColorsTableType.pen}', 5),
      (6, '80960096', '${ColorsTableType.pen}', 6),
      (7, 'CCFFFFFF', '${ColorsTableType.pen}', 7),
      (8, 'CCC8C8C8', '${ColorsTableType.pen}', 8),
      (9, 'CC969696', '${ColorsTableType.pen}', 9),
      (10, 'CC646464', '${ColorsTableType.pen}', 10),

      (11, 'FFFFFFFF', '${ColorsTableType.canvas}', 1),
      (12, 'FFF0F0F0', '${ColorsTableType.canvas}', 2),
      (13, 'FFE3E3E3', '${ColorsTableType.canvas}', 3),
      (14, 'FFF7EFDA', '${ColorsTableType.canvas}', 4),
      (15, 'FF3B2507', '${ColorsTableType.canvas}', 5),
      (16, 'FF0E1247', '${ColorsTableType.canvas}', 6),
      (17, 'FF333333', '${ColorsTableType.canvas}', 7),
      (18, 'FF121212', '${ColorsTableType.canvas}', 8),

      (19, 'B348F1F7', '${ColorsTableType.lastSelectedPen}', 1),

      (20, 'FF592659', '${ColorsTableType.lastSelectedCanvas}', 1);
  ''');
}

void _createTableStateV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.state}');
  batch.execute('''
    CREATE TABLE ${Schema.state}(
      ${Schema.state.selectedPenColor} INTEGER NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.selectedCanvasColor} INTEGER NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.lastSelectedPenColor} INTEGER NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.lastSelectedCanvasColor} INTEGER NULL REFERENCES ${Schema.colors}(${Schema.colors.id})
    )
  ''');
  batch.execute('''
    INSERT INTO ${Schema.state} (
      ${Schema.state.selectedPenColor},
      ${Schema.state.selectedCanvasColor},
      ${Schema.state.lastSelectedPenColor},
      ${Schema.state.lastSelectedCanvasColor}
    )
    VALUES
      (1, 11, 19, 20)
  ''');
}
