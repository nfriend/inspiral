import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/util/should_render_landscape_mode.dart';
import 'package:inspiral/widgets/helpers/is_screen_big_enough_for_redo_button.dart';
import 'package:inspiral/widgets/helpers/save_share_image.dart';
import 'package:inspiral/widgets/helpers/toggle_gear_visibility.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

@immutable
class _ManuBarButtonParams {
  final Icon icon;
  final void Function() onPressed;
  final String tooltipMessage;
  final bool disabled;

  _ManuBarButtonParams(
      {@required this.icon,
      @required this.onPressed,
      @required this.tooltipMessage,
      this.disabled = false});
}

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    final canvas = Provider.of<CanvasState>(context, listen: false);
    final undoRedo = Provider.of<UndoRedoState>(context, listen: false);
    final undoAvailable = context
        .select<UndoRedoState, bool>((undoRedo) => undoRedo.undoAvailable);
    final redoAvailable = context
        .select<UndoRedoState, bool>((undoRedo) => undoRedo.redoAvailable);
    final isUndoing =
        context.select<UndoRedoState, bool>((undoRedo) => undoRedo.isUndoing);
    final isRedoing =
        context.select<UndoRedoState, bool>((undoRedo) => undoRedo.isRedoing);
    final rotatingGearIsVisible = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isVisible);
    final useLandscapeMode = shouldRenderLandscapeMode(context);

    var margin = 2.5;
    var iconSize = 26.0;

    final visibilityIcon = rotatingGearIsVisible
        ? Icon(Icons.visibility)
        : Icon(Icons.visibility_off);

    final redoButton = isScreenBigEnoughForRedoButton(context)
        ? _ManuBarButtonParams(
            icon: isRedoing ? Icon(Icons.hourglass_bottom) : Icon(Icons.redo),
            disabled: !redoAvailable,
            onPressed: () async {
              await undoRedo.triggerRedo();
            },
            tooltipMessage: 'Redo')
        : null;

    var buttons = <_ManuBarButtonParams>[
      _ManuBarButtonParams(
          icon: Icon(Icons.save),
          onPressed: () => saveImage(context),
          tooltipMessage: 'Save drawing to the gallery'),
      _ManuBarButtonParams(
          icon: Icon(Icons.share),
          onPressed: () => shareImage(context),
          tooltipMessage: 'Share drawing'),
      _ManuBarButtonParams(
          icon: visibilityIcon,
          onPressed: () => toggleGearVisiblity(context),
          tooltipMessage: 'Toggle gear visibility'),
      _ManuBarButtonParams(
          icon: isUndoing ? Icon(Icons.hourglass_bottom) : Icon(Icons.undo),
          disabled: !undoAvailable,
          onPressed: () async {
            await undoRedo.triggerUndo();
          },
          tooltipMessage: 'Undo'),
      redoButton,
      _ManuBarButtonParams(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Cancel hole selection mode in the off chance it's active
            canvas.isSelectingHole = false;

            var scaffold = Scaffold.of(context);
            useLandscapeMode ? scaffold.openDrawer() : scaffold.openEndDrawer();
          },
          tooltipMessage: 'Show menu')
    ].where((element) => element != null).toList();

    return Container(
        color: colors.uiBackgroundColor.color,
        height: useLandscapeMode
            ? null
            : menuBarHeight + MediaQuery.of(context).viewPadding.top,
        width: useLandscapeMode
            ? menuBarHeight + MediaQuery.of(context).viewPadding.left
            : null,
        child: Padding(
            padding: useLandscapeMode
                ? EdgeInsets.symmetric(vertical: margin * 2)
                : EdgeInsets.symmetric(horizontal: margin * 2),
            child: Flex(
                direction: useLandscapeMode ? Axis.vertical : Axis.horizontal,
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: useLandscapeMode
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  for (var button in buttons)
                    Expanded(
                        child: Padding(
                            padding: useLandscapeMode
                                ? EdgeInsets.symmetric(vertical: margin)
                                : EdgeInsets.symmetric(horizontal: margin),
                            child: Material(
                                type: MaterialType.transparency,
                                child: IconButton(
                                  color: colors.uiTextColor.color,
                                  onPressed:
                                      button.disabled ? null : button.onPressed,
                                  icon: button.icon,
                                  iconSize: iconSize,
                                  tooltip: button.tooltipMessage,
                                ))))
                ])));
  }
}
