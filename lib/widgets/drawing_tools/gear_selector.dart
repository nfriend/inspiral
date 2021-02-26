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
    final rotatingGear = Provider.of<RotatingGearState>(context);
    final fixedGear = Provider.of<FixedGearState>(context);

    final Iterable<GearDefinition> onlyGearsWithHoles =
        allGears.values.where((gear) => gear.holes.length > 0);

    return SelectionRows(rowDefs: [
      SelectionrRowDefinition(label: 'FIXED', children: [
        for (var gear in allGears.values)
          GearSelectorThumbnail(
              isActive: gear == fixedGear.definition,
              gear: gear,
              onGearTap: () => fixedGear.selectNewGear(gear))
      ]),
      SelectionrRowDefinition(label: 'ROTATING', children: [
        for (var gear in onlyGearsWithHoles)
          GearSelectorThumbnail(
              isActive: gear == rotatingGear.definition,
              gear: gear,
              onGearTap: () => rotatingGear.selectNewGear(gear))
      ])
    ]);
  }
}
