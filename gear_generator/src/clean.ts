import fs from 'fs';
import util from 'util';
import chalk from 'chalk';
import globSync from 'glob';

const glob = util.promisify(globSync);
const deleteFile = util.promisify(fs.unlink);

(async () => {
  // A list of all auto-generated files created
  // by the gear generation process
  const patternsToDelete = [
    'src/svg/circle_*.svg',
    'src/svg/oval_*.svg',
    'src/svg/triangle_*.svg',
    'src/svg/square_*.svg',
    'src/svg/pentagon_*.svg',
    'tmp/**/!(.gitkeep)',
    '../lib/models/gears/!(README.md)',
    '../images/gears/!(README.md)',
  ];

  let deleteCount = 0;
  for (const pattern of patternsToDelete) {
    console.info(chalk.blueBright(`Deleting files in "${pattern}"`));

    const files = await glob(pattern, { nodir: true });

    if (files.length === 0) {
      console.warn(
        chalk.yellow(`⚠️  Warning: pattern "${pattern}" matched 0 files`),
      );
    }

    for (const file of files) {
      await deleteFile(file);
      deleteCount++;
    }
  }

  console.info(
    chalk.greenBright(`Successfully deleted ${deleteCount} files 👍`),
  );
})().catch((e) => {
  console.error(chalk.redBright('⚠️  Something went wrong while cleaning!'));
  console.error(e);
  process.exit(1);
});
