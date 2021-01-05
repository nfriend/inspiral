import 'dart:io';
import 'image_info.dart';

// Update this path to point to the `inkscape` executable (if necessary)
const inkscapePath = '/Applications/Inkscape.app/Contents/MacOS/inkscape';

/// Checks to see if Inkscape is available and throws an error if not found
checkForInkscape() async {
  ProcessResult result = await Process.run('which', [inkscapePath]);

  if (result.exitCode != 0) {
    throw ("""
           The Inkscape command line executable was not found at $inkscapePath.
           Please make sure Inkscape is installed and is available at the path
           provided in `gear_generator/inkscape.dart`.
           """);
  }
}

/// Converts the provided SVG file to PNG using Inkscape.
convertSvgToPng(ImageInfo imageInfo) async {
  ProcessResult result = await Process.run(inkscapePath, [
    '--export-width',
    imageInfo.outputWidth.toString(),
    '--export-height',
    imageInfo.outputHeight.toString(),
    imageInfo.svgInputFilePath,
    '--export-filename',
    imageInfo.pngOutputFilePath
  ]);

  if (result.exitCode != 0) {
    throw ("Error while converting ${imageInfo.svgInputFilePath}: ${result.stderr}");
  }
}
