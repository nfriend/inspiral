import 'dart:io';
import 'dart:math';
import 'package:meta/meta.dart';
import 'constants.dart';
import 'gear_path.dart';
import 'gear_svg.dart';
import 'image_info.dart';
import 'package:path/path.dart' as path;
import './extensions/extensions.dart';

/// Generates an SVG image of a gear with the provided number of teeth,
/// saves the result to disk, and returns info about the image file
Future<ImageInfo> generateCircle({@required int toothCount}) async {
  final int imageSize = (toothCount + toothHeight) * 2;
  final double innerRadius = toothCount * 1.0;
  final double outerRadius = innerRadius + toothHeight;
  final Point centerPoint = Point(imageSize, imageSize) / 2;
  final double radiansPerTooth = (2 * pi) / toothCount;
  final double radiansPerToothAngle = radiansPerTooth * (4 / 12);
  final double radiansPerToothTop = radiansPerTooth * (2 / 12);
  final double radiansPerToothValley = radiansPerToothTop;

  final GearPath svgPath = GearPath().moveTo(Point(imageSize, centerPoint.y));

  // Move counter-clockwise around the gear, generating each tooth
  for (int i = 0; i < toothCount; i++) {
    double currentAngle = i * radiansPerTooth;
    Point newPosition;

    // Left half of the top of the tooth
    currentAngle += radiansPerToothTop / 2;
    newPosition = getCirclePoint(
        center: centerPoint, radius: outerRadius, angle: currentAngle);
    svgPath.arc(outerRadius, outerRadius, newPosition);

    // Angle down to the valley
    currentAngle += radiansPerToothAngle;
    newPosition = getCirclePoint(
        center: centerPoint, radius: innerRadius, angle: currentAngle);
    svgPath.lineTo(newPosition);

    // Bottom of the valley
    currentAngle += radiansPerToothValley;
    newPosition = getCirclePoint(
        center: centerPoint, radius: innerRadius, angle: currentAngle);
    svgPath.arc(innerRadius, innerRadius, newPosition);

    // Angle up to the next tooth
    currentAngle += radiansPerToothAngle;
    newPosition = getCirclePoint(
        center: centerPoint, radius: outerRadius, angle: currentAngle);
    svgPath.lineTo(newPosition);

    // With half of the top of the next tooth
    currentAngle += radiansPerToothTop / 2;
    newPosition = getCirclePoint(
        center: centerPoint, radius: outerRadius, angle: currentAngle);
    svgPath.arc(outerRadius, outerRadius, newPosition);
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

/// Gets a point on a circle at a specific angle
Point getCirclePoint(
    {@required Point center, @required double radius, @required double angle}) {
  return Point(
      radius * cos(angle) + center.x, -1 * radius * sin(angle) + center.y);
}
