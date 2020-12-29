import 'package:flutter/material.dart';
import 'package:inspiral/models/canvas_model.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
import 'package:inspiral/models/pointer_model.dart';
import 'package:inspiral/models/rotating_gear_model.dart';
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
    var fixedGear = Provider.of<FixedGearModel>(context, listen: false);
    var rotatingGear = Provider.of<RotatingGearModel>(context, listen: false);
    var pointers = Provider.of<PointersModel>(context, listen: false);
    var canvas = Provider.of<CanvasModel>(context);

    return Listener(
        onPointerDown: (event) {
          pointers.globalPointerDown(event);
          canvas.globalPointerDown(event);
        },
        onPointerMove: (event) {
          fixedGear.globalPointerMove(event);
          rotatingGear.globalPointerMove(event);
          canvas.globalPointerMove(event);
        },
        onPointerUp: (event) {
          pointers.globalPointerUp(event);
          fixedGear.globalPointerUp(event);
          rotatingGear.globalPointerUp(event);
          canvas.globalPointerUp(event);
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
