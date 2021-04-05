import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/delete_database.dart';
import 'package:inspiral/widgets/settings_drawer/toggle_list_item.dart';
import 'package:provider/provider.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorState colors = Provider.of<ColorState>(context, listen: false);
    SettingsState settings = Provider.of<SettingsState>(context);

    List<Widget> regularSettingsItems = [
      ToggleListItem(
          text: "Include background color when saving or sharing",
          value: settings.includeBackgroundWhenSaving,
          onChanged: (bool newValue) =>
              settings.includeBackgroundWhenSaving = newValue),
      ToggleListItem(
          text: "Close tools drawer when drawing",
          value: settings.closeDrawingToolsDrawerOnDrag,
          onChanged: (bool newValue) =>
              settings.closeDrawingToolsDrawerOnDrag = newValue),
    ];

    List<Widget> debugSettingsItems = [];
    if (settings.debug) {
      debugSettingsItems = [
        Divider(),
        ListTile(
          title: Text("Delete DB file"),
          onTap: () async {
            await deleteDatabase();
          },
        )
      ];
    }

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Container(
                height: menuBarHeight,
                color: colors.uiBackgroundColor.color,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            "Settings",
                            style: TextStyle(fontSize: 20.0),
                          )),
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop())
                        ])))),
        ...regularSettingsItems,
        ...debugSettingsItems
      ],
    ));
  }
}
