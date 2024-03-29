import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/util/should_render_landscape_mode.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

@immutable
class _DrawingToolsButton {
  final Icon icon;
  final String text;
  final void Function() onPressed;
  final DrawerTab tab;

  _DrawingToolsButton({required this.icon, required this.text, required this.onPressed, required this.tab});
}

class DrawingTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final activeTextColor = context
        .select<ColorState, TinyColor>((colors) => colors.activeTextColor);
    final uiBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.uiBackgroundColor);
    final activeTab = context.select<SelectorDrawerState, DrawerTab>(
        (selectorDrawer) => selectorDrawer.activeTab);
    final selectorDrawerIsOpen = context.select<SelectorDrawerState, bool>(
        (selectorDrawer) => selectorDrawer.isOpen);
    final selectorDrawer =
        Provider.of<SelectorDrawerState>(context, listen: false);
    final useLandscapeMode = shouldRenderLandscapeMode(context);

    var margin = 2.5;
    var iconSize = 18.0;

    var buttons = <_DrawingToolsButton>[
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

    var activeStyle = ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => activeColor.color),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => activeTextColor.color));

    return Container(
      color: uiBackgroundColor.color,
      height: useLandscapeMode
          ? null
          : menuBarHeight + MediaQuery.of(context).viewPadding.bottom,
      width: useLandscapeMode
          ? menuBarHeight + MediaQuery.of(context).viewPadding.right
          : null,
      child: Padding(
          padding: useLandscapeMode
              ? EdgeInsets.symmetric(vertical: margin * 2)
              : EdgeInsets.symmetric(horizontal: margin * 2),
          child: Flex(
              direction: useLandscapeMode ? Axis.vertical : Axis.horizontal,
              verticalDirection: VerticalDirection.up,
              crossAxisAlignment: useLandscapeMode
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                for (var button in buttons)
                  Expanded(
                      child: RotatedBox(
                          quarterTurns: useLandscapeMode ? 3 : 0,
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
