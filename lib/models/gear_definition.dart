import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

@immutable
class GearDefinition {
  /// The asset path to the gear's image
  final String image;

  /// The size of the gear, in logical pixels
  final Size size;

  final double Function(double angle) angleToTooth;

  final ContactPoint Function(double tooth) toothToContactPoint;

  GearDefinition(
      {@required this.image,
      @required this.size,
      @required this.angleToTooth,
      @required this.toothToContactPoint});

  ContactPoint angleToContactPoint(double angle) {
    return toothToContactPoint(angleToTooth(angle));
  }

  @override
  int get hashCode =>
      image.hashCode ^
      size.hashCode ^
      angleToTooth.hashCode ^
      toothToContactPoint.hashCode;

  @override
  bool operator ==(Object other) =>
      other is GearDefinition &&
      other.image == image &&
      other.size == size &&
      other.angleToTooth == angleToTooth &&
      other.toothToContactPoint == toothToContactPoint;
}
