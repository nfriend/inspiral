import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class DryInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);
    final settings = Provider.of<SettingsState>(context);
    final colors = Provider.of<ColorState>(context);

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
                      showGridLines: settings.debug))));
    }).toList();

    return RepaintBoundary(
        key: canvasWithBackgroundGlobalKey,
        child: Container(
            color: colors.backgroundColor.color,
            width: canvasSize.width,
            height: canvasSize.height,
            child: RepaintBoundary(
                key: canvasWithoutBackgroundGlobalKey,
                child: Stack(children: tiles))));
  }
}
