import path from 'path';
import fs from 'fs';
import chalk from 'chalk';
import globSync from 'glob';
import util from 'util';
import puppeteer from 'puppeteer';
import camelcase from 'camelcase';
import { baseScale, toothHeight, meshSpacing } from './constants';
import { analyzePath, AnalyzePathParams } from './analyze_path';
import { GearDefinition } from './models/gear_definition';
import { generateSvgs } from './generate_svg';
import { ImageInfo } from './models/image_info';
import { renderHtmlToPng } from './render';
import { writeGearDefinitionAsDartFile } from './util/write_gear_definition_as_dart_file';
import { writeDartProxyExportFile } from './util/write_dart_proxy_export_file';
import { allProducts } from './models/product';

const glob = util.promisify(globSync);
const readFile = util.promisify(fs.readFile);

(async () => {
  // Read all SVG files found in gear_generator/src/svg
  const svgFilePattern = path.resolve(__dirname, 'svg/**/*.svg');
  const files = await glob(svgFilePattern);

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  // Redirect any log output in the headless browser into this process
  page.on('console', (message) =>
    console.log(
      `${message.type().substr(0, 3).toUpperCase()} ${message.text()}`,
    ),
  );

  // Lists of all HTML/SVG files to render to PNG
  const allImageInfos: ImageInfo[] = [];
  const allGearDefinitions: GearDefinition[] = [];

  for (const [i, svgFile] of files.entries()) {
    console.info(
      chalk.blueBright(
        `Analyzing SVG file ${chalk.white(i + 1)} of ${chalk.white(
          files.length,
        )}: ${svgFile}`,
      ),
    );

    const svgString = await readFile(svgFile, 'utf8');

    await page.setContent(getHtmlPageWithInlineSvg({ svgString }));

    // The gear name is the name of the SVG file (with the extension)
    const gearName = path.basename(svgFile, path.extname(svgFile));

    const analyzePathParams: AnalyzePathParams = {
      baseScale,
      toothHeight,
      meshSpacing,
      gearName,
      camelCasedGearName: camelcase(gearName),
      allProducts: allProducts,
      freeProductIdString: allProducts.free.id,
    };

    const gearDefinition: GearDefinition = await page.evaluate(
      analyzePath,
      analyzePathParams as any,
    );

    // Write the points to a JSON file that matches the naming convention
    // of the original SVG file.
    const dartFilePath = path.resolve(
      __dirname,
      '../../lib/models/gears',
      `${gearName}.dart`,
    );

    await writeGearDefinitionAsDartFile(gearDefinition, dartFilePath),
      console.info(
        chalk.gray(`  ├─ Wrote gear definition to: ${dartFilePath}`),
      );

    const imageInfos = await generateSvgs(gearDefinition);

    allImageInfos.push(...imageInfos);
    allGearDefinitions.push(gearDefinition);

    console.info(
      chalk.gray(
        `  └─ Wrote rendered SVGs to: ${imageInfos
          .map((ii) => ii.svgPath)
          .join(', ')}`,
      ),
    );
  }

  await browser.close();

  console.info(chalk.blueBright('Writing proxy export file'));

  const proxyFilePath = path.resolve(
    __dirname,
    '../../lib/models/gears/gears.dart',
  );

  await writeDartProxyExportFile(allGearDefinitions, proxyFilePath);

  console.info(chalk.gray(`  └─ Wrote proxy export file to: ${proxyFilePath}`));

  console.info(
    chalk.greenBright(`Successfully analyzed ${files.length} SVG files 👍`),
  );

  await renderHtmlToPng(allImageInfos);
})().catch((e) => {
  console.error(chalk.redBright('⚠️  Something went wrong!'));
  console.error(e);
  process.exit(1);
});

/**
 * Embeds the provided SVG in a basic HTML page,
 * and returns the result as a string
 */
const getHtmlPageWithInlineSvg = ({
  svgString,
}: {
  svgString: string;
}): string => {
  return `<!DOCTYPE html>
  <html>
    <body>
      ${svgString}
    </body>
  </html>`;
};
