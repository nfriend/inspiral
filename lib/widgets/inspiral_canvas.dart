import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:provider/provider.dart';
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
    final fixedGear = Provider.of<FixedGearModel>(context, listen: false);
    final rotatingGear = Provider.of<RotatingGearModel>(context, listen: false);
    final pointers = Provider.of<PointersModel>(context, listen: false);
    final canvas = Provider.of<CanvasModel>(context);

    return Listener(
        onPointerDown: (event) {
          final transformedPosition =
              canvas.toCanvasCoordinates(event.position, context);

          pointers.globalPointerDown(transformedPosition, event);
          canvas.globalPointerDown(transformedPosition, event);
        },
        onPointerMove: (event) {
          final transformedPosition =
              canvas.toCanvasCoordinates(event.position, context);

          fixedGear.globalPointerMove(transformedPosition, event);
          rotatingGear.globalPointerMove(transformedPosition, event);
          canvas.globalPointerMove(transformedPosition, event);
        },
        onPointerUp: (event) {
          final transformedPosition =
              canvas.toCanvasCoordinates(event.position, context);

          pointers.globalPointerUp(transformedPosition, event);
          fixedGear.globalPointerUp(transformedPosition, event);
          rotatingGear.globalPointerUp(transformedPosition, event);
          canvas.globalPointerUp(transformedPosition, event);
        },
        child: StatsFl(
          child: Center(
              child: Transform(
                  transform: canvas.transform,
                  child: Stack(children: [
                    CustomPaint(
                        size: Size(5000, 5000),
                        painter: _TempGearTestPainter()),
                    FixedGear(),
                    RotatingGear()
                  ]))),
        ));
  }
}
