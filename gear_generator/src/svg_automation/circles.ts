import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { circleGearSizes, holeSize } from '../constants';
import { GearHole } from '../models/gear_hole';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/circle.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, radius] of circleGearSizes.entries()) {
    const svgPath = path.resolve(svgBasePath, `circle_${radius}.svg`);

    console.info(
      chalk.blueBright(
        `Generating circle SVG ${chalk.white(i + 1)} of ${chalk.white(
          circleGearSizes.length,
        )}: ${svgPath}`,
      ),
    );

    const holes: GearHole[] = [];

    // Create 6 straight lines of holes from the center of the gear to the edge
    const holeSpacing = 4;
    const holeAndSpacing = holeSize + holeSpacing;
    const maximumDistance = radius - holeAndSpacing;
    for (let lineIndex = 0; lineIndex < 6; lineIndex++) {
      for (
        let distance = lineIndex === 0 ? 0 : lineIndex + holeAndSpacing;
        distance <= maximumDistance;
        distance += holeAndSpacing
      ) {
        holes.push(
          getHole({
            angle: Math.PI * (1 / 2) + Math.PI * (1 / 3) * lineIndex,
            distanceFromCenter: distance,
            gearRadius: radius,
          }),
        );
      }
    }

    const rendered = await renderFile(templateFilePath, {
      radius,
      holeSize,
      holes,
    });

    await writeFile(svgPath, rendered);

    console.info(chalk.gray(`  └─ Wrote SVG to: ${svgPath}`));
  }

  console.info(
    chalk.greenBright(
      `Successfully wrote ${circleGearSizes.length} SVG files 👍`,
    ),
  );
})().catch((e) => {
  console.error(
    chalk.redBright('⚠️  Something went wrong while generating circle SVGs!'),
  );
  console.error(e);
  process.exit(1);
});

/** Returns a `GearHole` object based on the provided parameters */
function getHole({
  angle,
  distanceFromCenter,
  gearRadius,
}: {
  angle: number;
  distanceFromCenter: number;
  gearRadius: number;
}): GearHole {
  return {
    name: distanceFromCenter.toString(),
    point: {
      x: gearRadius + Math.cos(angle) * distanceFromCenter,
      y: gearRadius + -1 * Math.sin(angle) * distanceFromCenter,
    },
  };
}
