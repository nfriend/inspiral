import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inspiral/util/should_render_landscape_mode.dart';
import 'package:inspiral/widgets/animated_toolbar_container.dart';
import 'package:inspiral/widgets/canvas_container.dart';
import 'package:inspiral/widgets/drawing_tools/drawing_tools.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';
import 'package:inspiral/widgets/menu_bar.dart';
import 'package:inspiral/widgets/modal_progress.dart';
import 'package:inspiral/widgets/drawing_tools/selector_drawer.dart';
import 'package:inspiral/widgets/settings_drawer/settings_drawer.dart';
import 'package:inspiral/widgets/snackbar_container.dart';
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
    final canvasSize =
        context.select<CanvasState, Size>((canvas) => canvas.canvasSize);
    final appBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.appBackgroundColor);
    final debug =
        context.select<SettingsState, bool>((settings) => settings.debug);
    final useLandscapeMode = shouldRenderLandscapeMode(context);
    final safePaddingTop = MediaQuery.of(context).padding.top;
    final safePaddingLeft = MediaQuery.of(context).padding.left;
    final safePaddingRight = MediaQuery.of(context).padding.right;
    final safePaddingBottom = MediaQuery.of(context).padding.bottom;

    // Translate the menu bars _almost_ off the screen
    final translationAmount = menuBarHeight - 6.0;

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
          // This `OverflowBox` should be much larger than the size of the
          // canvas. The canvas will be centered in `OverflowBox`, leaving a
          // large amount of padding on every side. This padding allows the
          // gears to respond to pointer events even when outside the canvas.
          OverflowBox(
            maxHeight: canvasSize.height + (canvasPadding * 2),
            minHeight: canvasSize.height + (canvasPadding * 2),
            maxWidth: canvasSize.width + (canvasPadding * 2),
            minWidth: canvasSize.width + (canvasPadding * 2),
            alignment: Alignment.topLeft,
            child: Container(
                color: appBackgroundColor.color, child: CanvasContainer()),
          ),
          Positioned(
              left: 0.0,
              right: useLandscapeMode ? null : 0.0,
              top: 0.0,
              bottom: useLandscapeMode ? 0.0 : null,
              child: AnimatedToolbarContainer(
                  translateY: useLandscapeMode
                      ? 0.0
                      : -translationAmount - safePaddingTop,
                  translateX: useLandscapeMode
                      ? -translationAmount - safePaddingLeft
                      : 0.0,
                  child: MenuBar())),
          Positioned(
              left: useLandscapeMode ? null : 0.0,
              right: 0.0,
              top: useLandscapeMode ? 0.0 : null,
              bottom: 0.0,
              child: SelectorDrawer()),
          Positioned(
              left: useLandscapeMode ? null : 0.0,
              right: 0.0,
              top: useLandscapeMode ? 0.0 : null,
              bottom: 0.0,
              child: AnimatedToolbarContainer(
                  translateY: useLandscapeMode
                      ? 0.0
                      : translationAmount + safePaddingBottom,
                  translateX: useLandscapeMode
                      ? translationAmount + safePaddingRight
                      : 0.0,
                  child: DrawingTools())),
          SnackbarContainer()
        ]));

    return DynamicTheme(
        child: ModalProgress(
            child: Scaffold(
                body: debug ? StatsFl(child: scaffoldBody) : scaffoldBody,
                drawer: SettingsDrawer(),
                endDrawer: SettingsDrawer(),

                // Effectively disables the "swipe-to-open" drawer behavior
                drawerEdgeDragWidth: 0.0)));
  }
}
