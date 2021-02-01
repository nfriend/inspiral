import path from 'path';
import chalk from 'chalk';
import util from 'util';
import { exec as execSync } from 'child_process';

const exec = util.promisify(execSync);

(async () => {
  if (!(await isDartfmtInPath())) {
    throw new Error(
      'The dartfmt binary was not found in PATH! (Note: it is likely located inside ~/flutter/bin/cache/dart-sdk/bin/).',
    );
  }

  console.info(
    chalk.blueBright(
      'Formatting all auto-generated *.dart files using dartfmt',
    ),
  );

  const gearsDir = path.resolve(__dirname, '../../lib/models/gears');
  await exec(`dartfmt --overwrite --fix ${gearsDir}`);

  console.info(
    chalk.greenBright(
      `Successfully auto-generated all auto-generated *.dart files 👍`,
    ),
  );
})().catch((e) => {
  console.error(
    chalk.redBright(
      '⚠️  Something went wrong while formatting all auto-generated *.dart files using dartfmt!',
    ),
  );
  console.error(e);
  process.exit(1);
});

/**
 * Returns a boolean that indicates whether the `dartfmt`
 * binary was found in the current PATH
 */
async function isDartfmtInPath(): Promise<boolean> {
  try {
    await exec('command -v dartfmt');
  } catch (e) {
    return false;
  }

  return true;
}
