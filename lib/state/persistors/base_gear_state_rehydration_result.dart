import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';

class BaseGearStateRehydrationResult {
  final GearDefinition definition;
  final bool isVisible;

  BaseGearStateRehydrationResult(
      {@required this.definition, @required this.isVisible});
}
