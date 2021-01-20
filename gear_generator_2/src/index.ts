import puppeteer from 'puppeteer';
import path from 'path';
import chalk from 'chalk';
import { ImageInfo } from './image_info';
import { circleGearSizes } from './constants';
import { generateCircleGear } from './generate_circle_gear';

(async () => {
  const htmlFilesToRender: ImageInfo[] = [];

  for (const size of circleGearSizes) {
    htmlFilesToRender.push(await generateCircleGear({ toothCount: size }));
  }

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  for (const [i, info] of htmlFilesToRender.entries()) {
    console.info(
      chalk.blueBright(
        `Rendering ${chalk.white(i + 1)} of ${chalk.white(
          htmlFilesToRender.length,
        )}: ${info.pngPath}`,
      ),
    );

    await page.goto(`file://${info.htmlPath}`);

    const svgElement = await page.$('#gear');

    await svgElement.screenshot({
      path: info.pngPath,
      omitBackground: true,
    });
  }

  await browser.close();

  console.info(
    chalk.greenBright(
      `Successfully rendered ${htmlFilesToRender.length} images 👍`,
    ),
  );
})().catch((e) => {
  console.error(
    chalk.redBright('⚠️  Something went wrong while generating PNGs!'),
  );
  console.error(e);
});
