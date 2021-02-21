import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:inspiral/widgets/animated_toolbar_container.dart';
import 'package:inspiral/widgets/canvas_container.dart';
import 'package:inspiral/widgets/drawing_tools/drawing_tools.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';
import 'package:inspiral/widgets/menu_bar.dart';
import 'package:inspiral/widgets/modal_progress.dart';
import 'package:inspiral/widgets/drawing_tools/selector_drawer.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:statsfl/statsfl.dart';

class DrawingBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    final fixedGear = Provider.of<FixedGearState>(context, listen: false);
    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
    final pointers = Provider.of<PointersState>(context, listen: false);
    final canvas = Provider.of<CanvasState>(context, listen: false);
    final colors = Provider.of<ColorState>(context);
    final settings = Provider.of<SettingsState>(context);

    final Widget scaffoldBody = Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          pointers.pointerDown(event);
          canvas.globalPointerDown(event);
          fixedGear.globalPointerDown(event);
          rotatingGear.globalPointerDown(event);
        },
        onPointerMove: (event) {
          canvas.globalPointerMove(event);
        },
        onPointerUp: (event) {
          pointers.pointerUp(event);
          canvas.globalPointerUp(event);
        },
        child: Stack(children: [
          // This `OverflowBox` should be twice the size of the canvas.
          // The canvas will be centered in `OverflowBox`, leaving a large
          // amount of padding on every side. This padding allows the gears
          // to respond to pointer events even when outside the canvas.
          OverflowBox(
            maxHeight: canvasSize.height * 2,
            minHeight: canvasSize.height * 2,
            maxWidth: canvasSize.width * 2,
            minWidth: canvasSize.width * 2,
            alignment: Alignment.topLeft,
            child: Container(
                color: colors.appBackgroundColor.color,
                child: CanvasContainer()),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AnimatedToolbarContainer(
                  translateY: -42.0, child: MenuBar())),
          Positioned(left: 0, right: 0, bottom: 0, child: SelectorDrawer())
        ]));

    return DynamicTheme(
        child: ModalProgress(
            child: Scaffold(
                body: settings.debug
                    ? StatsFl(child: scaffoldBody)
                    : scaffoldBody,
                bottomNavigationBar: AnimatedToolbarContainer(
                    translateY: 42.0, child: DrawingTools()))));
  }
}
