import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/ink_line.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class _FreshInkCanvasPainter extends CustomPainter {
  final List<InkLine> _lines;

  _FreshInkCanvasPainter({@required List<InkLine> lines}) : this._lines = lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (InkLine line in _lines) {
      final paint = Paint()
        ..color = line.color
        ..strokeWidth = line.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round;

      canvas.drawPoints(PointMode.polygon, line.points, paint);
    }
  }

  @override
  bool shouldRepaint(_FreshInkCanvasPainter oldDelegate) =>
      listEquals(oldDelegate._lines, _lines);
}

class FreshInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);

    return RepaintBoundary(
        child: CustomPaint(
            size: canvasSize,
            painter: _FreshInkCanvasPainter(lines: ink.lines)));
  }
}
