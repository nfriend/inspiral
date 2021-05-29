import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';

class TileVersionResult {
  final Map<Offset, Image> tileImages;
  final Map<Offset, String > tilePositionToDatabaseId;

  TileVersionResult(
      {required this.tileImages, required this.tilePositionToDatabaseId});

  @override
  String toString() {
    return 'TileVersionResult(# of tileImages: ${tileImages.length}, # of tilePositionToDatabaseId: ${tilePositionToDatabaseId.length})';
  }
}

/// Gets the set of image tiles at a specific version
///
/// @param version The version to retrieve
Future<TileVersionResult> getTilesForVersion(int? version) async {
  var db = await getDatabase();

  var allTileData = await db.rawQuery('''
      SELECT
        td.${Schema.tileData.id} AS ${Schema.tileData.id},
        td.${Schema.tileData.x} AS ${Schema.tileData.x},
        td.${Schema.tileData.y} AS ${Schema.tileData.y},
        td.${Schema.tileData.bytes} AS ${Schema.tileData.bytes}
      FROM ${Schema.tileData} td
      INNER JOIN ${Schema.tileSnapshots} ts
        ON td.${Schema.tileData.id} == ts.${Schema.tileSnapshots.tileDataId}
      WHERE ts.${Schema.tileSnapshots.version} == $version
    ''');

  var tileImages = <Offset, Image>{};
  Map<Offset, String?> tilePositionToDatabaseId = <Offset, String >{};
  for (var tileData in allTileData) {
    var tilePosition = Offset(tileData[Schema.tileData.x] as double,
        tileData[Schema.tileData.y] as double);
    tileImages[tilePosition] =
        await decodeImageFromList(tileData[Schema.tileData.bytes] as Uint8List);
    tilePositionToDatabaseId[tilePosition] =
        tileData[Schema.tileData.id] as String?;
  }

  return TileVersionResult(
      tileImages: tileImages,
      tilePositionToDatabaseId: tilePositionToDatabaseId);
}
