import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

Random rand = Random();

class InkTileCanvasPainter extends CustomPainter {
  final Offset _position;
  final Image _tileImage;
  final List<Offset> _points;
  final bool _showGridLines;

  InkTileCanvasPainter(
      {@required Offset position,
      @required Image tileImage,
      @required List<Offset> points,
      bool showGridLines = false})
      : _position = position,
        _tileImage = tileImage,
        _points = points,
        _showGridLines = showGridLines;

  @override
  void paint(Canvas canvas, Size size) {
    if (_tileImage != null) {
      // TEMP: draws a random color as the background of this tile
      // so that we can visualize how often the tile gets repainted
      Color tempColor = Color.fromARGB(
          128, rand.nextInt(256), rand.nextInt(256), rand.nextInt(256));
      canvas.drawRect(
          Offset.zero &
              Size(_tileImage.width.toDouble(), _tileImage.height.toDouble()),
          Paint()..color = tempColor);

      canvas.drawImageRect(
          _tileImage,
          Offset.zero &
              Size(_tileImage.width.toDouble(), _tileImage.height.toDouble()),
          Offset.zero & size,
          Paint());
    }

    final paint = Paint()
      ..color = Color(0x77FF0000)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    List<Offset> translatedPoints = _points.map((p) => p - _position).toList();

    canvas.drawPoints(PointMode.polygon, translatedPoints, paint);

    if (_showGridLines) {
      final gridPaint = Paint()
        ..color = Color(0xAA000000)
        ..style = PaintingStyle.stroke;
      canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(InkTileCanvasPainter oldDelegate) =>
      oldDelegate._tileImage != _tileImage;
}

class DryInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);
    final settings = Provider.of<SettingsState>(context);

    List<Positioned> tiles = ink.tileImages.entries.map((entry) {
      Offset position = entry.key;
      Image tileImage = entry.value;

      return Positioned(
          left: position.dx,
          top: position.dy,
          child: RepaintBoundary(
              child: CustomPaint(
                  size: tileSize,
                  painter: InkTileCanvasPainter(
                      position: position,
                      tileImage: tileImage,
                      points: [],
                      showGridLines: settings.debug))));
    }).toList();

    return Stack(children: tiles);
  }
}
