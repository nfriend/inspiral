import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class InkCanvasPainter extends CustomPainter {
  final List<Path> _paths;

  InkCanvasPainter({@required List<Path> paths}) : this._paths = paths;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0x77FF0000)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    for (Path path in _paths) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(InkCanvasPainter oldDelegate) => false;
}

class InkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);

    return CustomPaint(
        size: canvasSize, painter: InkCanvasPainter(paths: ink.paths));
  }
}
