import path from 'path';
import fs from 'fs';
import util from 'util';
import ejs from 'ejs';
import { GearDefinition } from './models/gear_definition';
import { GearPath } from './models/gear_path';
import { ImageInfo } from './models/image_info';
import {
  baseScale,
  holeSize,
  meshSpacing as unscaledMeshSpacing,
  thumbnailSize,
  toothHeight as unscaledToothHeight,
} from './constants';
import { hostSvgInHTml } from './util/host_svg_in_html';
import { ContactPoint } from './models/contact_point';
import { Point } from './models/point';
import { AngleGearHole } from './models/gear_hole';
import { radiansToDegrees } from './util/radians_to_degrees';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

// The height of each tooth, after being scaled
const toothHeight = unscaledToothHeight * baseScale;

// The height of each tooth + the breashing space
// added for nice gear meshing, after being scaled
const toothAndMeshHeight =
  (unscaledToothHeight - unscaledMeshSpacing) * baseScale;

// The total arc length each tooth occupies
const toothLength = Math.PI * 2 * baseScale;

// The length of the top of each tooth
const toothTopLength = toothLength * (2 / 12);

// The length of each side of the tooth
const toothSideLength = Math.sqrt(
  (toothLength * (4 / 12)) ** 2 + toothHeight ** 2,
);

// The angle (relative to the tooth's normal line)
// at which the side points down to the tooth's "valley"
const toothSideAngle = Math.asin((toothLength * (4 / 12)) / toothSideLength);

/**
 * Build SVG representations (regular and thumbnail) of a gear based
 * on the points of the provided `GearDefinition`, and writes the
 * results to files.
 *
 * @param gearDefinition The definition of the gear to generate
 * @returns The file paths to the SVGs
 */
export const generateSvgs = async (
  gearDefinition: GearDefinition,
): Promise<ImageInfo[]> => {
  const centerPoint: Point = gearDefinition.center;

  const svgPath: GearPath = new GearPath();

  for (let i = 0; i < gearDefinition.points.length; i++) {
    // Generate the "left" side of the current tooth
    generateSecondHalfOfTooth({
      point: gearDefinition.points[i],
      path: svgPath,
      centerPoint,
      includeInitialMoveCommand: i === 0,
    });

    // And the "right" side of the next tooth
    generateFirstHalfOfTooth({
      point: gearDefinition.points[(i + 1) % gearDefinition.points.length],
      path: svgPath,
      centerPoint,
    });
  }

  svgPath.closePath();

  const imageInfos: ImageInfo[] = [];

  const allOptions = [
    {
      postfix: '',
      imageSize: {
        width: gearDefinition.size.width,
        height: gearDefinition.size.height,
      },
      transparency: 'lots',
    },
    {
      postfix: '_thumb',
      imageSize: {
        width: thumbnailSize,
        height: thumbnailSize,
      },
      transparency: 'just a little',
    },
  ];

  const templateFilePath = path.resolve(
    __dirname,
    './templates/svgs_for_rendering/gear.svg.ejs',
  );

  const holes = gearDefinition.holes.map((h) =>
    generateHole({ hole: h, centerPoint }),
  );

  if (gearDefinition.isRing) {
    addOuterShape({ gearDefinition, svgPath });
  }

  for (const options of allOptions) {
    const imageInfo: ImageInfo = {
      svgPath: path.resolve(
        __dirname,
        '../tmp',
        `${gearDefinition.gearName}${options.postfix}.svg`,
      ),
      htmlPath: path.resolve(
        __dirname,
        '../tmp',
        `${gearDefinition.gearName}${options.postfix}.html`,
      ),
      pngPath: path.resolve(
        __dirname,
        '../../images/gears',
        `${gearDefinition.gearName}${options.postfix}.png`,
      ),
      width: options.imageSize.width,
      height: options.imageSize.height,
    };

    const rendered = await renderFile(templateFilePath, {
      imageSize: options.imageSize,
      viewBox: gearDefinition.size,
      baseScale,
      transparency: options.transparency,
      gearPath: svgPath,
      holes,
    });

    await writeFile(imageInfo.svgPath, rendered);
    await writeFile(
      imageInfo.htmlPath,
      hostSvgInHTml({ svgFilePath: imageInfo.svgPath, width: imageInfo.width }),
    );

    imageInfos.push(imageInfo);
  }

  return imageInfos;
};

