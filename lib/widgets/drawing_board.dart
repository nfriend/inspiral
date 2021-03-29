import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:tinycolor/tinycolor.dart';

class DrawingBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pointers = Provider.of<PointersState>(context, listen: false);
    final canvas = Provider.of<CanvasState>(context, listen: false);
    final TinyColor appBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.appBackgroundColor);
    final bool debug =
        context.select<SettingsState, bool>((settings) => settings.debug);
    final double safePaddingTop = MediaQuery.of(context).padding.top;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final Widget scaffoldBody = Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          pointers.pointerDown(event);
        },
        onPointerMove: (event) {
          pointers.pointerMove(event);
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
                color: appBackgroundColor.color, child: CanvasContainer()),
          ),
          Positioned(
              left: 0.0,
              right: isLandscape ? null : 0.0,
              top: isLandscape ? 0.0 : safePaddingTop,
              bottom: isLandscape ? 0.0 : null,
              child: AnimatedToolbarContainer(
                  translateY: isLandscape ? 0.0 : -42.0 - safePaddingTop,
                  translateX: isLandscape ? -42.0 : 0.0,
                  child: MenuBar())),
          Positioned(
              left: isLandscape ? null : 0.0,
              right: 0.0,
              top: isLandscape ? safePaddingTop : null,
              bottom: 0.0,
              child: AnimatedToolbarContainer(
                  translateY: isLandscape ? 0.0 : 42.0,
                  translateX: isLandscape ? 42.0 : 0.0,
                  child: DrawingTools())),
          Positioned(
              left: 0.0, right: 0.0, bottom: 0.0, child: SelectorDrawer())
        ]));

    return DynamicTheme(
        child: ModalProgress(
            child: Scaffold(
                body: debug ? StatsFl(child: scaffoldBody) : scaffoldBody)));
  }
}
