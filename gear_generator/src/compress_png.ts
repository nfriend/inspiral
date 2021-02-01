import fs from 'fs';
import path from 'path';
import chalk from 'chalk';
import globSync from 'glob';
import util from 'util';
import { exec as execSync } from 'child_process';

const glob = util.promisify(globSync);
const stat = util.promisify(fs.stat);
const exec = util.promisify(execSync);

(async () => {
  if (!(await isPngquantInPath())) {
    throw new Error(
      'The pngquant binary was not found in PATH! Please download it from here: https://pngquant.org/ and make sure it is available at the command line.',
    );
  }

  // Read all SVG files found in gear_generator/src/svg
  const pngFilePattern = path.resolve(__dirname, '../../images/**/*.png');
  const files = await glob(pngFilePattern);

  let totalSavings = 0;

  for (const [i, pngFile] of files.entries()) {
    console.info(
      chalk.blueBright(
        `Compressing PNG file ${chalk.white(i + 1)} of ${chalk.white(
          files.length,
        )}: ${pngFile}`,
      ),
    );

    const originalSize = await getFileSize(pngFile);

    await exec(`pngquant --strip --ext=.png --force ${pngFile}`);

    const newSize = await getFileSize(pngFile);
    const savings = originalSize - newSize;
    totalSavings += savings;

    console.info(
      chalk.gray(
        `  └─ PNG compressed from ${originalSize} KB to ${newSize} KB: ${savings} KB saved`,
      ),
    );
  }

  const totalSavingsInMB = (totalSavings / 1024).toFixed(2);

  console.info(
    chalk.greenBright(
      `Successfully compressed ${files.length} PNG files: a total of ${totalSavingsInMB} MB saved 👍`,
    ),
  );
})().catch((e) => {
  console.error(
    chalk.redBright(
      '⚠️  Something went wrong while compressing PNGs using pngquant!',
    ),
  );
  console.error(e);
  process.exit(1);
});

/** Returns the size of the provided file in kilobytes */
async function getFileSize(filePath: string): Promise<number> {
  const stats = await stat(filePath);
  return Math.round(stats.size / 1024);
}

/**
 * Returns a boolean that indicates whether the `pngquant`
 * binary was found in the current PATH
 */
async function isPngquantInPath(): Promise<boolean> {
  try {
    await exec('command -v pngquant');
  } catch (e) {
    return false;
  }

  return true;
}
