import 'dart:math';
import 'package:inspiral/models/canvas_size.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:inspiral/database/schema.dart';

Future<void> onDatabaseCreate(Database db, int version) async {
  var batch = db.batch();
  _createTableColorsV1(batch);
  _createTableStateV1(batch);
  _createTableInkLinesV1(batch);
  _createTableLineSegmentsV1(batch);
  _createTablePointsV1(batch);
  _createTableTileDataV1(batch);
  _createTableTileSnapshotsV1(batch);
  await batch.commit(continueOnError: false, noResult: true);
}

const _startingAngle = -pi / 2;

void _createTableColorsV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.colors}');
  batch.execute('''
    CREATE TABLE ${Schema.colors}(
      ${Schema.colors.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.colors.value} TEXT CHECK(LENGTH(${Schema.colors.value}) = 8) NOT NULL,
      ${Schema.colors.type} TEXT
        CHECK(${Schema.colors.type} IN (${ColorsTableType.all.map((t) => "'$t'").join(', ')}))
        NOT NULL,
      "${Schema.colors.order}" INTEGER NOT NULL DEFAULT 1
    )
  ''');

  // These colors should be kept in sync with the colors in the `reset` method
  // of `lib/state/color_state.dart`
  batch.execute('''
    INSERT INTO ${Schema.colors} (
      ${Schema.colors.id},
      ${Schema.colors.value},
      ${Schema.colors.type},
      "${Schema.colors.order}"
    )
    VALUES
      /* Red */
      ('ab91b67b-e1f0-4d45-9d99-d67383e23bea', '66FF0000', '${ColorsTableType.pen}', 1),
      /* Orange */
      ('45b3ed99-ef1d-465c-a682-4afc5eac5727', 'B3FF9500', '${ColorsTableType.pen}', 2),
      /* Yellow */
      ('3a98aacf-47b7-4636-8e9e-f4d0a52b6ae9', 'B3FFFF00', '${ColorsTableType.pen}', 3),
      /* Green */
      ('2f3e09e1-727e-455b-a5cc-8559e9e9f8ea', '80009600', '${ColorsTableType.pen}', 4),
      /* Light blue */
      ('d59187e5-44de-43b3-a244-54dc0aa8ca1e', 'B392d4de', '${ColorsTableType.pen}', 5),
      /* Blue */
      ('7513e7ed-7c49-4dc5-9ee7-fac49b8ffb17', '660000FF', '${ColorsTableType.pen}', 6),
      /* Purple */
      ('dcc145c5-e904-4456-983c-78ec0326ab20', '80960096', '${ColorsTableType.pen}', 7),
      /* Pink */
      ('4a8e131d-5ee4-41f5-b302-0ceebdaa4ee3', 'B3F0A3BA', '${ColorsTableType.pen}', 8),
      /* Brown */
      ('afe32b1e-59c9-483a-b5d4-f0fff028f17f', '96401b13', '${ColorsTableType.pen}', 9),
      /* White */
      ('5555409d-2e9c-4ddb-979d-df4f71196f0d', 'CCFFFFFF', '${ColorsTableType.pen}', 10),
      /* Light gray */
      ('bf95f1f6-0ae4-49d9-b992-36b343ddd36c', 'CCC8C8C8', '${ColorsTableType.pen}', 11),
      /* Medium gray */
      ('7e69cc83-c916-417c-82fc-5207937ca2cc', 'CC969696', '${ColorsTableType.pen}', 12),
      /* Dark gray */
      ('11073ff1-6a7e-456c-8276-07e3a87dd3b5', 'CC646464', '${ColorsTableType.pen}', 13),

      /* White */
      ('e243e24c-17be-40fa-8505-091a0f2e2a03', 'FFFFFFFF', '${ColorsTableType.canvas}', 1),
      /* Light gray */
      ('dd8fb49b-1b4c-448c-8f1a-54c3ac2018ec', 'FFF0F0F0', '${ColorsTableType.canvas}', 2),
      /* Medium-light gray */
      ('d156c05c-131d-4fec-8514-f11324ba4f4e', 'FFE3E3E3', '${ColorsTableType.canvas}', 3),
      /* Beige */
      ('d36b3350-8a2c-4bd9-9860-1f2e756a4f35', 'FFF7EFDA', '${ColorsTableType.canvas}', 4),
      /* Brown */
      ('0aa3ca97-6ac6-4178-a4ef-3a97afe2d1fc', 'FF3B2507', '${ColorsTableType.canvas}', 5),
      /* Navy */
      ('d1248032-9064-43fd-8f26-f1960b572fe1', 'FF0E1247', '${ColorsTableType.canvas}', 6),
      /* Medium gray */
      ('6d06e1ce-4118-4b95-b266-0b125ce6532a', 'FF333333', '${ColorsTableType.canvas}', 7),
      /* Dark gray */
      ('487682ec-990e-46cd-a969-b8117d818413', 'FF121212', '${ColorsTableType.canvas}', 8),

      ('97a24b56-edc6-4613-beeb-f9a139f7f669', 'B348F1F7', '${ColorsTableType.lastSelectedPen}', 1),

      ('c0ed2d30-86cf-46a1-b7cf-271fd56b1756', 'FF592659', '${ColorsTableType.lastSelectedCanvas}', 1);
  ''');
}

