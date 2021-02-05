import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class _FreshInkCanvasPainter extends CustomPainter {
  final List<Offset> _points;

  _FreshInkCanvasPainter({@required List<Offset> points})
      : this._points = points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0x77FF0000)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPoints(PointMode.polygon, _points, paint);
  }

  @override
  bool shouldRepaint(_FreshInkCanvasPainter oldDelegate) => false;
}

class FreshInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);

    return CustomPaint(
        size: canvasSize, painter: _FreshInkCanvasPainter(points: ink.points));
  }
}
