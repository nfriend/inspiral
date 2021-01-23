import path from 'path';
import fs from 'fs';
import chalk from 'chalk';
import globSync from 'glob';
import util from 'util';
import puppeteer from 'puppeteer';
import { ContactPoint } from './contact_point';
import { baseScale } from './constants';

const glob = util.promisify(globSync);
const readFile = util.promisify(fs.readFile);
const writeFile = util.promisify(fs.writeFile);

/**
 * Reads all SVG files in `gear_generator_2/src/svg`, breaks
 * its path down into a number of segments, and saves the
 * result in the `gears` directory.
 */
export const generatePointsFromSvgPaths = async () => {
  // Read all SVG files found in gear_generator_2/src/svg
  const svgFilePattern = path.resolve(__dirname, 'svg/**/*.svg');
  const files = await glob(svgFilePattern);

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

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

    const points = await page.evaluate(analyzePath, baseScale);

    // Write the points to a JSON file that matches the naming convention
    // of the original SVG file.
    const jsonFileName = path.basename(svgFile, path.extname(svgFile));
    const jsonFilePath = path.resolve(
      __dirname,
      '../../gears',
      `${jsonFileName}.json`,
    );
    await writeFile(jsonFilePath, JSON.stringify(points, null, 2));

    console.info(chalk.gray(`  └─ Wrote points to: ${jsonFilePath}`));
  }

  await browser.close();

  console.info(
    chalk.greenBright(`Successfully analyzed ${files.length} SVG files 👍`),
  );
};

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

/**
 * Finds the <path> element in the page, breaks it into chunks
 * of equal-sized length, and returns each line segment and
 * its direction (A.K.A. normal line).
 *
 * NOTE: This function is run in the context of an HTML
 * rendered inside a headless Chrome instance.
 */
const analyzePath = (baseScale: number): ContactPoint[] => {
  const pi2 = 2 * Math.PI;

  const svg = document.querySelector('svg');
  const svgSize = {
    width: parseInt(svg.getAttribute('width'), 10),
    height: parseInt(svg.getAttribute('height'), 10),
  };
  const centerPoint = {
    x: svgSize.width / 2,
    y: svgSize.height / 2,
  };
  const path = svg.querySelector('path');

  // The total length of the path
  const totalLength = path.getTotalLength();

  // The number of segments we will break this path into
  const segmentCount = Math.floor(totalLength / pi2);

  // How long each segment will be
  const segmentLength = totalLength / segmentCount;

  // Step around the path bit by bit, recording
  // the coordinates of each point as we go
  let evaluatedPoints: ContactPoint[] = [];
  for (let i = 0; i < segmentCount; i++) {
    const currentLength = i * segmentLength;

    const { x, y } = path.getPointAtLength(currentLength);

    evaluatedPoints.push({
      p: {
        x: (x - centerPoint.x) * baseScale,
        y: (y - centerPoint.y) * baseScale,
      },
      d: 0, // direction will be computed below
    });
  }

  // Compute the direction (A.K.A normal line) of each point
  // by computing the angle perpendicular to the line between
  // the previous and next points,
  evaluatedPoints = evaluatedPoints.map((point, index) => {
    // The previous point, or the last point if this is the first point
    const previousPoint =
      evaluatedPoints[
        (evaluatedPoints.length + index - 1) % evaluatedPoints.length
      ];

    // The next point, or the first point if this is the last point
    const nextPoint = evaluatedPoints[(index + 1) % evaluatedPoints.length];

    // Compute the angle between the two points
    let direction = Math.atan2(
      (nextPoint.p.y - previousPoint.p.y) * -1,
      nextPoint.p.x - previousPoint.p.x,
    );

    // Rotate the angle by a right angle so that it's perpendicular to the two points
    direction = direction - Math.PI / 2;

    // Adjust the angle so that it's in the range [0, 2+PI)
    direction = (direction + pi2) % pi2;

    return {
      ...point,
      d: direction,
    };
  });

  return evaluatedPoints;
};
