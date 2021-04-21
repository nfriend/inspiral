import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import util from 'util';
import ejs from 'ejs';
import { polygonVariations } from '../constants';

const writeFile = util.promisify(fs.writeFile);
const renderFile: any = util.promisify(ejs.renderFile);

(async () => {
  const templateFilePath = path.resolve(
    __dirname,
    '../templates/svgs_for_analysis/polygon.svg.ejs',
  );
  const svgBasePath = path.resolve(__dirname, '../svg');

  for (const [i, polygonDef] of polygonVariations.entries()) {
    for (const [j, radius] of polygonDef.sizes.entries()) {
      const svgPath = path.resolve(
        svgBasePath,
        `${polygonDef.name}_${radius}.svg`,
      );

      console.info(
        chalk.blueBright(
          `Generating ${polygonDef.sides}-sided polygon SVG ${chalk.white(
            j + 1,
          )} of ${chalk.white(polygonDef.sizes.length)}: ${svgPath}`,
        ),
      );

      const arcs: {
        startPoint: { x: number; y: number };
        endPoint: { x: number; y: number };
        radius: number;
      }[] = [];
      const interval = (2 * Math.PI) / polygonDef.sides;
      const offset = radius;
      for (let k = 0; k < polygonDef.sides; k++) {
        arcs.push({
          startPoint: {
            x: Math.cos(interval * k) * radius + offset,
            y: -Math.sin(interval * k) * radius + offset,
          },
          endPoint: {
            x: Math.cos(interval * (k + 1)) * radius + offset,
            y: -Math.sin(interval * (k + 1)) * radius + offset,
          },
          radius: radius * 1.5,
        });
      }

      const templateParams = { arcs, entitlement: polygonDef.entitlement };

      const rendered = await renderFile(templateFilePath, {
        ...templateParams,
      });

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
