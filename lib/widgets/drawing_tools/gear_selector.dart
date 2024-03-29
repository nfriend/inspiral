import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/are_gears_compatible.dart';
import 'package:inspiral/util/gear_lists.dart';
import 'package:inspiral/widgets/drawing_tools/gear_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';
import 'package:provider/provider.dart';

class GearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rotatingGearDefinition =
        context.select<RotatingGearState, GearDefinition>(
            (rotatingGear) => rotatingGear.definition);
    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
    final fixedGearDefinition = context.select<FixedGearState, GearDefinition>(
        (fixedGear) => fixedGear.definition);
    final preventIncompatibleGearPairings = context.select<SettingsState, bool>(
        (settings) => settings.preventIncompatibleGearPairings);
    final fixedGear = Provider.of<FixedGearState>(context, listen: false);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(
          storageKey: 'fixedGears',
          label: 'FIXED',
          children: [
            for (var gear in onlyGearsWithoutHoles)
              GearSelectorThumbnail(
                  isActive: gear == fixedGearDefinition,
                  gear: gear,
                  onGearTap: () => fixedGear.selectNewGear(gear))
          ]),
      SelectionrRowDefinition(
          storageKey: 'rotatingGears',
          label: 'ROTATING',
          children: [
            for (var gear in onlyGearsWithHoles)
              GearSelectorThumbnail(
                  isActive: gear == rotatingGearDefinition,
                  isCompatibleWithFixedGear: !preventIncompatibleGearPairings ||
                      areGearsCompatible(
                          fixedGear: fixedGearDefinition, rotatingGear: gear),
                  gear: gear,
                  onGearTap: () => rotatingGear.selectNewGear(gear))
          ])
    ]);
  }
}
