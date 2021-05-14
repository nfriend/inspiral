import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/environment_config.dart';
import 'package:inspiral/models/auto_draw_speed.dart';
import 'package:inspiral/models/entitlement.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/delete_database.dart';
import 'package:inspiral/widgets/helpers/show_confirmation_dialog.dart';
import 'package:inspiral/widgets/restart_widget.dart';
import 'package:inspiral/widgets/settings_drawer/canvas_size_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/dropdown_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/social_button.dart';
import 'package:inspiral/widgets/settings_drawer/toggle_list_item.dart';
import 'package:provider/provider.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingsDrawer extends StatefulWidget {
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  Future<bool> _entitlementCheckFuture;
  final InAppReview _inAppReview = InAppReview.instance;

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
    var canvas = Provider.of<CanvasState>(context, listen: false);
    var ink = Provider.of<InkState>(context, listen: false);
    var snapPoints = Provider.of<SnapPointState>(context, listen: false);
    var purchases = Provider.of<PurchasesState>(context, listen: false);
    var progress = Provider.of<ProgressState>(context, listen: false);
    var settings = Provider.of<SettingsState>(context);
    var inkIsBaking = context.select<InkState, bool>((ink) => ink.isBaking);
    var isUndoing =
        context.select<UndoRedoState, bool>((undoRedo) => undoRedo.isUndoing);

    var eraseAvailable = !inkIsBaking && !isUndoing;

    Widget appStoreReviewTile = Container();
    if (io.Platform.isIOS || io.Platform.isAndroid) {
      var text = Text(io.Platform.isIOS
          ? 'Review on the App Store'
          : 'Review on Google Play');

      appStoreReviewTile = ListTile(
        title: text,
        onTap: () {
          _inAppReview.openStoreListing(
              appStoreId: EnvironmentConfig.appStoreId);
          Navigator.of(context).pop();
        },
      );
    }

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
                        snapPoints.eraseAllSnapPoints();
                      });
                }
              : null),
      ListTile(
        title: Text('Recenter view'),
        onTap: () {
          canvas.recenterView(context);
          Navigator.of(context).pop();
        },
      ),
      CanvasSizeListItem(),
      ToggleListItem(
          text: 'Include background color when saving or sharing',
          value: settings.includeBackgroundWhenSaving,
          onChanged: (bool newValue) =>
              settings.includeBackgroundWhenSaving = newValue),
      ToggleListItem(
          text: 'Keep tools drawer closed after drawing',
          value: settings.closeDrawingToolsDrawerOnDrag,
          onChanged: (bool newValue) =>
              settings.closeDrawingToolsDrawerOnDrag = newValue),
      ToggleListItem(
          text: 'Prevent incompatible gear pairings',
          value: settings.preventIncompatibleGearPairings,
          onChanged: (bool newValue) {
            if (newValue) {
              settings.preventIncompatibleGearPairings = true;
            } else {
              showConfirmationDialog(
                  context: context,
                  message:
                      'This will allow gear pairings that are impossible with physical gears.\n\nGears will overlap in strange (but entertaining!) ways.',
                  confirmButtonText: 'OK',
                  onConfirm: () {
                    settings.preventIncompatibleGearPairings = false;
                  });
            }
          }),
      DropdownListItem(
          text: 'Auto-draw speed',
          selectedItem: settings.autoDrawSpeed,
          items: AutoDrawSpeed.all,
          onChanged: (String newValue) => settings.autoDrawSpeed = newValue),
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
          }),
      ListTile(
        title: Text('Restore purchases'),
        onTap: () async {
          Navigator.of(context).pop();
          progress.showModalProgress(message: 'Restoring purchases...');
          await purchases.restorePurchases();
          progress.hideModalPropress();
        },
      ),
      ListTile(
        title: Text('Help'),
        onTap: () {
          Navigator.pushNamed(context, InspiralRoutes.help);
        },
      ),
      appStoreReviewTile
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
                            'Additional options',
                            style: TextStyle(fontSize: 20.0),
                          )),
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop())
                        ])))),
        ...regularSettingsItems,
        ...debugSettingsItems,
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Wrap(alignment: WrapAlignment.center, children: [
              SocialButton(
                assetPath: 'images/social_icons/instagram.png',
                linkHref: 'https://www.instagram.com/inspiral.nathanfriend.io/',
              ),
              SocialButton(
                assetPath: 'images/social_icons/facebook.png',
                linkHref: 'https://www.facebook.com/inspiral.nathanfriend.io',
              ),
              SocialButton(
                assetPath: 'images/social_icons/twitter.png',
                linkHref: 'https://twitter.com/inspiral_app',
              ),
              SocialButton(
                assetPath: 'images/social_icons/tumblr.png',
                linkHref: 'https://inspiral-app.tumblr.com/',
              ),
              SocialButton(
                assetPath: 'images/social_icons/gitlab.png',
                linkHref: 'https://gitlab.com/nfriend/inspiral',
              ),
              SocialButton(
                assetPath: 'images/social_icons/email.png',
                linkHref: 'mailto:inspiral@nathanfriend.io',
              )
            ]))
      ],
    ));
  }
}
