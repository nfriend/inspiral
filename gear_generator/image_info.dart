import 'package:meta/meta.dart';

@immutable
class ImageInfo {
  ImageInfo(
      {this.outputWidth,
      this.outputHeight,
      this.svgInputFilePath,
      this.pngOutputFilePath});

  /// The width of the generated PNG file, in pixels
  final int outputWidth;

  /// The height of the generated PNG file, in pixels
  final int outputHeight;

  /// The absolute file path to the input SVG file
  final String svgInputFilePath;

  /// The absolut file path to the generated PNG file
  final String pngOutputFilePath;

  @override
  String toString() {
    return """ImageInfo(
  outputWidth: $outputWidth,
  outputHeight: $outputHeight,
  svgInputFilePath: $svgInputFilePath,
  pngOutputFilePath: $pngOutputFilePath
)""";
  }
}
