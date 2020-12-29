import 'package:flutter/material.dart';

@immutable
class GearDefinition {
  /// The asset path to the gear's image
  final String image;

  /// The size of the gear, in logical pixels
  final Size size;

  GearDefinition({@required this.image, @required this.size});

  @override
  int get hashCode => image.hashCode ^ size.hashCode;

  @override
  bool operator ==(Object other) =>
      other is GearDefinition && other.image == image && other.size == size;
}
