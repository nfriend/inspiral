import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { circleGearSizes, holeSize, gearOrder } from '../constants';
import { PointGearHole } from '../models/gear_hole';
import { getHoles } from './get_holes';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/circle.svg.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, size] of circleGearSizes.entries()) {
    const fileNameSegments = [
      'circle',
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
        `Generating circle SVG ${chalk.white(i + 1)} of ${chalk.white(
          circleGearSizes.length,
        )}: ${svgPath}`,
      ),
    );

    const holes: PointGearHole[] = getHoles(
      { x: size.radius, y: size.radius },
      size.holes,
      {
        toothCount: size.radius,
      },
    );

    const rendered = await renderFile(templateFilePath, {
      radius: size.radius,
      holeSize,
      holes,
      isRing: Boolean(size.isRing),
      gearOrder: gearOrder.circles + i,
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
