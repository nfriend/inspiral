import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/debug_canvas.dart';
import 'package:inspiral/widgets/dry_ink_canvas.dart';
import 'package:inspiral/widgets/fixed_gear.dart';
import 'package:inspiral/widgets/fresh_ink_canvas.dart';
import 'package:inspiral/widgets/rotating_gear.dart';
import 'package:provider/provider.dart';

class CanvasContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final canvas = Provider.of<CanvasState>(context);
    final settings = Provider.of<SettingsState>(context);
    final colors = Provider.of<ColorState>(context);
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
          },
          onPointerUp: (event) {
            pointers.pointerUp(event);
            canvas.appBackgroundOrCanvasUp(event);
          }),
      Transform(
          transform: canvas.transform,
          child: Stack(children: [
            _wrapInPositioned(Container(
              width: canvasSize.width,
              height: canvasSize.height,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: colors.canvasShadowColor.color,
                    blurRadius: 300,
                    spreadRadius: 50)
              ]),
            )),
            _wrapInPositioned(DryInkCanvas()),
            _wrapInPositioned(FreshInkCanvas()),
            _wrapInPositioned(Container(
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
                  },
                  onPointerUp: (event) {
                    pointers.pointerUp(event);
                    canvas.appBackgroundOrCanvasUp(event);
                  }),
            )),
            _wrapInPositioned(FixedGear()),
            _wrapInPositioned(RotatingGear()),
            _wrapInPositioned(IgnorePointer(
                child: settings.debug
                    ? DebugCanvas()
                    : Container(width: 0.0, height: 0.0)))
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
  Widget _wrapInPositioned(Widget child) {
    return Positioned(
        top: canvasSize.height / 2, left: canvasSize.width / 2, child: child);
  }
}
