import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class DryInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);
    final bool debug =
        context.select<SettingsState, bool>((settings) => settings.debug);
    final TinyColor backgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.backgroundColor);

    List<Positioned> tiles = ink.tileImages.entries.map((entry) {
      Offset position = entry.key;
      Image tileImage = entry.value;

      return Positioned(
          left: position.dx,
          top: position.dy,
          child: RepaintBoundary(
              child: CustomPaint(
                  size: tileSize,
                  painter: DryInkTilePainter(
                      position: position,
                      tileImage: tileImage,
                      lines: [],
                      showGridLines: debug))));
    }).toList();

    return RepaintBoundary(
        key: canvasWithBackgroundGlobalKey,
        child: Container(
            color: backgroundColor.color,
            width: canvasSize.width,
            height: canvasSize.height,
            child: RepaintBoundary(
                key: canvasWithoutBackgroundGlobalKey,
                child: Stack(children: tiles))));
  }
}
