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
                      text: "FIXED",
                      icon: Icon(Icons.push_pin),
                      iconMargin: iconMargin,
                    ),
                    Tab(
                      text: "ROTATING",
                      icon: Icon(Icons.flip_camera_android),
                      iconMargin: iconMargin,
                    ),
                    Tab(
                      text: "PEN",
                      icon: Icon(Icons.edit),
                      iconMargin: iconMargin,
                    ),
                  ],
                ))));
  }
}
