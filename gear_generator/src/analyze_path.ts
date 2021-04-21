import { ContactPoint } from './models/contact_point';
import { GearDefinition } from './models/gear_definition';
import { AngleGearHole } from './models/gear_hole';
import { allEntitlements } from './models/entitlement';
import { allPackages } from './models/package';
import { Point } from './models/point';

export interface AnalyzePathParams {
  baseScale: number;
  toothHeight: number;
  meshSpacing: number;
  gearName: string;
  camelCasedGearName: string;
  allEntitlements: typeof allEntitlements;
  allPackages: typeof allPackages;
}

/**
 * Finds the <path> element in the page, breaks it into chunks
 * of equal-sized length, and returns each line segment and
 * its direction (A.K.A. normal line).
 *
 * NOTE: This function is run in the context of an HTML
 * rendered inside a headless Chrome instance. Because of this,
 * all variables it uses must be accepted as a parameter
 * (top-level `import`s won't work).
 */
export const analyzePath = ({
  baseScale,
  toothHeight,
  meshSpacing,
  gearName,
  camelCasedGearName,
  allEntitlements,
  allPackages,
}: AnalyzePathParams): GearDefinition => {
  const pi2 = 2 * Math.PI;

  const svg = document.querySelector('svg');
  const path = svg.querySelector('path');

  // Find the entitlement ID embeded in the <entitlement-id> element.
  // If no <entitlement-id> element was provided, the gear is assumed to free.
  // If an invalid entitlement ID is found, an error is thown.
  const entitlementId = (
    document.querySelector('svg desc entitlement-id')?.textContent ||
    allEntitlements.free.id
  ).trim();
  const entitlement = Object.values(allEntitlements).find(
    (p) => p.id === entitlementId,
  );
  if (!entitlement) {
    throw new Error(`Unrecognized entitlement id: "${entitlementId}"`);
  }

  // Similar to above, but for the package ID
  const packageId = (
    document.querySelector('svg desc package-id')?.textContent ||
    allPackages.free.id
  ).trim();
  const gearPackage = Object.values(allPackages).find(
    (p) => p.id === packageId,
  );
  if (!gearPackage) {
    throw new Error(`Unrecognized package id: "${packageId}"`);
  }

  // Find the gear's relative order
  const gearOrder = parseInt(
    document.querySelector('svg desc gear-order')?.textContent,
    10,
  );
  if (Number.isNaN(gearOrder)) {
    throw new Error(
      'Gear must contain a <gear-order> element, and it must be an integer',
    );
  }

  // The total length of the path
  const totalLength = path.getTotalLength();

  // Compute the number of teeth that will fit on this gear.
  // By convention, each tooth takes 2*pi of arc length.
  const toothCount = Math.round(path.getTotalLength() / pi2);

  // How long each segment will be
  const segmentLength = totalLength / toothCount;

  // While iterating below, keep track of the biggest and
  // smallest x and y values, so we know how big
  // the final image should be
  let boundaries = {
    x: {
      min: Infinity,
      max: -Infinity,
    },
    y: {
      min: Infinity,
      max: -Infinity,
    },
  };

  // Step around the path bit by bit, recording
  // the coordinates of each point as we go
  let evaluatedPoints: ContactPoint[] = [];
  for (let i = 0; i < toothCount; i++) {
    const currentLength = i * segmentLength;

    const { x, y } = path.getPointAtLength(currentLength);

    evaluatedPoints.push({
      position: { x, y },
      direction: 0, // direction will be computed below
    });

    // Update the boundaries if any of these points
    // were the most extreme we've seen so far.
    boundaries = {
      x: {
        min: Math.min(boundaries.x.min, x),
        max: Math.max(boundaries.x.max, x),
      },
      y: {
        min: Math.min(boundaries.y.min, y),
        max: Math.max(boundaries.y.max, y),
      },
    };
  }

  // Compute the final image size and the center point of the
  // image from the boundary points we found above.
  const svgSize = {
    width: Math.round(boundaries.x.max - boundaries.x.min),
    height: Math.round(boundaries.y.max - boundaries.y.min),
  };

  // Look in the document for a <circle id="center-point"> element.
  // If found, this point indicates the center point of the gear.
  // If not found, the center point defaults to the center of the shape.
  const centerPointCircle = document.querySelector('circle#center-point');

  let centerPoint: Point;
  if (centerPointCircle) {
    centerPoint = {
      x: parseFloat(centerPointCircle.getAttribute('cx')) - boundaries.x.min,
      y: parseFloat(centerPointCircle.getAttribute('cy')) - boundaries.y.min,
    };
  } else {
    centerPoint = {
      x: svgSize.width / 2,
      y: svgSize.height / 2,
    };
  }

  // Remove any extra whitespace from the top or left of the gear,
  // so that the gear sits flush with the axes. This allows the
  // SVG source images to not worry about being perfectly
  // flush with the edge of the their bounds.
  evaluatedPoints = evaluatedPoints.map((point) => ({
    ...point,
    position: {
      x: point.position.x - boundaries.x.min,
      y: point.position.y - boundaries.y.min,
    },
  }));

  // Update each point so that:
  //   1. each point has the correct direction (A.K.A normal line)
  //      by computing the angle perpendicular to the line between
  //      the previous and next points
  //   2. each point's position is expanded to take into account
  //      the tooth and mesh heights
  //   3. the origin is moved to the center of the gear and the
  //      correct scaling is applied
  evaluatedPoints = evaluatedPoints.map((point, index) => {
    // The previous point, or the last point if this is the first point
    const previousPoint =
      evaluatedPoints[
        (evaluatedPoints.length + index - 1) % evaluatedPoints.length
      ];

    // The next point, or the first point if this is the last point
    const nextPoint = evaluatedPoints[(index + 1) % evaluatedPoints.length];

    // Compute the angle between the two points
    let direction = Math.atan2(
      (nextPoint.position.y - previousPoint.position.y) * -1,
      nextPoint.position.x - previousPoint.position.x,
    );

    // Rotate the angle by a right angle so that it's perpendicular to the two points
    direction = direction - Math.PI / 2;

    // Adjust the angle so that it's in the range [0, 2+PI)
    direction = (direction + pi2) % pi2;

    // Move the origin to the center of the gear and apply scaling
    let adjustedPoint = {
      x: (point.position.x - centerPoint.x) * baseScale,
      y: (point.position.y - centerPoint.y) * baseScale,
    };

    // Update the position to take the tooth height into account
    const gearSpacing = toothHeight / 2 + meshSpacing / 2;
    adjustedPoint = {
      x: adjustedPoint.x + Math.cos(direction) * gearSpacing * baseScale,
      y: adjustedPoint.y + Math.sin(direction) * gearSpacing * baseScale * -1,
    };

    return {
      position: adjustedPoint,
      direction,
    };
  });

  // Read each hole definition from the SVG
  const holes: AngleGearHole[] = Array.from(
    document.querySelectorAll('#holes circle'),
  )
    .map((circle) => {
      const x =
        parseFloat(circle.getAttribute('cx')) -
        centerPoint.x -
        boundaries.x.min;
      const y =
        parseFloat(circle.getAttribute('cy')) -
        centerPoint.y -
        boundaries.y.min;

      const angle = Math.atan2(-y, x);
      const distance = Math.sqrt(x ** 2 + y ** 2);

      const hole: AngleGearHole = {
        name: circle.getAttribute('inspiral:hole-name'),
        angle,
        distance,
        textPositionAngle: parseFloat(
          circle.getAttribute('inspiral:hole-text-position-angle'),
        ),
        textRotationAngle: parseFloat(
          circle.getAttribute('inspiral:hole-text-rotation-angle'),
        ),
      };

      return hole;
    })
    .sort((a, b) => a.distance - b.distance);

  const gearDefinition: GearDefinition = {
    gearName,
    camelCasedGearName,
    image: `images/gears/${gearName}.png`,
    thumbnailImage: `images/gears/${gearName}_thumb.png`,
    size: {
      width: (svgSize.width + (toothHeight + meshSpacing) * 2) * baseScale,
      height: (svgSize.height + (toothHeight + meshSpacing) * 2) * baseScale,
    },
    center: {
      x: (centerPoint.x + toothHeight + meshSpacing) * baseScale,
      y: (centerPoint.y + toothHeight + meshSpacing) * baseScale,
    },
    toothCount,
    points: evaluatedPoints,
    holes,
    entitlement,
    package: gearPackage,
    gearOrder,
  };

  return gearDefinition;
};
