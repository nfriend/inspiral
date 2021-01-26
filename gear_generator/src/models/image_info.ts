export interface ImageInfo {
  /**
   * The absolute path to the generated SVG file
   */
  svgPath: string;

  /**
   * The absolute path to the HTML file that hosts
   * the SVG file to be converted
   */
  htmlPath: string;

  /**
   * The absolute path to the rendered PNG file
   */
  pngPath: string;

  /**
   * The width of the image
   */
  width: number;

  /**
   * The height of the image
   */
  height: number;
}