void _createTableStateV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.state}');
  batch.execute('''
    CREATE TABLE ${Schema.state}(
      ${Schema.state.selectedPenColor} TEXT NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.selectedCanvasColor} TEXT NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.lastSelectedPenColor} TEXT NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.lastSelectedCanvasColor} TEXT NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      ${Schema.state.includeBackgroundWhenSaving} INTEGER CHECK(${Schema.state.includeBackgroundWhenSaving} IN (0, 1)) NOT NULL,
      ${Schema.state.closeDrawingToolsDrawerOnDrag} INTEGER CHECK(${Schema.state.closeDrawingToolsDrawerOnDrag} IN (0, 1)) NOT NULL,
      ${Schema.state.preventIncompatibleGearPairings} INTEGER CHECK(${Schema.state.preventIncompatibleGearPairings} IN (0, 1)) NOT NULL,
      ${Schema.state.rotatingGearAngle} REAL NOT NULL,
      ${Schema.state.rotatingGearDefinitionId} TEXT NOT NULL,
      ${Schema.state.rotatingGearActiveHoleName} TEXT NOT NULL,
      ${Schema.state.gearsAreVisible} INTEGER CHECK(${Schema.state.gearsAreVisible} IN (0, 1)) NOT NULL,
      ${Schema.state.fixedGearPositionX} REAL NULL,
      ${Schema.state.fixedGearPositionY} REAL NULL,
      ${Schema.state.fixedGearRotation} REAL NOT NULL,
      ${Schema.state.fixedGearDefinitionId} TEXT NOT NULL,
      ${Schema.state.canvasTransform_0} REAL NULL,
      ${Schema.state.canvasTransform_1} REAL NULL,
      ${Schema.state.canvasTransform_2} REAL NULL,
      ${Schema.state.canvasTransform_3} REAL NULL,
      ${Schema.state.canvasTransform_4} REAL NULL,
      ${Schema.state.canvasTransform_5} REAL NULL,
      ${Schema.state.canvasTransform_6} REAL NULL,
      ${Schema.state.canvasTransform_7} REAL NULL,
      ${Schema.state.canvasTransform_8} REAL NULL,
      ${Schema.state.canvasTransform_9} REAL NULL,
      ${Schema.state.canvasTransform_10} REAL NULL,
      ${Schema.state.canvasTransform_11} REAL NULL,
      ${Schema.state.canvasTransform_12} REAL NULL,
      ${Schema.state.canvasTransform_13} REAL NULL,
      ${Schema.state.canvasTransform_14} REAL NULL,
      ${Schema.state.canvasTransform_15} REAL NULL,
      ${Schema.state.canvasSize} TEXT
        CHECK(${Schema.state.canvasSize} IN (${CanvasSize.all.map((t) => "'${t.id}'").join(', ')}))
        NULL,
      ${Schema.state.strokeWidth} REAL NOT NULL,
      ${Schema.state.strokeStyle} TEXT
        CHECK(${Schema.state.strokeStyle} IN (${StrokeStyleType.all.map((t) => "'$t'").join(', ')}))
        NOT NULL,
      ${Schema.state.dragLinePositionX} REAL NULL,
      ${Schema.state.dragLinePositionY} REAL NULL,
      ${Schema.state.dragLineAngle} REAL NOT NULL,
      ${Schema.state.lastTileSnapshotVersion} INTEGER NOT NULL
    )
  ''');
  batch.execute('''
    INSERT INTO ${Schema.state} (
      ${Schema.state.selectedPenColor},
      ${Schema.state.selectedCanvasColor},
      ${Schema.state.lastSelectedPenColor},
      ${Schema.state.lastSelectedCanvasColor},
      ${Schema.state.includeBackgroundWhenSaving},
      ${Schema.state.closeDrawingToolsDrawerOnDrag},
      ${Schema.state.preventIncompatibleGearPairings},
      ${Schema.state.rotatingGearAngle},
      ${Schema.state.rotatingGearDefinitionId},
      ${Schema.state.rotatingGearActiveHoleName},
      ${Schema.state.gearsAreVisible},
      ${Schema.state.fixedGearRotation},
      ${Schema.state.fixedGearDefinitionId},
      ${Schema.state.strokeWidth},
      ${Schema.state.strokeStyle},
      ${Schema.state.dragLineAngle},
      ${Schema.state.lastTileSnapshotVersion}
    )
    VALUES
      (
        'ab91b67b-e1f0-4d45-9d99-d67383e23bea',
        'e243e24c-17be-40fa-8505-091a0f2e2a03',
        '97a24b56-edc6-4613-beeb-f9a139f7f669',
        'c0ed2d30-86cf-46a1-b7cf-271fd56b1756',
        1,
        0,
        1,
        $_startingAngle,
        'circle52',
        '30',
        1,
        0,
        'circle96Ring',
        5.0,
        '${StrokeStyleType.normal}',
        $_startingAngle,
        0
      )
  ''');
}

