import 'package:flutter/material.dart' hide Image;
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class FreshInkCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context);

    return RepaintBoundary(
        child: ClipRect(
            child: CustomPaint(
                size: canvasSize, painter: FreshInkPainter(lines: ink.lines))));
  }
}
