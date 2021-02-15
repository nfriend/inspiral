import 'package:flutter/material.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

@immutable
class _DrawingToolsButton {
  final Icon icon;
  final String text;
  final Function onPressed;

  _DrawingToolsButton({this.icon, this.text, this.onPressed});
}

class DrawingTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ColorState>(context);
    final selectorDrawer =
        Provider.of<SelectorDrawerState>(context, listen: false);

    double margin = 2.5;
    double iconSize = 18;

    List<_DrawingToolsButton> buttons = [
      _DrawingToolsButton(
          icon: Icon(Icons.edit, size: iconSize),
          text: 'PEN',
          onPressed: () =>
              selectorDrawer.toggleOrSelectDrawer(tabToSelect: DrawerTab.pen)),
      _DrawingToolsButton(
          icon: Icon(Icons.palette, size: iconSize),
          text: 'COLORS',
          onPressed: () => selectorDrawer.toggleOrSelectDrawer(
              tabToSelect: DrawerTab.colors)),
      _DrawingToolsButton(
          icon: Icon(Icons.settings, size: iconSize),
          text: 'GEARS',
          onPressed: () => selectorDrawer.toggleOrSelectDrawer(
              tabToSelect: DrawerTab.gears)),
    ];

    return DynamicTheme(
      child: Container(
          color: colors.uiBackgroundColor.color,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: margin * 2),
              child: Row(children: [
                for (var button in buttons)
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: margin),
                          child: TextButton.icon(
                              onPressed: button.onPressed,
                              icon: button.icon,
                              label: Text(button.text))))
              ]))),
    );
  }
}
