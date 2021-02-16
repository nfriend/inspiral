import path from 'path';
import puppeteer from 'puppeteer';
import chalk from 'chalk';
import { ImageInfo } from './models/image_info';
import { scalesToGenerate } from './constants';

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

    // Generate 1 screenshot per scaling factor,
    // and save the PNG in the appropriate directory
    // for use in the Flutter app.
    for (const scale of scalesToGenerate) {
      await page.setViewport({
        // 800x600 is the default width/height.
        // As far as I can tell, these dimensions
        // don't matter for our purposes.
        width: 800,
        height: 600,
        deviceScaleFactor: scale,
      });

      let pngPath = info.pngPath;
      if (scale != 1) {
        pngPath = pngPath.replace(
          'images',
          path.join('images', `${scale.toFixed(1)}x`),
        );
      }

      await svgElement.screenshot({
        path: pngPath,
        omitBackground: true,
      });
    }
  }

  await browser.close();

  console.info(
    chalk.greenBright(
      `Successfully rendered ${htmlFilesToRender.length} PNGs 👍`,
    ),
  );
};
