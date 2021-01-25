import path from 'path';
import fs from 'fs';
import util from 'util';
import { GearDefinition } from './gear_definition';
import { GearPath } from './gear_path';
import { GearSvg } from './gear_svg';
import { ImageInfo } from './image_info';
import {
  baseScale,
  meshSpacing as unscaledMeshSpacing,
  toothHeight as unscaledToothHeight,
} from './constants';
import { hostSvgInHTml } from './util/host_svg_in_html';
import { ContactPoint } from './contact_point';
import { Point } from './point';

const writeFile = util.promisify(fs.writeFile);

// The height of each tooth, after being scaled
const toothHeight = unscaledToothHeight * baseScale;

// The height of each tooth + the breashing space
// added for nice gear meshing, after being scaled
const toothAndMeshHeight =
  (unscaledToothHeight + unscaledMeshSpacing) * baseScale;

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

// The length of the "valley" between each tooth
const toothValleyLength = toothTopLength;

/**
 * Builds an SVG representation of a gear based on the points
 * of the provided `GearDefinition`, and writes the
 * result to a file.
 *
 * @param gearDefinition The definition of the gear to generate
 * @returns The file path to the SVG
 */
export const generateSvg = async (
  gearDefinition: GearDefinition,
): Promise<ImageInfo> => {
  const centerPoint = {
    x: gearDefinition.size.width / 2,
    y: gearDefinition.size.height / 2,
  };

  const svgPath: GearPath = new GearPath().moveTo({
    // TODO: What's the correct starting point?
    x: centerPoint.x,
    y: centerPoint.y,
  });

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

  const svg = new GearSvg({
    path: svgPath,
    width: gearDefinition.size.width,
    height: gearDefinition.size.height,
  });

  const imageInfo: ImageInfo = {
    svgPath: path.resolve(
      __dirname,
      '../tmp',
      `${gearDefinition.gearName}.svg`,
    ),
    htmlPath: path.resolve(
      __dirname,
      '../tmp',
      `${gearDefinition.gearName}.html`,
    ),
    pngPath: path.resolve(
      __dirname,
      '../tmp',
      `${gearDefinition.gearName}.png`,
    ),
    width: gearDefinition.size.width,
    height: gearDefinition.size.height,
  };

  await writeFile(imageInfo.svgPath, svg.toString());
  await writeFile(
    imageInfo.htmlPath,
    hostSvgInHTml({ svgFilePath: imageInfo.svgPath, width: imageInfo.width }),
  );

  return imageInfo;
};

/**
 * Generates the "second" half of a gear tooth, i.e. the "left" side of a tooth
 *
 * @param point The point to use as a reference when generating the tooth
 * @param path The `GearPath` object to mutate
 * @param includeInitialMoveCommand Whether or not to begin the path with a "move"
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
    path.moveTo(toothTopCenter);
  }

  const toothTopLeft: Point = {
    x:
      toothTopCenter.x +
      Math.cos(point.direction + Math.PI / 2) * (toothTopLength / 2),
    y:
      toothTopCenter.y +
      Math.sin(point.direction + Math.PI / 2) * (toothTopLength / 2) * -1,
  };

  path.lineTo(toothTopLeft);

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

  path.lineTo(toothBottomLeft);
};

/**
 * Generates the "first" half of a gear tooth, i.e. the "right" side of a tooth
 *
 * @param point The point to use as a reference when generating the tooth
 * @param path The `GearPath` object to mutate
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

  path.lineTo(toothBottomRight);
  path.lineTo(toothTopRight);
};
