import path from 'path';
import browserify from 'browserify';
import util from 'util';
import puppeteer from 'puppeteer';

/**
 * Bundles third-party dependencies from npm into a browser-
 * friendly format and adds them to Puppeteer's execution
 * context. This allow third-party libraries to be used
 * in `analyze_path.ts`.
 *
 * @param page The current Puppeteer page
 */
export const addThirdPartyLibs = async (page: puppeteer.Page) => {
  const b = browserify();
  b.add(require.resolve('parse-svg-path'));

  // This file manually adds any dependencies that should be global
  // to the `window` object, so that `analyze_path.ts` can
  // use them without any imports/requires.
  b.add(path.resolve(__dirname, 'add-browserify-globals.js'));

  const bundle = util.promisify(b.bundle.bind(b));
  const supportingJsLibs = (await bundle()).toString();
  await page.evaluate(supportingJsLibs);
};
