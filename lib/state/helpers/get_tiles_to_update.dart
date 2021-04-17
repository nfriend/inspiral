import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/ink_line.dart';

/// Determines which tiles need to update by matching each point up
/// with the appropriate tile
Set<Offset> getTilesToUpdate(
    {@required List<InkLine> linesToBake, @required Size tileSize}) {
  var tilesToUpdate = HashSet<Offset>();

  for (var line in linesToBake) {
    for (var lineSegment in line.points) {
      for (var point in lineSegment) {
        var surroundingPointDistance =
            max(maxStrokeWidth, maxLineSegmentLength);

        // Expand the search radius slightly. Otherwise a line with a very
        // wide stroke might brush a corner or edge of another tile, but
        // because the point itself isn't in the tile, the tile wouldn't
        // be considered as needing updating.
        var surroundingPoints = <Offset>[
          point + Offset(-surroundingPointDistance, 0),
          point + Offset(surroundingPointDistance, 0),
          point + Offset(0, -surroundingPointDistance),
          point + Offset(0, surroundingPointDistance)
        ];

        // Find the correct tile for each point
        // (Each tile is keyed by the position of its top-left corner)
        for (var nearbyPoint in surroundingPoints) {
          var containingTile = Offset(
              (nearbyPoint.dx / tileSize.width).floor() * tileSize.width,
              (nearbyPoint.dy / tileSize.height).floor() * tileSize.height);
          tilesToUpdate.add(containingTile);
        }
      }
    }
  }

  return tilesToUpdate;
}
