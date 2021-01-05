#!/usr/bin/env dart

import 'package:ansicolor/ansicolor.dart';
import 'generate_circle.dart';
import 'image_info.dart';
import 'inkscape.dart';

void main() async {
  await checkForInkscape();

  AnsiPen grayPen = AnsiPen()..gray(level: .5);
  AnsiPen bluePen = AnsiPen()..blue();
  AnsiPen greenPen = AnsiPen()..green();

  const gearSizes = [
    24,
    30,
    32,
    40,
    42,
    45,
    48,
    52,
    56,
    60,
    63,
    72,
    75,
    80,
    84
  ];

  // The list of all SVG files that need to be converted to PNG
  List<ImageInfo> images = [];

  for (int toothCount in gearSizes) {
    print(bluePen("Generating SVG for circle gear with $toothCount teeth..."));
    images.add(await generateCircle(toothCount: toothCount));
  }

  for (int i = 0; i < images.length; i++) {
    print(bluePen("Converting SVG ${i + 1} of ${images.length} to PNG..."));
    print(grayPen(images[i]));
    await convertSvgToPng(images[i]);
  }

  print(
      greenPen("Successfully generated ${images.length} SVG and PNG images ✨"));
}