/**
 * Generates the "second" half of a gear tooth, i.e. the "left" side of a tooth
 *
 * @param params
 * @param params.point The point to use as a reference when generating the tooth
 * @param params.path The `GearPath` object to mutate
 * @param params.centerPoint The center point of the SVG image
 * @param params.includeInitialMoveCommand Whether or not to begin the path with a "move"
 * command to the starting point of the tooth. This is used only to initialize
 * the cursor for the very first tooth.
 */
const generateSecondHalfOfTooth = ({
  point,
  path,
  centerPoint,
  includeInitialMoveCommand = false,
}: {
  point: ContactPoint;
  path: GearPath;
  centerPoint: Point;
  includeInitialMoveCommand?: boolean;
}) => {
  // The coordinates in the ContactPoint assume the origin is in the
  // center of the gear. For our purposes (rendering an SVG), we instead
  // want the origin to be in the top left of the image. So we "uncenter"
  // the point, i.e. move the origin to the top left.
  const unCenteredPoint: Point = {
    x: point.position.x + centerPoint.x,
    y: point.position.y + centerPoint.y,
  };

  // Calculate the position of the middle of the gear tooth based on the
  // `ContactPoint`. Reminder: The `ContactPoint` specifies the _middle_
  // of the tooth, because this is what allows the gears to mesh. Because
  // of this, we only add _half_ the tooth (and mesh) height,
  // not the full height.
  const toothTopCenter: Point = {
    x: unCenteredPoint.x + (Math.cos(point.direction) * toothAndMeshHeight) / 2,
    y:
      unCenteredPoint.y +
      ((Math.sin(point.direction) * toothAndMeshHeight) / 2) * -1,
  };

  if (includeInitialMoveCommand) {
    path.moveTo({ point: toothTopCenter });
  }

  const toothTopLeft: Point = {
    x:
      toothTopCenter.x +
      Math.cos(point.direction + Math.PI / 2) * (toothTopLength / 2),
    y:
      toothTopCenter.y +
      Math.sin(point.direction + Math.PI / 2) * (toothTopLength / 2) * -1,
  };

  path.lineTo({ point: toothTopLeft });

  const toothBottomLeft: Point = {
    x:
      toothTopLeft.x +
      Math.cos(point.direction + Math.PI - toothSideAngle) * toothSideLength,
    y:
      toothTopLeft.y +
      Math.sin(point.direction + Math.PI - toothSideAngle) *
        toothSideLength *
        -1,
  };

  path.lineTo({ point: toothBottomLeft });
};

/**
 * Generates the "first" half of a gear tooth, i.e. the "right" side of a tooth
 *
 * @param params
 * @param params.point The point to use as a reference when generating the tooth
 * @param params.path The `GearPath` object to mutate
 * @param params.centerPoint The center point of the SVG image
 */
const generateFirstHalfOfTooth = ({
  point,
  path,
  centerPoint,
}: {
  point: ContactPoint;
  path: GearPath;
  centerPoint: Point;
}) => {
  // The coordinates in the ContactPoint assume the origin is in the
  // center of the gear. For our purposes (rendering an SVG), we instead
  // want the origin to be in the top left of the image. So we "uncenter"
  // the point, i.e. move the origin to the top left.
  const unCenteredPoint: Point = {
    x: point.position.x + centerPoint.x,
    y: point.position.y + centerPoint.y,
  };

  const toothTopCenter: Point = {
    x: unCenteredPoint.x + (Math.cos(point.direction) * toothAndMeshHeight) / 2,
    y:
      unCenteredPoint.y +
      ((Math.sin(point.direction) * toothAndMeshHeight) / 2) * -1,
  };

  const toothTopRight: Point = {
    x:
      toothTopCenter.x +
      Math.cos(point.direction - Math.PI / 2) * (toothTopLength / 2),
    y:
      toothTopCenter.y +
      Math.sin(point.direction - Math.PI / 2) * (toothTopLength / 2) * -1,
  };

  const toothBottomRight: Point = {
    x:
      toothTopRight.x +
      Math.cos(point.direction + Math.PI + toothSideAngle) * toothSideLength,
    y:
      toothTopRight.y +
      Math.sin(point.direction + Math.PI + toothSideAngle) *
        toothSideLength *
        -1,
  };

  path.lineTo({ point: toothBottomRight });
  path.lineTo({ point: toothTopRight });
};

