export interface HostSvgInHtmlParams {
  /** The absolute file path to the SVG file */
  svgFilePath: string;

  /** The SVG img element's `width` attribute */
  width: number;
}

/**
 * Returns an HTML document with the provided SVG embeded
 *
 * @returns The HTML document as a string
 */
export const hostSvgInHTml = ({
  svgFilePath,
  width,
}: HostSvgInHtmlParams): string => {
  return `<!DOCTYPE html>
  <html>
    <body>
      <img
        id="gear"
        width="${width}"
        src="file://${svgFilePath}"
      />
    </body>
  </html>`;
};
