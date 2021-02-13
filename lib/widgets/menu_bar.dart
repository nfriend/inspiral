import 'package:flutter/material.dart';
import 'package:inspiral/widgets/helpers/save_share_image.dart';
import 'package:inspiral/widgets/helpers/toggle_gear_visibility.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';

@immutable
class _ManuBarButtonParams {
  final Icon icon;
  final Function onPressed;

  _ManuBarButtonParams({this.icon, this.onPressed});
}

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    var rotatingGear = Provider.of<RotatingGearState>(context);

    double margin = 2.5;
    double iconSize = 26;

    final Icon visibilityIcon = rotatingGear.isVisible
        ? Icon(Icons.visibility)
        : Icon(Icons.visibility_off);

    List<_ManuBarButtonParams> buttons = [
      _ManuBarButtonParams(
          icon: Icon(Icons.save), onPressed: () => saveImage(context)),
      _ManuBarButtonParams(
          icon: Icon(Icons.share), onPressed: () => shareImage(context)),
      _ManuBarButtonParams(
          icon: visibilityIcon, onPressed: () => toggleGearVisiblity(context)),
      _ManuBarButtonParams(icon: Icon(Icons.undo), onPressed: () {}),
      _ManuBarButtonParams(icon: Icon(Icons.menu), onPressed: () {})
    ];

    List<Widget> rowChildren = buttons
        .map((button) => Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      color: colors.uiTextColor.color,
                      onPressed: button.onPressed,
                      icon: button.icon,
                      iconSize: iconSize,
                    )))))
        .toList();

    return DynamicTheme(
        child: Container(
            color: colors.uiBackgroundColor.color,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: margin * 2),
                child: Row(children: rowChildren))));
  }
}
