import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/widgets/helpers/save_share_image.dart';
import 'package:inspiral/widgets/helpers/toggle_gear_visibility.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

@immutable
class _ManuBarButtonParams {
  final Icon icon;
  final Function onPressed;
  final String tooltipMessage;

  _ManuBarButtonParams(
      {@required this.icon,
      @required this.onPressed,
      @required this.tooltipMessage});
}

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    final bool rotatingGearIsVisible = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isVisible);
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    double margin = 2.5;
    double iconSize = 26;

    final Icon visibilityIcon = rotatingGearIsVisible
        ? Icon(Icons.visibility)
        : Icon(Icons.visibility_off);

    List<_ManuBarButtonParams> buttons = [
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
          icon: Icon(Icons.undo), onPressed: () {}, tooltipMessage: 'Undo'),
      _ManuBarButtonParams(
          icon: Icon(Icons.menu), onPressed: () {}, tooltipMessage: 'Show menu')
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
                                  onPressed: button.onPressed,
                                  icon: button.icon,
                                  iconSize: iconSize,
                                  tooltip: button.tooltipMessage,
                                ))))
                ])));
  }
}
