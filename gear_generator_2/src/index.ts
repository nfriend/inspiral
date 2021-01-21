import chalk from 'chalk';
import { generatePointsFromSvgPaths } from './generate';

(async () => {
  await generatePointsFromSvgPaths();
})().catch((e) => {
  console.error(
    chalk.redBright('⚠️  Something went wrong while generating gears!'),
  );
  console.error(e);
  process.exit(1);
});
