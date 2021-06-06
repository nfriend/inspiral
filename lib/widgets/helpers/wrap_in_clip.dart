import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';

/// Conditionally wraps the provided child in a `ClipOval` or a `ClipPath`,
/// according to what is specified in the gear definition. If no clip is
/// provided, the child is returned unaltered.
Widget wrapInClip({required GearDefinition definition, required Widget child}) {
  if (definition.ovalClipper != null) {
    return ClipOval(
      clipper: definition.ovalClipper,
      child: child,
    );
  } else if (definition.pathClipper != null) {
    return ClipPath(
      clipper: definition.pathClipper,
      child: child,
    );
  } else {
    return child;
  }
}
