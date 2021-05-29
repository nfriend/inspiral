import 'package:inspiral/constants.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/canvas_size.dart';
import 'package:inspiral/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

/// A utility class to hold all the IDs of the selected color rows
class _SelectedColorIds {
  String? selectedPenId;
  String? selecteCanvasId;
  String? lastSelectedPenId;
  String? lastSelectedCanvasId;
}

/// The very first migration. Called when the database is first created.
Future<void> upgradeV0ToV1(Database db) async {
  var batch = db.batch();

  var selectedIds = _createTableColors(batch);
  _createTableState(batch, selectedIds);
  _createTableInkLines(batch);
  _createTableLineSegments(batch);
  _createTablePoints(batch);
  _createTableTileData(batch);
  _createTableTileSnapshots(batch);

  await batch.commit(noResult: true);
}

_SelectedColorIds _createTableColors(Batch batch) {
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

  var selectedIds = _SelectedColorIds();

  for (var i = 0; i < defaultPenColors.length; i++) {
    var color = defaultPenColors[i];
    var colorId = _uuid.v4();

    batch.insert(Schema.colors.toString(), {
      Schema.colors.id: colorId,
      Schema.colors.value: color.toHexString(),
      Schema.colors.type: ColorsTableType.pen,
      Schema.colors.order: i + 1
    });

    if (color == defaultSelectedPenColor) {
      selectedIds.selectedPenId = colorId;
    }
  }

  for (var i = 0; i < defaultCanvasColors.length; i++) {
    var color = defaultCanvasColors[i];
    var colorId = _uuid.v4();

    batch.insert(Schema.colors.toString(), {
      Schema.colors.id: colorId,
      Schema.colors.value: color.toHexString(),
      Schema.colors.type: ColorsTableType.canvas,
      Schema.colors.order: i + 1
    });

    if (color == defaultSelectedCanvasColor) {
      selectedIds.selecteCanvasId = colorId;
    }
  }

  selectedIds.lastSelectedPenId = _uuid.v4();
  batch.insert(Schema.colors.toString(), {
    Schema.colors.id: selectedIds.lastSelectedPenId,
    Schema.colors.value: defaultLastSelectedPenColor.toHexString(),
    Schema.colors.type: ColorsTableType.lastSelectedPen,
    Schema.colors.order: 1
  });

  selectedIds.lastSelectedCanvasId = _uuid.v4();
  batch.insert(Schema.colors.toString(), {
    Schema.colors.id: selectedIds.lastSelectedCanvasId,
    Schema.colors.value: defaultLastSelectedCanvasColor.toHexString(),
    Schema.colors.type: ColorsTableType.lastSelectedCanvas,
    Schema.colors.order: 1
  });

  return selectedIds;
}

void _createTableState(Batch batch, _SelectedColorIds selectedIds) {
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
      ${Schema.state.currentSnapshotVersion} INTEGER NOT NULL
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
      ${Schema.state.currentSnapshotVersion}
    )
    VALUES
      (
        '${selectedIds.selectedPenId}',
        '${selectedIds.selecteCanvasId}',
        '${selectedIds.lastSelectedPenId}',
        '${selectedIds.lastSelectedCanvasId}',
        1,
        0,
        1,
        $rotatingGearStartingAngle,
        '${defaultRotatingGear.id}',
        '${defaultActiveHole.name}',
        ${defaultGearVisibility.toInt()},
        $fixedGearStartingRotation,
        '${defaultFixedGear.id}',
        $defaultStrokeWidth,
        '${strokeStyleToString(defaultStrokeStyle)}',
        $rotatingGearStartingAngle,
        0
      )
  ''');
}

void _createTableInkLines(Batch batch) {
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

void _createTableLineSegments(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.lineSegments}');
  batch.execute('''
    CREATE TABLE ${Schema.lineSegments}(
      ${Schema.lineSegments.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.lineSegments.inkLineId} TEXT NULL REFERENCES ${Schema.inkLines}(${Schema.inkLines.id}),
      "${Schema.inkLines.order}" INTEGER NOT NULL
    )
  ''');
}

void _createTablePoints(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.points}');
  batch.execute('''
    CREATE TABLE ${Schema.points}(
      ${Schema.points.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.points.lineSegmentId} TEXT NULL REFERENCES ${Schema.lineSegments}(${Schema.lineSegments.id}),
      ${Schema.points.x} REAL NOT NULL,
      ${Schema.points.y} REAL NOT NULL,
      "${Schema.points.order}" INTEGER NOT NULL
    )
  ''');
}

void _createTableTileData(Batch batch) {
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

void _createTableTileSnapshots(Batch batch) {
  batch.execute('DROP TABLE IF EXISTS ${Schema.tileSnapshots}');
  batch.execute('''
    CREATE TABLE ${Schema.tileSnapshots}(
      ${Schema.tileSnapshots.id} TEXT NOT NULL PRIMARY KEY,
      ${Schema.tileSnapshots.tileDataId} TEXT NOT NULL REFERENCES ${Schema.tileData}(${Schema.tileData.id}),
      ${Schema.tileSnapshots.version} INTEGER NOT NULL
    )
  ''');
}