/**
 * Returns all the information needed to render a hole in
 * the final SVG.
 *
 * @param params
 * @param params.hole The hole to draw
 * @param params.centerPoint The center point of the SVG image
 */
const generateHole = ({
  hole,
  centerPoint,
}: {
  hole: AngleGearHole;
  centerPoint: Point;
}): {
  path: GearPath;
  text: {
    position: Point;
    content: string;
    rotation: number;
  };
} => {
  const holeCenter: Point = {
    x: Math.cos(hole.angle) * hole.distance * baseScale + centerPoint.x,
    y: -1 * Math.sin(hole.angle) * hole.distance * baseScale + centerPoint.y,
  };

  const scaledRadius = holeSize * baseScale;

  const path = new GearPath()
    .moveTo({
      point: {
        x: holeCenter.x + scaledRadius,
        y: holeCenter.y,
      },
    })
    .arc({
      radiusX: scaledRadius,
      radiusY: scaledRadius,
      largeArcFlag: true,
      newPosition: {
        x: holeCenter.x - scaledRadius,
        y: holeCenter.y,
      },
    })
    .arc({
      radiusX: scaledRadius,
      radiusY: scaledRadius,
      newPosition: {
        x: holeCenter.x + scaledRadius,
        y: holeCenter.y,
      },
    })
    .closePath();

  // Controls the distance between the hole text and the hole.
  // Make it larger for 3-digit numbers (since the text is
  // effectively left-aligned).
  const holeMargin = hole.distance > 99 ? 2.6 : 2.1;

  const textPosition: Point = {
    x:
      holeCenter.x +
      Math.cos(hole.textPositionAngle) * holeMargin * scaledRadius,
    y:
      holeCenter.y +
      -1 * Math.sin(hole.textPositionAngle) * holeMargin * scaledRadius,
  };

  return {
    path,
    text: {
      position: textPosition,
      content: hole.name,
      rotation: radiansToDegrees(hole.textRotationAngle),
    },
  };
};

/**
 * Adds a path around the gear that forms the outer edge of ring gears.
 */
const addOuterShape = ({
  svgPath,
  gearDefinition,
}: {
  svgPath: GearPath;
  gearDefinition: GearDefinition;
}): void => {
  const {
    ringBorderRadius: radius,
    size: { width, height },
  } = gearDefinition;

  // Offset the stroke from the edge, othewise it gets partially cut off
  const edgeOffset = 2.0;

  svgPath
    .moveTo({ point: { x: width - edgeOffset, y: height / 2 + edgeOffset } })
    .lineTo({ point: { x: width - edgeOffset, y: radius + edgeOffset } })
    .arc({
      radiusX: radius,
      radiusY: radius,
      newPosition: { x: width - radius, y: edgeOffset },
    })
    .lineTo({ point: { x: radius + edgeOffset, y: edgeOffset } })
    .arc({
      radiusX: radius,
      radiusY: radius,
      newPosition: { x: edgeOffset, y: radius + edgeOffset },
    })
    .lineTo({ point: { x: edgeOffset, y: height - radius - edgeOffset } })
    .arc({
      radiusX: radius,
      radiusY: radius,
      newPosition: { x: radius + edgeOffset, y: height - edgeOffset },
    })
    .lineTo({
      point: { x: width - radius - edgeOffset, y: height - edgeOffset },
    })
    .arc({
      radiusX: radius,
      radiusY: radius,
      newPosition: { x: width - edgeOffset, y: height - radius - edgeOffset },
    })
    .closePath();
};
