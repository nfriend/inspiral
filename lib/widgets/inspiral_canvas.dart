import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inspiral/widgets/debug_canvas.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:inspiral/state/state.dart';
import 'package:statsfl/statsfl.dart';

class InspiralCanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: Draw lines here
  }

  @override
  bool shouldRepaint(InspiralCanvasPainter oldDelegate) => false;
}

class InspiralCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fixedGear = Provider.of<FixedGearState>(context, listen: false);
    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
    final pointers = Provider.of<PointersState>(context, listen: false);
    final canvas = Provider.of<CanvasState>(context);
    final background = Provider.of<BackgroundState>(context);
    final settings = Provider.of<SettingsState>(context);

    Color appBackground = (background.color.isDark()
            ? background.color.lighten()
            : background.color.darken())
        .color;

    Color canvasShadowColor = (background.color.isDark()
            ? background.color.lighten(20)
            : background.color.darken(20))
        .color;

    Color canvasColor = background.color.color;

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
                    decoration: BoxDecoration(color: appBackground),
                    width: canvasSize.width,
                    height: canvasSize.height,
                    child: Transform(
                        transform: canvas.transform,
                        child: Container(
                            decoration: BoxDecoration(
                                color: canvasColor,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: canvasShadowColor,
                                      blurRadius: 300,
                                      spreadRadius: 50)
                                ]),
                            child: Stack(children: [
                              CustomPaint(
                                  size: canvasSize,
                                  painter: InspiralCanvasPainter()),
                              FixedGear(),
                              RotatingGear(),
                              IgnorePointer(
                                  child: settings.debug
                                      ? DebugCanvas()
                                      : Container(width: 0.0, height: 0.0))
                            ]))),
                  ))
            ])));
  }
}
