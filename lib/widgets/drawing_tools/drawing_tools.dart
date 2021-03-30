import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

@immutable
class _DrawingToolsButton {
  final Icon icon;
  final String text;
  final Function onPressed;
  final DrawerTab tab;

  _DrawingToolsButton({this.icon, this.text, this.onPressed, this.tab});
}

class DrawingTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TinyColor activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final TinyColor activeTextColor = context
        .select<ColorState, TinyColor>((colors) => colors.activeTextColor);
    final TinyColor uiBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.uiBackgroundColor);
    final DrawerTab activeTab = context.select<SelectorDrawerState, DrawerTab>(
        (selectorDrawer) => selectorDrawer.activeTab);
    final bool selectorDrawerIsOpen = context.select<SelectorDrawerState, bool>(
        (selectorDrawer) => selectorDrawer.isOpen);
    final selectorDrawer =
        Provider.of<SelectorDrawerState>(context, listen: false);
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    double margin = 2.5;
    double iconSize = 18;

    List<_DrawingToolsButton> buttons = [
      _DrawingToolsButton(
          icon: Icon(Icons.build, size: iconSize),
          text: 'TOOLS',
          tab: DrawerTab.tools,
          onPressed: () => selectorDrawer.toggleOrSelectDrawer(
              tabToSelect: DrawerTab.tools)),
      _DrawingToolsButton(
          icon: Icon(Icons.edit, size: iconSize),
          text: 'PEN',
          tab: DrawerTab.pen,
          onPressed: () =>
              selectorDrawer.toggleOrSelectDrawer(tabToSelect: DrawerTab.pen)),
      _DrawingToolsButton(
          icon: Icon(Icons.settings, size: iconSize),
          text: 'GEARS',
          tab: DrawerTab.gears,
          onPressed: () => selectorDrawer.toggleOrSelectDrawer(
              tabToSelect: DrawerTab.gears)),
    ];

    ButtonStyle activeStyle = ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => activeColor.color),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => activeTextColor.color));

    return Container(
      color: uiBackgroundColor.color,
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
                      child: RotatedBox(
                          quarterTurns: isLandscape ? 3 : 0,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: margin),
                              child: TextButton.icon(
                                  style: activeTab == button.tab &&
                                          selectorDrawerIsOpen
                                      ? activeStyle
                                      : null,
                                  onPressed: button.onPressed,
                                  icon: button.icon,
                                  label: Text(button.text)))))
              ])),
    );
  }
}