void _createTableInkLinesV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.inkLines}');
  batch.execute('''
    CREATE TABLE ${Schema.inkLines}(
      ${Schema.inkLines.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.inkLines.strokeWidth} REAL NOT NULL,
      ${Schema.inkLines.strokeStyle} TEXT
        CHECK(${Schema.inkLines.strokeStyle} IN (${StrokeStyleType.all.map((t) => "'$t'").join(', ')}))
        NOT NULL,
      ${Schema.inkLines.colorId} TEXT NULL REFERENCES ${Schema.colors}(${Schema.colors.id}),
      "${Schema.inkLines.order}" INTEGER NOT NULL
    )
  ''');
}

void _createTableLineSegmentsV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.lineSegments}');
  batch.execute('''
    CREATE TABLE ${Schema.lineSegments}(
      ${Schema.lineSegments.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.lineSegments.inkLineId} TEXT NULL REFERENCES ${Schema.inkLines}(${Schema.inkLines.id}),
      "${Schema.inkLines.order}" INTEGER NOT NULL
    )
  ''');
}

void _createTablePointsV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.points}');
  batch.execute('''
    CREATE TABLE ${Schema.points}(
      ${Schema.points.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.points.lineSegmentId} TEXT NULL REFERENCES ${Schema.lineSegments}(${Schema.lineSegments.id}),
      ${Schema.points.x} REAL NOT NULL,
      ${Schema.points.y} REAL NOT NULL,
      "${Schema.inkLines.order}" INTEGER NOT NULL
    )
  ''');
}

void _createTableTileDataV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.tileData}');
  batch.execute('''
    CREATE TABLE ${Schema.tileData}(
      ${Schema.tileData.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.tileData.x} REAL NOT NULL,
      ${Schema.tileData.y} REAL NOT NULL,
      ${Schema.tileData.bytes} BLOB NOT NULL
    )
  ''');
}

void _createTableTileSnapshotsV1(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.tileSnapshots}');
  batch.execute('''
    CREATE TABLE ${Schema.tileSnapshots}(
      ${Schema.tileSnapshots.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.tileSnapshots.tileDataId} TEXT NOT NULL REFERENCES ${Schema.tileData}(${Schema.tileData.id}),
      ${Schema.tileSnapshots.version} INTEGER NOT NULL
    )
  ''');
}
