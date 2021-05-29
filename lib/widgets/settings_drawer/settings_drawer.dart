import 'package:flutter/material.dart';
import 'package:inspiral/widgets/helpers/is_screen_big_enough_for_redo_button.dart';
import 'package:inspiral/widgets/settings_drawer/app_store_review_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/auto_draw_speed_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/background_transparency_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/canvas_size_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/erase_canvas_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/help_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/keep_tools_drawer_closed_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/prevent_incompatible_gear_pairings_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/recenter_view_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/redo_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/reset_colors_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/restore_purchases_list_item.dart';
import 'package:inspiral/widgets/settings_drawer/settings_drawer_title.dart';
import 'package:inspiral/widgets/settings_drawer/social_button_row.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SettingsDrawerTitle(),
              isScreenBigEnoughForRedoButton(context) ? null : RedoListItem(),
              EraseCanvasListItem(),
              RecenterViewListItem(),
              CanvasSizeListItem(),
              BackgroundTransparencyListItem(),
              KeepToolsDrawerClosedListItem(),
              PreventIncompatibleGearPairingsListItem(),
              AutoDrawSpeedListItem(),
              ResetColorsListItem(),
              RestorePurchasesListItem(),
              HelpListItem(),
              AppStoreReviewListItem(),
              SocialButtonRow()
            ].where((element) => element != null).toList() as List<Widget>));
  }
}
