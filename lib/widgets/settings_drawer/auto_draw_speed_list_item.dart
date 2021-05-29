import 'package:flutter/widgets.dart';
import 'package:inspiral/models/auto_draw_speed.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/settings_drawer/dropdown_list_item.dart';
import 'package:provider/provider.dart';

class AutoDrawSpeedListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsState>(context);

    return DropdownListItem(
        text: 'Auto-draw speed',
        selectedItem: settings.autoDrawSpeed,
        items: AutoDrawSpeed.all,
        onChanged: (String? newValue) {
          assert(newValue != null, 'auto-draw speed cannot be null');
          settings.autoDrawSpeed = newValue!;
        });
  }
}
