import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/helpers/show_confirmation_dialog.dart';
import 'package:inspiral/widgets/settings_drawer/toggle_list_item.dart';
import 'package:provider/provider.dart';

class PreventIncompatibleGearPairingsListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsState>(context);

    return ToggleListItem(
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
        });
  }
}
