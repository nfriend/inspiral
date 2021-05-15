import 'package:flutter/widgets.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/settings_drawer/toggle_list_item.dart';
import 'package:provider/provider.dart';

class KeepToolsDrawerClosedListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsState>(context);

    return ToggleListItem(
        text: 'Keep tools drawer closed after drawing',
        value: settings.closeDrawingToolsDrawerOnDrag,
        onChanged: (bool newValue) =>
            settings.closeDrawingToolsDrawerOnDrag = newValue);
  }
}
