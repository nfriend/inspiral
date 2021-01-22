import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';

/// Returns a circle gear's size based on its tooth cound.
/// TODO: This will only work for round gears. How will
/// we get the size of non-round gears? Some ideas:
/// 1. Load the image and read the file's dimensions
/// 2. Embed the file size in the file name
/// 3. Embed the info in the JSON asset somehow
Size toothCountToSize({@required toothCount}) {
  double diameter = (toothCount + toothLength + imagePadding) * 2 * scaleFactor;
  return Size(diameter, diameter);
}

/// Loads a list of ContactPoints from a JSON asset
Future<List<ContactPoint>> loadContactPoints(
    {BuildContext context, String jsonFile}) async {
  return await DefaultAssetBundle.of(context)
      .loadStructuredData<List<ContactPoint>>(jsonFile, (jsonString) async {
    List rawResult = json.decode(jsonString);

    List<ContactPoint> points = rawResult.map((item) {
      return ContactPoint(
          position:
              Offset(item['p']['x'].toDouble(), item['p']['y'].toDouble()),
          direction: item['d'].toDouble());
    }).toList();

    return points;
  });
}

enum Gear { circle24, circle84, defaultRotating, defaultFixed }

class GearDefinitions {
  static final Map<Gear, GearDefinition> _gears = HashMap();

  static bool _hasBeenInitialized = false;

  static Future<void> loadGearDefinitions(BuildContext context) async {
    _gears[Gear.circle24] = GearDefinition(
        image: "images/gear_24.png",
        size: toothCountToSize(toothCount: 24),
        toothCount: 24,
        points: await loadContactPoints(
            context: context, jsonFile: "gears/circle_24.json"));

    _gears[Gear.circle84] = GearDefinition(
        image: "images/gear_84.png",
        size: toothCountToSize(toothCount: 84),
        toothCount: 84,
        points: await loadContactPoints(
            context: context, jsonFile: "gears/circle_84.json"));

    _gears[Gear.defaultRotating] = _gears[Gear.circle24];
    _gears[Gear.defaultFixed] = _gears[Gear.circle84];

    _hasBeenInitialized = true;
  }

  static GearDefinition getGearDefinition(Gear gear) {
    if (!_hasBeenInitialized) {
      throw ('the loadGearDefinitions() method must be called and completed before calling getGearDefinition()');
    }

    return _gears[gear];
  }
}
