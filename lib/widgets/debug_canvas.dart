import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/contact_point.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class _DebugCanvasPainterParams {
  /// The position of the rotating gear
  Offset rotatingGearPosition;

  /// The position of the fixed gear
  Offset fixedGearPosition;

  /// The position of the pivot point (usually the center of the fixed gear)
  Offset pivotPosition;

  /// The position of the pointer
  Offset pointerPosition;

  /// The contact point of the rotating gear
  ContactPoint rotatingGearContactPoint;

  /// The contact point of the fixed gear
  ContactPoint fixedGearContactPoint;

  /// Log message
  String logMessage;

  @override
  int get hashCode =>
      rotatingGearPosition.hashCode ^
      fixedGearPosition.hashCode ^
      pivotPosition.hashCode ^
      pointerPosition.hashCode ^
      rotatingGearContactPoint.hashCode ^
      fixedGearContactPoint.hashCode ^
      logMessage.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _DebugCanvasPainterParams &&
      other.rotatingGearPosition == rotatingGearPosition &&
      other.fixedGearPosition == fixedGearPosition &&
      other.pivotPosition == pivotPosition &&
      other.pointerPosition == pointerPosition &&
      other.rotatingGearContactPoint == rotatingGearContactPoint &&
      other.fixedGearContactPoint == fixedGearContactPoint &&
      other.logMessage == logMessage;
}

/// A debugging aid that draws a line between the rotation
/// point (usually the center of the fixed gear) and the pointer
class _DebugCanvasPainter extends CustomPainter {
  _DebugCanvasPainter(this.params);

  final _DebugCanvasPainterParams params;

  void paintFixedGearCenter(Canvas canvas) {
    final circlePaint = Paint()
      ..color = Color(0xCC3446EB)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        params.fixedGearPosition, debugDotSize.width, circlePaint);
  }

  void paintRotatingGearCenter(Canvas canvas) {
    final circlePaint = Paint()
      ..color = Color(0xCCEB4034)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        params.rotatingGearPosition, debugDotSize.width, circlePaint);
  }

  void paintDragLine(Canvas canvas) {
    final circlePaint = Paint()
      ..color = Color(0xCCE9EB75)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(params.pointerPosition, debugDotSize.width, circlePaint);

    final linePaint = Paint()
      ..color = Color(0x88262626)
      ..strokeWidth = 2 * scaleFactor
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(params.pivotPosition, params.pointerPosition, linePaint);
  }

  void paintLogMessage(Canvas canvas) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: params.logMessage,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: canvasSize.width,
    );
    final offset = canvasCenter + Offset(-100, 200);
    textPainter.paint(canvas, offset);
  }

  void paintFixedGearContactPoint(Canvas canvas) {
    _paintContactPoint(canvas, params.fixedGearContactPoint, Color(0xCCEBAB34));
  }

  void paintRotatingGearContactPoint(Canvas canvas) {
    _paintContactPoint(
        canvas, params.rotatingGearContactPoint, Color(0xCC34EB74));
  }

  void _paintContactPoint(
      Canvas canvas, ContactPoint contactPoint, Color color) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 1 * scaleFactor
      ..strokeCap = StrokeCap.round;

    final Offset endPostion = contactPoint.position;

    // Draw the main stem of the arrow
    double angle = contactPoint.direction;
    Offset startPosition =
        endPostion - Offset(cos(angle) * 50, -sin(angle) * 50);
    canvas.drawLine(startPosition, endPostion, linePaint);

    // Draw the arrow head
    angle = contactPoint.direction + .5;
    startPosition = endPostion - Offset(cos(angle) * 10, -sin(angle) * 10);
    canvas.drawLine(startPosition, endPostion, linePaint);

    angle = contactPoint.direction - .5;
    startPosition = endPostion - Offset(cos(angle) * 10, -sin(angle) * 10);
    canvas.drawLine(startPosition, endPostion, linePaint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Uncomment below to highlight the entire line canvas
    // in a light color. Useful for debugging.
    // final rectPaint = Paint()
    //   ..color = Color(0X33E9EB75)
    //   ..style = PaintingStyle.fill;
    // canvas.drawRect(Offset.zero & size, rectPaint);

    if (params.rotatingGearPosition != null) {
      paintRotatingGearCenter(canvas);
    }

    if (params.fixedGearPosition != null) {
      paintFixedGearCenter(canvas);
    }

    if (params.pivotPosition != null && params.pointerPosition != null) {
      paintDragLine(canvas);
    }

    if (params.rotatingGearContactPoint != null) {
      paintRotatingGearContactPoint(canvas);
    }

    if (params.fixedGearContactPoint != null) {
      paintFixedGearContactPoint(canvas);
    }

    if (params.logMessage != null) {
      paintLogMessage(canvas);
    }
  }

  @override
  bool shouldRepaint(_DebugCanvasPainter oldDelegate) =>
      oldDelegate.params != params;
}

class DebugCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // We don't actually use any values from this provider, but we need
    // to rely on it so that this widget is rebuild when rotatingGear.isDragging
    // is updated. We should revisit this when we've discovered a way to
    // propogate changes between dependent providers.
    Provider.of<PointersState>(context);

    final rotatingGear = Provider.of<RotatingGearState>(context);
    final fixedGear = Provider.of<FixedGearState>(context);
    final dragLine = Provider.of<DragLineState>(context);
    final ink = Provider.of<InkState>(context);

    final params = _DebugCanvasPainterParams()
      ..fixedGearPosition = fixedGear.position
      ..rotatingGearPosition = rotatingGear.position
      ..logMessage = "# of points: ${ink.currentPointCount}";

    if (rotatingGear.isDragging) {
      params
        ..pivotPosition = dragLine.pivotPosition
        ..pointerPosition = dragLine.pointerPosition
        ..fixedGearContactPoint = fixedGear.contactPoint
        ..rotatingGearContactPoint = rotatingGear.contactPoint;
    }

    return CustomPaint(size: canvasSize, painter: _DebugCanvasPainter(params));
  }
}
