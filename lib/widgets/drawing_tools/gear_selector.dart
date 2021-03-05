import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/gear_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';

import 'package:provider/provider.dart';
import 'package:inspiral/models/gears/gears.dart';

class GearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GearDefinition rotatingGearDefinition =
        context.select<RotatingGearState, GearDefinition>(
            (rotatingGear) => rotatingGear.definition);
    final RotatingGearState rotatingGear =
        Provider.of<RotatingGearState>(context, listen: false);
    final GearDefinition fixedGearDefinition =
        context.select<FixedGearState, GearDefinition>(
            (fixedGear) => fixedGear.definition);
    final fixedGear = Provider.of<FixedGearState>(context, listen: false);

    final Iterable<GearDefinition> onlyGearsWithHoles =
        allGears.values.where((gear) => gear.holes.length > 0);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(
          storageKey: "fixedGears",
          label: 'FIXED',
          children: [
            for (var gear in allGears.values)
              GearSelectorThumbnail(
                  isActive: gear == fixedGearDefinition,
                  gear: gear,
                  onGearTap: () => fixedGear.selectNewGear(gear))
          ]),
      SelectionrRowDefinition(
          storageKey: "rotatingGears",
          label: 'ROTATING',
          children: [
            for (var gear in onlyGearsWithHoles)
              GearSelectorThumbnail(
                  isActive: gear == rotatingGearDefinition,
                  gear: gear,
                  onGearTap: () => rotatingGear.selectNewGear(gear))
          ])
    ]);
  }
}
