import 'package:flutter/material.dart';
import 'package:inspiral/widgets/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class BottomTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();
    EdgeInsetsGeometry iconMargin = EdgeInsets.only(bottom: 7.0);

    return DefaultTabController(
        length: 3,
        child: DynamicTheme(
            child: Material(
                color: colors.uiBackgroundColor.color,
                child: TabBar(
                  indicatorWeight: 4.0,
                  tabs: [
                    Tab(
                      text: "PEN",
                      icon: Icon(Icons.edit),
                      iconMargin: iconMargin,
                    ),
                    Tab(
                      text: "COLORS",
                      icon: Icon(Icons.palette),
                      iconMargin: iconMargin,
                    ),
                    Tab(
                      text: "GEARS",
                      icon: Icon(Icons.settings),
                      iconMargin: iconMargin,
                    ),
                  ],
                ))));
  }
}
