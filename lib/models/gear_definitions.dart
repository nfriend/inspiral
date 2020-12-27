import 'package:inspiral/models/gear_definition.dart';

class GearDefinitions {
  static final circle24 = GearDefinition(image: 'images/gear_24.png');
  static final circle84 = GearDefinition(image: 'images/gear_84.png');

  static final defaultRotatingGear = GearDefinitions.circle24;
  static final defaultFixedGear = GearDefinitions.circle84;
}
