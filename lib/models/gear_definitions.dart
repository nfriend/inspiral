import 'package:flutter/material.dart';
import 'package:inspiral/models/models.dart';

class GearDefinitions {
  static final circle24 =
      GearDefinition(image: 'images/gear_24.png', size: Size(116, 116));
  static final circle84 =
      GearDefinition(image: 'images/gear_84.png', size: Size(356, 356));

  static final defaultRotatingGear = GearDefinitions.circle24;
  static final defaultFixedGear = GearDefinitions.circle84;
}
