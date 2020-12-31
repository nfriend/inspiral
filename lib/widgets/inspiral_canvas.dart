import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:inspiral/providers/providers.dart';
import 'package:statsfl/statsfl.dart';

class _TempGearTestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var gradient = RadialGradient(
      center: const Alignment(0.7, -0.6),
      radius: 0.2,
      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_TempGearTestPainter oldDelegate) => false;
}

class InspiralCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pointers = Provider.of<PointersProvider>(context, listen: false);
    final canvas = Provider.of<CanvasProvider>(context);

    return StatsFl(
        child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              pointers.globalPointerDown(event);
              canvas.globalPointerDown(event);
            },
            onPointerMove: (event) {
              canvas.globalPointerMove(event);
            },
            onPointerUp: (event) {
              pointers.globalPointerUp(event);
              canvas.globalPointerUp(event);
            },
            child: Stack(children: [
              OverflowBox(
                  maxHeight: canvasSize.height,
                  minHeight: canvasSize.height,
                  maxWidth: canvasSize.width,
                  minWidth: canvasSize.width,
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: canvasSize.width,
                    height: canvasSize.height,
                    child: Transform(
                        transform: canvas.transform,
                        child: SizedBox(
                            width: 1000,
                            height: 1000,
                            child: Stack(children: [
                              CustomPaint(
                                  size: canvasSize,
                                  painter: _TempGearTestPainter()),
                              FixedGear(),
                              RotatingGear()
                            ]))),
                  ))
            ])));
  }
}
