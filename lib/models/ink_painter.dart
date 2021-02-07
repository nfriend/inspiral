import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/models/models.dart';
import 'package:inspiral/extensions/extensions.dart';

abstract class BaseInkPainter extends CustomPainter {
  final List<InkLine> _lines;
  final Offset _position;

  BaseInkPainter({@required List<InkLine> lines, Offset position})
      : this._lines = lines,
        this._position = position;

  @override
  void paint(Canvas canvas, Size size) {
    for (InkLine line in _lines) {
      final paint = Paint()
        ..color = line.color
        ..strokeWidth = line.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round;

      Path translatedPath = line.path;

      // If `position` was passed in, translate the points to create the effect
      // that the canvas itself is positioned at `position`
      if (_position != null) {
        translatedPath = translatedPath.translate(-_position);
      }

      // canvas.drawPoints(PointMode.polygon, translatedPoints, paint);
      canvas.drawPath(translatedPath, paint);
    }
  }

  // This method should be implemented in subclasses
  @override
  bool shouldRepaint(BaseInkPainter oldDelegate) => false;
}

/// The "fresh ink" painter. This painter paints the current line being drawn.
class FreshInkPainter extends BaseInkPainter {
  FreshInkPainter({@required List<InkLine> lines}) : super(lines: lines);

  @override
  bool shouldRepaint(FreshInkPainter oldDelegate) =>
      listEquals(oldDelegate._lines, _lines);
}

/// The "dry ink" painter. This painter paints a single tile of ink that has
/// "dried", i.e. it included a rasterized version of previously-drawn lines
/// in addition to any newly drawn lines.
class DryInkTilePainter extends BaseInkPainter {
  final Image _tileImage;
  final bool _showGridLines;

  DryInkTilePainter(
      {@required List<InkLine> lines,
      @required Offset position,
      @required Image tileImage,
      bool showGridLines = false})
      : _tileImage = tileImage,
        _showGridLines = showGridLines,
        super(lines: lines, position: position);

  @override
  void paint(Canvas canvas, Size size) {
    if (_tileImage != null) {
      // TEMP: draws a random color as the background of this tile
      // so that we can visualize how often the tile gets repainted
      // Color tempColor = Color.fromARGB(
      //     128, rand.nextInt(256), rand.nextInt(256), rand.nextInt(256));
      // canvas.drawRect(
      //     Offset.zero &
      //         Size(_tileImage.width.toDouble(), _tileImage.height.toDouble()),
      //     Paint()..color = tempColor);

      canvas.drawImageRect(
          _tileImage,
          Offset.zero &
              Size(_tileImage.width.toDouble(), _tileImage.height.toDouble()),
          Offset.zero & size,
          Paint());
    }

    super.paint(canvas, size);

    if (_showGridLines) {
      final gridPaint = Paint()
        ..color = Color(0xAA000000)
        ..style = PaintingStyle.stroke;
      canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(DryInkTilePainter oldDelegate) =>
      oldDelegate._tileImage != _tileImage;
}
