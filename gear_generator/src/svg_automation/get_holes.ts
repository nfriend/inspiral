import { holeSize } from '../constants';
import { PointGearHole } from '../models/gear_hole';
import { Point } from '../models/point';

/**
 * Generates holes in a pattern of 6 line radiating from
 * the center of the shape.
 *
 * @param centerPoint The center point of the shape
 * @param holesToGenerate The list of distances (hole numbers) to generate
 * @param holeAlignmentParams If provided, nudges the hole lines to align
 * with the nearest tooth. This only works for circle gears.
 *
 * @returns A list of gear holes
 */
export function getHoles(
  centerPoint: Point,
  holesToGenerate: number[],
  holeAlignmentParams: {
    toothCount: number;
  } = null,
): PointGearHole[] {
  const holes: PointGearHole[] = [];

  const holeSpacing = holeSize * 2;
  const holeAndSpacing = Math.ceil(holeSize + holeSpacing);
  const maximumDistance = Math.max(...holesToGenerate);
  const lineCount = 8;

  for (let lineIndex = 0; lineIndex < lineCount; lineIndex++) {
    for (
      let distance = lineIndex === 0 ? 0 : lineIndex + holeAndSpacing;
      distance <= maximumDistance;
      distance += holeAndSpacing
    ) {
      if (!holesToGenerate.includes(distance)) {
        continue;
      }

      // The lines of holes will approximately divide the gear into
      // six equal parts, but we move the lines slightly so that the
      // line always align with a tooth.

      // This angle is the exact angle that divides the gear into sixths
      let angle = Math.PI * (1 / 2) + Math.PI * (2 / lineCount) * lineIndex;

      if (holeAlignmentParams?.toothCount) {
        const anglePerTooth = (Math.PI * 2) / holeAlignmentParams.toothCount;
        // This angle is the "adjusted" angle that matches up with a nearby tooth
        angle = anglePerTooth * Math.round(angle / anglePerTooth);
      }

      holes.push(
        getHole({
          angle,
          distanceFromCenter: distance,
          centerPoint,
        }),
      );
    }
  }

  return holes;
}

/** Returns a `GearHole` object based on the provided parameters */
function getHole({
  angle,
  distanceFromCenter,
  centerPoint,
}: {
  angle: number;
  distanceFromCenter: number;
  centerPoint: Point;
}): PointGearHole {
  // Some special handling for the text for
  // especially cramped numbers
  const specialCases: {
    [key: number]: { position: number; rotation: number };
  } = {
    0: { position: -Math.PI, rotation: 0 },
    8: { position: -0.8, rotation: -0.7 },
    9: { position: -0.8, rotation: -0.7 },
    10: { position: -0.4, rotation: 0 },
    11: { position: -0.5, rotation: 0 },
    12: { position: -0.2, rotation: 0 },
    13: { position: -0.4, rotation: 0 },
    14: { position: -0.2, rotation: 0 },
    15: { position: -0.2, rotation: 0 },
    16: { position: -0.4, rotation: 0 },
    17: { position: -0.4, rotation: 0 },
  };

  return {
    name: distanceFromCenter.toString(),
    point: {
      x: centerPoint.x + Math.cos(angle) * distanceFromCenter,
      y: centerPoint.y + -1 * Math.sin(angle) * distanceFromCenter,
    },
    textPositionAngle:
      angle +
      Math.PI * (1 / 2) +
      (specialCases[distanceFromCenter]?.position || 0),
    textRotationAngle:
      Math.PI * (1 / 2) -
      angle +
      (specialCases[distanceFromCenter]?.rotation || 0),
  };
}
