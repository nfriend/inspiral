import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { ovalGearSizes } from '../constants';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/oval.svg.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, ovalParams] of ovalGearSizes.entries()) {
    const svgPath = path.resolve(svgBasePath, `oval_${ovalParams.xRadius}.svg`);

    console.info(
      chalk.blueBright(
        `Generating oval SVG ${chalk.white(i + 1)} of ${chalk.white(
          ovalGearSizes.length,
        )}: ${svgPath}`,
      ),
    );

    const rendered = await renderFile(templateFilePath, { ...ovalParams });

    await writeFile(svgPath, rendered);

    console.info(chalk.gray(`  └─ Wrote SVG to: ${svgPath}`));
  }

  console.info(
    chalk.greenBright(
      `Successfully wrote ${ovalGearSizes.length} SVG files 👍`,
    ),
  );
})().catch((e) => {
  console.error(
    chalk.redBright('⚠️  Something went wrong while generating oval SVGs!'),
  );
  console.error(e);
  process.exit(1);
});
