export interface ImageInfo {
  /**
   * The absolute path to the HTML file that hosts
   * the SVG file to be converted
   */
  htmlInputFilePath: string;

  /**
   * The absolute path to the rendered PNG file
   */
  pngOutputFilePath: string;
}
