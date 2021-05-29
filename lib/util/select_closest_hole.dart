import 'package:inspiral/models/models.dart';

/// Selects the hole in `availableHoles` that is closest to `currentHole`
GearHole selectClosetHole(
    {required GearHole currentHole, required Iterable<GearHole> availableHoles}) {
  return availableHoles.fold(availableHoles.first, (prev, curr) {
    return (curr.distance - currentHole.distance).abs() <
            (prev.distance - currentHole.distance).abs()
        ? curr
        : prev;
  });
}
