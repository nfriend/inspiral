import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
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
  bool isUndoProcessing = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    final ink = Provider.of<InkState>(context, listen: false);
    final canvas = Provider.of<CanvasState>(context, listen: false);
    final undoRedo = Provider.of<UndoRedoState>(context, listen: false);
    final undoAvailable = context
        .select<UndoRedoState, bool>((undoRedo) => undoRedo.undoAvailable);
    final rotatingGearIsVisible = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isVisible);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var margin = 2.5;
    var iconSize = 26.0;

    final visibilityIcon = rotatingGearIsVisible
        ? Icon(Icons.visibility)
        : Icon(Icons.visibility_off);

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
          icon: isUndoProcessing
              ? Icon(Icons.hourglass_bottom)
              : Icon(Icons.undo),
          disabled: !undoAvailable || isUndoProcessing,
          onPressed: () async {
            setState(() {
              isUndoProcessing = true;
            });

            // Allow the `setState` above to take effect before
            // we start the undo process below. This ensures the button
            // has a chance to show its loading state before the CPU-intensive
            // work of undoing begins.
            await Future.delayed(const Duration(milliseconds: 0));

            await undoRedo.triggerUndo();

            setState(() {
              isUndoProcessing = false;
            });
          },
          tooltipMessage: 'Undo'),
      _ManuBarButtonParams(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Cancel hole selection mode in the off chance it's active
            canvas.isSelectingHole = false;

            var scaffold = Scaffold.of(context);
            isLandscape ? scaffold.openDrawer() : scaffold.openEndDrawer();
          },
          tooltipMessage: 'Show menu')
    ];

    return Container(
        color: colors.uiBackgroundColor.color,
        height: isLandscape ? null : menuBarHeight,
        width: isLandscape ? menuBarHeight : null,
        child: Padding(
            padding: isLandscape
                ? EdgeInsets.symmetric(vertical: margin * 2)
                : EdgeInsets.symmetric(horizontal: margin * 2),
            child: Flex(
                direction: isLandscape ? Axis.vertical : Axis.horizontal,
                verticalDirection: VerticalDirection.up,
                children: [
                  for (var button in buttons)
                    Expanded(
                        child: Padding(
                            padding: isLandscape
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
