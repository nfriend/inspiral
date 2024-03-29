import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { polygonVariations, holeSize } from '../constants';
import { PointGearHole } from '../models/gear_hole';
import { getHoles } from './get_holes';
import { Point } from '../models/point';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/polygon.svg.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, polygonDef] of polygonVariations.entries()) {
    for (const [j, size] of polygonDef.sizes.entries()) {
      const fileNameSegments = [
        polygonDef.name,
        size.radius,
        ...(size.isRing ? ['ring'] : []),
        ...(size.suffix ? [size.suffix] : []),
      ];

      const svgPath = path.resolve(
        svgBasePath,
        `${fileNameSegments.join('_')}.svg`,
      );

      console.info(
        chalk.blueBright(
          `Generating ${polygonDef.sides}-sided polygon SVG ${chalk.white(
            j + 1,
          )} of ${chalk.white(polygonDef.sizes.length)}: ${svgPath}`,
        ),
      );

      const arcs: {
        startPoint: Point;
        endPoint: Point;
        radius: number;
      }[] = [];
      const interval = (2 * Math.PI) / polygonDef.sides;
      const centerPoint = { x: size.radius, y: size.radius };
      for (let k = 0; k < polygonDef.sides; k++) {
        arcs.push({
          startPoint: {
            x: Math.cos(interval * k) * size.radius + centerPoint.x,
            y: -Math.sin(interval * k) * size.radius + centerPoint.y,
          },
          endPoint: {
            x: Math.cos(interval * (k + 1)) * size.radius + centerPoint.x,
            y: -Math.sin(interval * (k + 1)) * size.radius + centerPoint.y,
          },
          radius: size.radius * 1.5,
        });
      }

      const holes: PointGearHole[] = getHoles(centerPoint, size.holes);

      const templateParams = {
        arcs,
        entitlement: polygonDef.entitlement,
        gearOrder: polygonDef.startingOrder + j,
        holeSize,
        holes,
        centerPoint,
        isRing: Boolean(size.isRing),
      };

      const rendered = await renderFile(templateFilePath, templateParams);

      await writeFile(svgPath, rendered);

      console.info(chalk.gray(`  └─ Wrote SVG to: ${svgPath}`));
    }
  }

  const polygonCount = polygonVariations.reduce<number>(
    (acc, curr) => acc + curr.sizes.length,
    0,
  );
  console.info(
    chalk.greenBright(`Successfully wrote ${polygonCount} SVG files 👍`),
  );
})().catch((e) => {
  console.error(
    chalk.redBright('⚠️  Something went wrong while generating polygon SVGs!'),
  );
  console.error(e);
  process.exit(1);
});
