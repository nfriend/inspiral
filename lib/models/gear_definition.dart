import 'package:flutter/material.dart';

@immutable
class GearDefinition {
  final String image;

  GearDefinition({@required this.image});

  @override
  int get hashCode => image.hashCode;

  @override
  bool operator ==(Object other) =>
      other is GearDefinition && other.image == image;
}
