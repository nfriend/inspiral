import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { beamSizes, gearOrder, holeSize, toothHeight } from '../constants';
import { getHoles } from './get_holes';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/beam.svg.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, beamOptions] of beamSizes.entries()) {
    const fileNameSegments = [
      'beam',
      beamOptions.endCapRadius,
      beamOptions.length,
      ...(beamOptions.isRing ? ['ring'] : []),
      ...(beamOptions.suffix ? [beamOptions.suffix] : []),
    ];

    const svgPath = path.resolve(
      svgBasePath,
      `${fileNameSegments.join('_')}.svg`,
    );

    console.info(
      chalk.blueBright(
        `Generating beam SVG ${chalk.white(i + 1)} of ${chalk.white(
          beamOptions.length,
        )}: ${svgPath}`,
      ),
    );

    const centerPoint = {
      x: beamOptions.length + beamOptions.endCapRadius,
      y: beamOptions.endCapRadius,
    };

    const templateParams = {
      ...beamOptions,
      gearOrder: gearOrder.beams + i,
      centerPoint,
      holes: getHoles(centerPoint, beamOptions.holes),
      holeSize,
      isRing: Boolean(beamOptions.isRing),
      toothHeight,
    };

    const rendered = await renderFile(templateFilePath, templateParams);

    await writeFile(svgPath, rendered);

    console.info(chalk.gray(`  └─ Wrote SVG to: ${svgPath}`));
  }
})().catch((e) => {
  console.error(
    chalk.redBright('⚠️  Something went wrong while generating beam SVGs!'),
  );
  console.error(e);
  process.exit(1);
});
