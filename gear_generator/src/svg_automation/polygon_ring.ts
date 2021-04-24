import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { polygonRingVariations, holeSize } from '../constants';
import { Point } from '../models/point';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/polygon_ring.svg.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, polygonDef] of polygonRingVariations.entries()) {
    for (const [j, size] of polygonDef.sizes.entries()) {
      const fileNameSegments = [
        polygonDef.name,
        'ring',
        size.radius,
        ...(size.suffix ? [size.suffix] : []),
      ];

      const svgPath = path.resolve(
        svgBasePath,
        `${fileNameSegments.join('_')}.svg`,
      );

      console.info(
        chalk.blueBright(
          `Generating ${polygonDef.sides}-sided polygon ring SVG ${chalk.white(
            j + 1,
          )} of ${chalk.white(polygonDef.sizes.length)}: ${svgPath}`,
        ),
      );

      const endCapRadius = size.radius;
      const sideRadius = size.radius * 5;
      const centerPoint: Point = { x: size.radius * 2, y: size.radius * 2 };
      const interval = (2 * Math.PI) / polygonDef.sides;
      const caps: {
        startPoint: Point;
        endPoint: Point;
      }[] = [];
      for (let sideCount = 0; sideCount < polygonDef.sides; sideCount++) {
        const capAngle = interval * sideCount;
        const capCenter: Point = {
          x: Math.cos(capAngle) * size.radius + centerPoint.x,
          y: -Math.sin(capAngle) * size.radius + centerPoint.y,
        };

        // An arbitrary angle to make the sides connect with the end caps.
        // This isn't mathematically precise, but it's close enough
        // for our purposes.
        const endCapSpread = (2 * Math.PI) / (7 * (1 + polygonDef.sides * 0.1));

        caps.push({
          startPoint: {
            x: Math.cos(capAngle - endCapSpread) * endCapRadius + capCenter.x,
            y: -Math.sin(capAngle - endCapSpread) * endCapRadius + capCenter.y,
          },
          endPoint: {
            x: Math.cos(capAngle + endCapSpread) * endCapRadius + capCenter.x,
            y: -Math.sin(capAngle + endCapSpread) * endCapRadius + capCenter.y,
          },
        });
      }

      const templateParams = {
        caps,
        endPointRadius: endCapRadius,
        sideRadius,
        entitlement: polygonDef.entitlement,
        gearOrder: polygonDef.startingOrder + j,
        centerPoint,
        isRing: true,
        holes: size.holes,
        holeSize,
      };

      const rendered = await renderFile(templateFilePath, templateParams);

      await writeFile(svgPath, rendered);

      console.info(chalk.gray(`  └─ Wrote SVG to: ${svgPath}`));
    }
  }

  const polygonCount = polygonRingVariations.reduce<number>(
    (acc, curr) => acc + curr.sizes.length,
    0,
  );
  console.info(
    chalk.greenBright(`Successfully wrote ${polygonCount} SVG files 👍`),
  );
})().catch((e) => {
  console.error(
    chalk.redBright(
      '⚠️  Something went wrong while generating polygon ring SVGs!',
    ),
  );
  console.error(e);
  process.exit(1);
});
