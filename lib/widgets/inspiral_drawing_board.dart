import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inspiral/widgets/bottom_tabs.dart';
import 'package:inspiral/widgets/debug_canvas.dart';
import 'package:inspiral/widgets/dry_ink_canvas.dart';
import 'package:inspiral/widgets/fresh_ink_canvas.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:inspiral/state/state.dart';
import 'package:statsfl/statsfl.dart';

class InspiralDrawingBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fixedGear = Provider.of<FixedGearState>(context, listen: false);
    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
    final pointers = Provider.of<PointersState>(context, listen: false);
    final canvas = Provider.of<CanvasState>(context);
    final colors = Provider.of<ColorState>(context);
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
                    decoration:
                        BoxDecoration(color: colors.appBackgroundColor.color),
                    width: canvasSize.width,
                    height: canvasSize.height,
                    child: Transform(
                        transform: canvas.transform,
                        child: Container(
                            decoration: BoxDecoration(
                                color: colors.backgroundColor.color,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: colors.canvasShadowColor.color,
                                      blurRadius: 300,
                                      spreadRadius: 50)
                                ]),
                            child: Stack(children: [
                              DryInkCanvas(),
                              FreshInkCanvas(),
                              FixedGear(),
                              RotatingGear(),
                              IgnorePointer(
                                  child: settings.debug
                                      ? DebugCanvas()
                                      : Container(width: 0.0, height: 0.0))
                            ]))),
                  )),
              Positioned(left: 0, right: 0, bottom: 0, child: BottomTabs())
            ])));
  }
}