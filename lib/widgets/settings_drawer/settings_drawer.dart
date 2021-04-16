import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/entitlement.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/delete_database.dart';
import 'package:inspiral/widgets/helpers/show_confirmation_dialog.dart';
import 'package:inspiral/widgets/restart_widget.dart';
import 'package:inspiral/widgets/settings_drawer/toggle_list_item.dart';
import 'package:provider/provider.dart';

class SettingsDrawer extends StatefulWidget {
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  Future<bool> _entitlementCheckFuture;

  @override
  void initState() {
    // Determine if the user has access to custom pen colors _or_
    // custom canvas colors. If they do, show the "Reset colors"
    // option (it doesn't make sense to show this if they can't
    // modify the list of colors).
    var purchases = Provider.of<PurchasesState>(context, listen: false);
    _entitlementCheckFuture = Future.wait([
      purchases.isEntitledTo(Entitlement.custompencolors),
      purchases.isEntitledTo(Entitlement.custombackgroundcolors)
    ]).then((values) => values.any((b) => b));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<ColorState>(context, listen: false);
    var ink = Provider.of<InkState>(context, listen: false);
    var settings = Provider.of<SettingsState>(context);
    var eraseAvailable =
        context.select<InkState, bool>((ink) => ink.eraseAvailable);

    var regularSettingsItems = <Widget>[
      ListTile(
          title: eraseAvailable
              ? Text('Erase canvas')
              : Text('One moment...',
                  style: TextStyle(fontStyle: FontStyle.italic)),
          onTap: eraseAvailable
              ? () {
                  showConfirmationDialog(
                      context: context,
                      message:
                          'Are you sure you want to erase your masterpiece?',
                      confirmButtonText: 'Erase',
                      onConfirm: () {
                        Navigator.of(context).pop();
                        ink.eraseCanvas();
                      });
                }
              : null),
      ToggleListItem(
          text: 'Include background color when saving or sharing',
          value: settings.includeBackgroundWhenSaving,
          onChanged: (bool newValue) =>
              settings.includeBackgroundWhenSaving = newValue),
      ToggleListItem(
          text: 'Close tools drawer when drawing',
          value: settings.closeDrawingToolsDrawerOnDrag,
          onChanged: (bool newValue) =>
              settings.closeDrawingToolsDrawerOnDrag = newValue),
      FutureBuilder(
          future: _entitlementCheckFuture,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return ListTile(
                  title: Text('Reset pen and canvas colors'),
                  onTap: () {
                    showConfirmationDialog(
                        context: context,
                        message:
                            'Are you sure you want to reset your canvas and pen colors back to their defaults?',
                        confirmButtonText: 'Reset',
                        onConfirm: () {
                          Navigator.of(context).pop();
                          colors.reset();
                        });
                  });
            } else {
              return Container();
            }
          })
    ];

    var debugSettingsItems = <Widget>[];
    if (settings.debug) {
      debugSettingsItems = [
        Divider(),
        ListTile(
          title: Text('Delete DB file'),
          onTap: () async {
            await deleteDatabase();
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: Text('Reset app and restart'),
          onTap: () async {
            Navigator.of(context).pop();
            await RestartWidget.restartApp(context, resetDb: true);
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
                            'Settings',
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
