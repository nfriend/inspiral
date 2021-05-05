import 'package:inspiral/database/schema.dart';
import 'package:sqflite/sqflite.dart';

Future<void> seedV3Data(Database db) async {
  var batch = db.batch();

  batch.execute('''
    INSERT INTO ${Schema.snapPoints} (
      ${Schema.snapPoints.id},
      ${Schema.snapPoints.x},
      ${Schema.snapPoints.y},
      ${Schema.snapPoints.isActive},
      ${Schema.snapPoints.version}
    )
    VALUES
    (
      '75f14527-2859-4c5a-aee6-6e5c73e3eae6',
      8.0,
      12.0,
      0,
      NULL
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.snapPoints} (
      ${Schema.snapPoints.id},
      ${Schema.snapPoints.x},
      ${Schema.snapPoints.y},
      ${Schema.snapPoints.isActive},
      ${Schema.snapPoints.version}
    )
    VALUES
    (
      'f9c61bfd-bc73-46fc-8854-08c9f7ac6107',
      15.0,
      20.0,
      1,
      NULL
    )
  ''');

  batch.execute('''
    INSERT INTO ${Schema.snapPoints} (
      ${Schema.snapPoints.id},
      ${Schema.snapPoints.x},
      ${Schema.snapPoints.y},
      ${Schema.snapPoints.isActive},
      ${Schema.snapPoints.version}
    )
    VALUES
    (
      'b83d3c4f-d854-4bb0-b976-995c55025ca1',
      8.0,
      12.0,
      1,
      1
    )
  ''');

  await batch.commit();
}
