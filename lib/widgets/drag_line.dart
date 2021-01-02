import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:inspiral/extensions/extensions.dart';

/// A debugging aid that draws a line between the rotation
/// point (usually the center of the fixed gear) and the pointer
class _DragLinePainter extends CustomPainter {
  _DragLinePainter({@required this.rotatingGearPoint});

  /// The offset to the center of the rotating gear, relative to the fixed
  /// gear's center (which is located at the center of the canvas)
  Offset rotatingGearPoint;

  @override
  void paint(Canvas canvas, Size size) {
    // final rectPaint = Paint()
    //   ..color = Color(0X33E9EB75)
    //   ..style = PaintingStyle.fill;
    // canvas.drawRect(Offset.zero & size, rectPaint);

    final circlePaint = Paint()
      ..color = Color(0XCCE9EB75)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(rotatingGearPoint, 8, circlePaint);

    final linePaint = Paint()
      ..color = Color(0x88262626)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(size.toOffset() / 2, rotatingGearPoint, linePaint);
  }

  @override
  bool shouldRepaint(_DragLinePainter oldDelegate) => false;
}

class DragLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // We don't actually use any values from this provider, but we need
    // to rely on it so that this widget is rebuild when rotatingGear.isDragging
    // is updated. We should revisit this when we've discovered a way to
    // propogate changes between dependent providers.
    Provider.of<PointersProvider>(context);

    final rotatingGear =
        Provider.of<RotatingGearProvider>(context, listen: false);

    // Only render if the rotating gear is being dragged
    if (!rotatingGear.isDragging) return Container(width: 0.0, height: 0.0);

    final dragLine = Provider.of<DragLineProvider>(context);

    Offset positionDelta = dragLine.pointerPosition - dragLine.pivotPosition;
    Size lineCanvasSize =
        Size(positionDelta.dx.abs() * 2, positionDelta.dy.abs() * 2);

    return Transform.translate(
        offset: dragLine.pivotPosition - lineCanvasSize.center(Offset.zero),
        child: CustomPaint(
            size: lineCanvasSize,
            painter: _DragLinePainter(
                rotatingGearPoint:
                    positionDelta + lineCanvasSize.center(Offset.zero))));
  }
}
