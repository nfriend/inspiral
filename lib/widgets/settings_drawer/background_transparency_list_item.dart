import 'package:flutter/widgets.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/settings_drawer/toggle_list_item.dart';
import 'package:provider/provider.dart';

class BackgroundTransparencyListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsState>(context);

    return ToggleListItem(
        text: 'Include background color when saving or sharing',
        value: settings.includeBackgroundWhenSaving,
        onChanged: (bool newValue) =>
            settings.includeBackgroundWhenSaving = newValue);
  }
}
