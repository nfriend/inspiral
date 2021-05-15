import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/settings_drawer/list_item_padding.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class SettingsDrawerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var uiBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.uiBackgroundColor);

    return Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Container(
            height: menuBarHeight + MediaQuery.of(context).padding.top,
            color: uiBackgroundColor.color,
            child: Stack(children: [
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  height: menuBarHeight,
                  child: ListItemPadding(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Expanded(
                            child: Text(
                          'Additional options',
                          style: TextStyle(fontSize: 20.0),
                        )),
                        Expanded(
                            flex: 0,
                            child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.of(context).pop()))
                      ])))
            ])));
  }
}
