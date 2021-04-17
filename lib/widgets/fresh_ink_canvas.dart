import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class FreshInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);
    final canvasSize =
        context.select<CanvasState, Size>((canvas) => canvas.canvasSize);

    return RepaintBoundary(
        child: ClipRect(
            child: CustomPaint(
                size: canvasSize, painter: FreshInkPainter(lines: ink.lines))));
  }
}
