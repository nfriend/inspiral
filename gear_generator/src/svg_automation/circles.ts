import fs, { write } from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { circleGearSizes } from '../constants';

const writeFile = util.promisify(fs.writeFile);

const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(__dirname, '../templates/circle.ejs');
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

    const rendered = await renderFile(templateFilePath, { radius });

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
