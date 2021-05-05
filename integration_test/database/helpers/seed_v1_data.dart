import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> seedV1Data(Database db) async {
  var batch = db.batch();

  // Provide values for all the columns that are `null` by default
  batch.execute('''
    UPDATE ${Schema.state}
    SET ${Schema.state.fixedGearPositionX} = 50.0,
        ${Schema.state.fixedGearPositionY} = 85.0,
        ${Schema.state.fixedGearPositionX} = 50.0,
        ${Schema.state.canvasTransform_0}  = 1,
        ${Schema.state.canvasTransform_1}  = 0,
        ${Schema.state.canvasTransform_2}  = 0,
        ${Schema.state.canvasTransform_3}  = 0,
        ${Schema.state.canvasTransform_4}  = 0,
        ${Schema.state.canvasTransform_5}  = 1,
        ${Schema.state.canvasTransform_6}  = 0,
        ${Schema.state.canvasTransform_7}  = 0,
        ${Schema.state.canvasTransform_8}  = 0,
        ${Schema.state.canvasTransform_9}  = 0,
        ${Schema.state.canvasTransform_10} = 1,
        ${Schema.state.canvasTransform_11} = 0,
        ${Schema.state.canvasTransform_12} = 0,
        ${Schema.state.canvasTransform_13} = 0,
        ${Schema.state.canvasTransform_14} = 0,
        ${Schema.state.canvasTransform_15} = 1,
        ${Schema.state.canvasSize}         = 'small',
        ${Schema.state.dragLinePositionX}  = 15.0,
        ${Schema.state.dragLinePositionY}  = 20.0
  ''');

  batch.execute('''
    INSERT INTO ${Schema.inkLines} (
      ${Schema.inkLines.id},
      ${Schema.inkLines.strokeWidth},
      ${Schema.inkLines.strokeStyle},
      ${Schema.inkLines.colorId},
      "${Schema.inkLines.order}"
    )
    VALUES
    (
      'c8c1be5d-ebf5-465f-9a9b-b141bf92dcb8',
      7.0,
      'airbrush',
      'afe32b1e-59c9-483a-b5d4-f0fff028f17f',
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.inkLines} (
      ${Schema.inkLines.id},
      ${Schema.inkLines.strokeWidth},
      ${Schema.inkLines.strokeStyle},
      ${Schema.inkLines.colorId},
      "${Schema.inkLines.order}"
    )
    VALUES
    (
      '781c6a1e-ab38-4cb9-b0d1-3ef156626970',
      8.0,
      'normal',
      'dcc145c5-e904-4456-983c-78ec0326ab20',
      2
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.lineSegments} (
      ${Schema.lineSegments.id},
      ${Schema.lineSegments.inkLineId},
      "${Schema.lineSegments.order}"
    )
    VALUES
    (
      'a77c72f5-a040-4045-9f5d-8a0238a42229',
      'c8c1be5d-ebf5-465f-9a9b-b141bf92dcb8',
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.lineSegments} (
      ${Schema.lineSegments.id},
      ${Schema.lineSegments.inkLineId},
      "${Schema.lineSegments.order}"
    )
    VALUES
    (
      'dae0ca8a-e379-4d97-b503-be3ebbb6aee8',
      '781c6a1e-ab38-4cb9-b0d1-3ef156626970',
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.lineSegments} (
      ${Schema.lineSegments.id},
      ${Schema.lineSegments.inkLineId},
      "${Schema.lineSegments.order}"
    )
    VALUES
    (
      'f2b82768-c375-4cac-9803-176fa375d082',
      '781c6a1e-ab38-4cb9-b0d1-3ef156626970',
      2
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.points} (
      ${Schema.points.id},
      ${Schema.points.lineSegmentId},
      ${Schema.points.x},
      ${Schema.points.y},
      "${Schema.points.order}"
    )
    VALUES
    (
      'a5deda23-5c4b-41e3-b189-b994d9adddff',
      'a77c72f5-a040-4045-9f5d-8a0238a42229',
      50.0,
      70.0,
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.points} (
      ${Schema.points.id},
      ${Schema.points.lineSegmentId},
      ${Schema.points.x},
      ${Schema.points.y},
      "${Schema.points.order}"
    )
    VALUES
    (
      '3249d748-7573-4a8a-84f2-63feda000983',
      'dae0ca8a-e379-4d97-b503-be3ebbb6aee8',
      80.0,
      90.0,
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.points} (
      ${Schema.points.id},
      ${Schema.points.lineSegmentId},
      ${Schema.points.x},
      ${Schema.points.y},
      "${Schema.points.order}"
    )
    VALUES
    (
      '2d82f860-3d35-4927-be04-80153b86b8d9',
      'f2b82768-c375-4cac-9803-176fa375d082',
      110.0,
      10.0,
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.points} (
      ${Schema.points.id},
      ${Schema.points.lineSegmentId},
      ${Schema.points.x},
      ${Schema.points.y},
      "${Schema.points.order}"
    )
    VALUES
    (
      'ab1e2c7e-ab31-408f-87f9-15fa517f0a7a',
      'f2b82768-c375-4cac-9803-176fa375d082',
      115.0,
      15.0,
      2
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.tileData} (
      ${Schema.tileData.id},
      ${Schema.tileData.x},
      ${Schema.tileData.y},
      ${Schema.tileData.bytes}
    )
    VALUES
    (
      'acb68db4-46d4-4a34-8114-3b88d270bc08',
      50.0,
      70.0,
      X'6e617468616e'
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.tileData} (
      ${Schema.tileData.id},
      ${Schema.tileData.x},
      ${Schema.tileData.y},
      ${Schema.tileData.bytes}
    )
    VALUES
    (
      '267fdece-8620-4d5f-b21b-46ea2b7530f9',
      100.0,
      140.0,
      X'667269656e64'
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.tileSnapshots} (
      ${Schema.tileSnapshots.id},
      ${Schema.tileSnapshots.tileDataId},
      ${Schema.tileSnapshots.version}
    )
    VALUES
    (
      '40876f11-edfd-45f9-a6ec-2f38e327f963',
      'acb68db4-46d4-4a34-8114-3b88d270bc08',
      1
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.tileSnapshots} (
      ${Schema.tileSnapshots.id},
      ${Schema.tileSnapshots.tileDataId},
      ${Schema.tileSnapshots.version}
    )
    VALUES
    (
      '870a9262-0580-4c7c-ae24-d6e3c5717aaf',
      'acb68db4-46d4-4a34-8114-3b88d270bc08',
      2
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.tileSnapshots} (
      ${Schema.tileSnapshots.id},
      ${Schema.tileSnapshots.tileDataId},
      ${Schema.tileSnapshots.version}
    )
    VALUES
    (
      'a60abf88-bea2-4e13-b649-f67682433657',
      '267fdece-8620-4d5f-b21b-46ea2b7530f9',
      2
    )
  ''');

  await batch.commit();
}
