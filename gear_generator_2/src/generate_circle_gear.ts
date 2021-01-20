import { ImageInfo } from './image_info';
import path from 'path';
import fs from 'fs';
import util from 'util';
import { baseScale, toothHeight } from './constants';
import { GearPath } from './gear_path';
import { GearSvg } from './gear_svg';
import { Point } from './point';
import { getCirclePoint } from './util/get_circle_point';
import { hostSvgInHTml } from './util/host_svg_in_html';

const writeFile = util.promisify(fs.writeFile);

interface CircleGearParams {
  toothCount: number;
}

export const generateCircleGear = async ({
  toothCount,
}: CircleGearParams): Promise<ImageInfo> => {
  const imageSize = (toothCount + toothHeight) * 2;
  const innerRadius = toothCount;
  const outerRadius = innerRadius + toothHeight;
  const centerPoint = { x: imageSize / 2, y: imageSize / 2 };
  const radiansPerTooth = (2 * Math.PI) / toothCount;
  const radiansPerToothAngle = radiansPerTooth * (4 / 12);
  const radiansPerToothTop = radiansPerTooth * (2 / 12);
  const radiansPerToothValley = radiansPerToothTop;

  const svgPath: GearPath = new GearPath().moveTo({
    x: imageSize,
    y: centerPoint.y,
  });

  // Move counter-clockwise around the gear, generating each tooth
  for (let i = 0; i < toothCount; i++) {
    let currentAngle = i * radiansPerTooth;
    let newPosition: Point;

    // Left half of the top of the tooth
    currentAngle += radiansPerToothTop / 2;
    newPosition = getCirclePoint({
      center: centerPoint,
      radius: outerRadius,
      angle: currentAngle,
    });
    svgPath.arc(outerRadius, outerRadius, newPosition);

    // Angle down to the valley
    currentAngle += radiansPerToothAngle;
    newPosition = getCirclePoint({
      center: centerPoint,
      radius: innerRadius,
      angle: currentAngle,
    });
    svgPath.lineTo(newPosition);

    // Bottom of the valley
    currentAngle += radiansPerToothValley;
    newPosition = getCirclePoint({
      center: centerPoint,
      radius: innerRadius,
      angle: currentAngle,
    });
    svgPath.arc(innerRadius, innerRadius, newPosition);

    // Angle up to the next tooth
    currentAngle += radiansPerToothAngle;
    newPosition = getCirclePoint({
      center: centerPoint,
      radius: outerRadius,
      angle: currentAngle,
    });
    svgPath.lineTo(newPosition);

    // With half of the top of the next tooth
    currentAngle += radiansPerToothTop / 2;
    newPosition = getCirclePoint({
      center: centerPoint,
      radius: outerRadius,
      angle: currentAngle,
    });
    svgPath.arc(outerRadius, outerRadius, newPosition);
  }

  svgPath.closePath();

  const svg = new GearSvg({
    path: svgPath,
    width: imageSize,
    height: imageSize,
  });

  const imageInfo: ImageInfo = {
    svgPath: path.resolve(__dirname, '../tmp', `gear_${toothCount}.svg`),
    htmlPath: path.resolve(__dirname, '../tmp', `gear_${toothCount}.html`),
    pngPath: path.resolve(__dirname, '../tmp', `gear_${toothCount}.png`),
    width: imageSize * baseScale,
    height: imageSize * baseScale,
  };

  await writeFile(imageInfo.svgPath, svg.toString());
  await writeFile(
    imageInfo.htmlPath,
    hostSvgInHTml({ svgFilePath: imageInfo.svgPath, width: imageInfo.width }),
  );

  return imageInfo;
};
