import puppeteer from 'puppeteer';
import chalk from 'chalk';
import { ImageInfo } from './image_info';
import { circleGearSizes } from './constants';
import { generateCircleGear } from './generate_circle_gear';

/**
 * Renders SVG images (hosted inside HTML pages) to PNGs
 *
 * @param htmlFilesToRender The list of `ImageInfo` files to render to PNG
 */
export const renderHtmlToPng = async (
  htmlFilesToRender: ImageInfo[],
): Promise<void> => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  for (const [i, info] of htmlFilesToRender.entries()) {
    console.info(
      chalk.blueBright(
        `Rendering PNG ${chalk.white(i + 1)} of ${chalk.white(
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
      `Successfully rendered ${htmlFilesToRender.length} PNGs 👍`,
    ),
  );
};
