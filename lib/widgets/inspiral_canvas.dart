import 'package:flutter/material.dart';
import 'package:inspiral/models/fixed_gear_model.dart';
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

    return Listener(
        onPointerMove: (event) {
          fixedGear.globalPointerMove(event);
          rotatingGear.globalPointerMove(event);
        },
        onPointerUp: (event) {
          fixedGear.globalPointerUp(event);
          rotatingGear.globalPointerUp(event);
        },
        child: StatsFl(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Expanded(
                  flex: 1,
                  child: Stack(children: [
                    Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(painter: _TempGearTestPainter())),
                    FixedGear(),
                    RotatingGear()
                  ])),
            ])));
  }
}
