import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/gear_selector_thumbnail.dart';
import 'package:inspiral/widgets/drawing_tools/selection_row.dart';

import 'package:provider/provider.dart';
import 'package:inspiral/models/gears/gears.dart';

@immutable
class _RowDefinition {
  final String label;
  final Iterable<GearDefinition> gearsToShow;
  final GearDefinition activeGear;
  final void Function(GearDefinition newGear) onGearSelect;

  _RowDefinition(
      {@required this.label,
      @required this.gearsToShow,
      @required this.activeGear,
      @required this.onGearSelect});
}

class GearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rotatingGear = Provider.of<RotatingGearState>(context);
    final fixedGear = Provider.of<FixedGearState>(context);

    Iterable<GearDefinition> onlyGearsWithHoles =
        allGears.values.where((gear) => gear.holes.length > 0);

    List<_RowDefinition> rowDefs = [
      _RowDefinition(
          label: 'ROTATING',
          gearsToShow: onlyGearsWithHoles,
          activeGear: rotatingGear.definition,
          onGearSelect: (GearDefinition newGear) {
            rotatingGear.selectNewGear(newGear);
          }),
      _RowDefinition(
          label: 'FIXED',
          gearsToShow: allGears.values,
          activeGear: fixedGear.definition,
          onGearSelect: (GearDefinition newGear) {
            fixedGear.selectNewGear(newGear);
          }),
    ];

    final double padding = 2.5;

    return Padding(
        padding: EdgeInsets.all(2.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var def in rowDefs)
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: SelectionRow(
                        label: def.label,
                        children: [
                          for (var gear in def.gearsToShow)
                            GearSelectorThumbnail(
                                isActive: gear == def.activeGear,
                                assetPath: gear.thumbnailImage,
                                onGearTap: () {
                                  def.onGearSelect(gear);
                                })
                        ],
                      ))),
          ],
        ));
  }
}
