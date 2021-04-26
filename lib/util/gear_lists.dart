import 'package:inspiral/models/gears/gears.dart';

/// All gears that have holes. In other words, all the rotating gears.
final onlyGearsWithHoles =
    allGears.values.where((gear) => gear.holes.isNotEmpty).toList();

/// All gears that have no holes. In other words, all the fixed gears.
final onlyGearsWithoutHoles =
    allGears.values.where((gear) => gear.holes.isEmpty).toList();
