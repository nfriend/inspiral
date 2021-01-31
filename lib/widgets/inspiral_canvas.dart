import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inspiral/widgets/debug_canvas.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:inspiral/state/state.dart';
import 'package:statsfl/statsfl.dart';

class _TempGearTestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Color(0xFFFFFFFF), BlendMode.color);
  }

  @override
  bool shouldRepaint(_TempGearTestPainter oldDelegate) => false;
}

class InspiralCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fixedGear = Provider.of<FixedGearState>(context, listen: false);
    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
    final pointers = Provider.of<PointersState>(context, listen: false);
    final canvas = Provider.of<CanvasState>(context);
    final settings = Provider.of<SettingsState>(context);

    return StatsFl(
        isEnabled: settings.debug,
        child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              pointers.globalPointerDown(event);
              canvas.globalPointerDown(event);
              fixedGear.globalPointerDown(event);
              rotatingGear.globalPointerDown(event);
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
                        child: Stack(children: [
                          CustomPaint(
                              size: canvasSize,
                              painter: _TempGearTestPainter()),
                          FixedGear(),
                          RotatingGear(),
                          IgnorePointer(
                              child: settings.debug
                                  ? DebugCanvas()
                                  : Container(width: 0.0, height: 0.0))
                        ])),
                  ))
            ])));
  }
}
