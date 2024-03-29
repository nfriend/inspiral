import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/canvas_transform.dart';
import 'package:inspiral/widgets/debug_canvas.dart';
import 'package:inspiral/widgets/dry_ink_canvas.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/fresh_ink_canvas.dart';
import 'package:inspiral/widgets/hole_selector.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:inspiral/widgets/snap_points.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class CanvasContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final canvas = Provider.of<CanvasState>(context, listen: false);
    final canvasSize =
        context.select<CanvasState, Size>((canvas) => canvas.canvasSize);
    final debug =
        context.select<SettingsState, bool>((settings) => settings.debug);
    final canvasShadowColor = context
        .select<ColorState, TinyColor>((colors) => colors.canvasShadowColor);
    final pointers = Provider.of<PointersState>(context, listen: false);

    return Stack(children: [
      Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            pointers.pointerDown(event);
            canvas.appBackgroundOrCanvasDown(event);
          },
          onPointerMove: (event) {
            pointers.pointerMove(event);
            canvas.appBackgroundOrCanvasMove(event);
          }),
      CanvasTransform(
          child: Stack(children: [
        _wrapInPositioned(
            canvasSize: canvasSize,
            child: Container(
              width: canvasSize.width,
              height: canvasSize.height,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: canvasShadowColor.color,
                    blurRadius: 300,
                    spreadRadius: 50)
              ]),
            )),
        _wrapInPositioned(canvasSize: canvasSize, child: DryInkCanvas()),
        _wrapInPositioned(canvasSize: canvasSize, child: FreshInkCanvas()),
        _wrapInPositioned(
            canvasSize: canvasSize,
            child: Container(
              width: canvasSize.width,
              height: canvasSize.height,
              child: Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (event) {
                    pointers.pointerDown(event);
                    canvas.appBackgroundOrCanvasDown(event);
                  },
                  onPointerMove: (event) {
                    pointers.pointerMove(event);
                    canvas.appBackgroundOrCanvasMove(event);
                  }),
            )),
        SnapPoints(),
        _wrapInPositioned(canvasSize: canvasSize, child: FixedGear()),
        _wrapInPositioned(canvasSize: canvasSize, child: RotatingGear()),
        _wrapInPositioned(canvasSize: canvasSize, child: HoleSelector()),
        _wrapInPositioned(
            canvasSize: canvasSize,
            child: IgnorePointer(
                child:
                    debug ? DebugCanvas() : Container(width: 0.0, height: 0.0)))
      ]))
    ]);
  }

  /// Wraps the provided child in a `Positioned` that offsets
  /// the child the proper amount relative to the parent.
  /// This is necessary because we need the children to respond to pointer
  /// events outside of the canvas, so it's necessary there's a buffer
  /// between the edge of the canvas and the actual parent widget. This is
  /// because children don't respond to events if the event happens outside
  /// of the parent.
  Widget _wrapInPositioned(
      {required Widget child, required Size canvasSize}) {
    return Positioned(top: canvasPadding, left: canvasPadding, child: child);
  }
}
