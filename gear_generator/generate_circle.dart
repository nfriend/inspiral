import 'dart:io';
import 'dart:math';

import 'package:meta/meta.dart';
import 'gear_path.dart';
import 'gear_svg.dart';
import 'image_info.dart';
import 'package:path/path.dart' as path;

/// Generates an SVG image of a gear with the provided number of teeth,
/// saves the result to disk, and returns info about the image file
Future<ImageInfo> generateCircle({@required int toothCount}) async {
  final int imageSize = toothCount * 4;

  final GearPath svgPath = GearPath();

  // TODO: temp
  svgPath.moveTo(Point(0, 0)).lineTo(Point(7, 8)).arc(2, 3, Point(4, 5));

  for (int i = 0; i < toothCount; i++) {
    // TODO: Generate gear here
  }

  svgPath.closePath();

  final GearSvg svg =
      GearSvg(path: svgPath, width: imageSize, height: imageSize);

  final String svgFilePath = path.join(
      path.dirname(Platform.script.path), "tmp", "gear_$toothCount.svg");
  final File svgFile = File(svgFilePath);

  await svgFile.create(recursive: true);
  await svgFile.writeAsString(svg.toString(), mode: FileMode.write);

  return ImageInfo(
      outputHeight: imageSize,
      outputWidth: imageSize,
      svgInputFilePath: svgFilePath,
      pngOutputFilePath: svgFilePath.replaceAll(RegExp(r"\.svg$"), ".png"));
}
