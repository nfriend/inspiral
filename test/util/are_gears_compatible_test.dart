import 'package:flutter_test/flutter_test.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/gears/gears.dart';
import 'package:inspiral/util/are_gears_compatible.dart';

class TestCase {
  final GearDefinition fixedGear;
  final GearDefinition rotatingGear;
  final bool areCompatible;

  TestCase(
      {required this.fixedGear,
      required this.rotatingGear,
      required this.areCompatible});
}

void main() {
  group('are_gears_compatible', () {
    test('correctly determines if two gears are compatible', () {
      var testCases = [
        TestCase(
            fixedGear: circle96Ring,
            rotatingGear: circle84,
            areCompatible: true),
        TestCase(
            fixedGear: circle96Ring,
            rotatingGear: circle100,
            areCompatible: false),
        TestCase(
            fixedGear: circle96Ring,
            rotatingGear: beam2050,
            areCompatible: false),
        TestCase(
            fixedGear: heartRing84,
            rotatingGear: circle24,
            areCompatible: true),
        TestCase(
            fixedGear: heartRing84,
            rotatingGear: circle30,
            areCompatible: false),
        TestCase(
            fixedGear: heartRing144,
            rotatingGear: circle32,
            areCompatible: true),
        TestCase(
            fixedGear: heartRing144,
            rotatingGear: circle40,
            areCompatible: false),
        TestCase(
            fixedGear: letterC, rotatingGear: circle100, areCompatible: true),
        TestCase(
            fixedGear: letterC, rotatingGear: circle144, areCompatible: false),
        TestCase(
            fixedGear: beam20100, rotatingGear: beam20100, areCompatible: true),
        TestCase(
            fixedGear: waveCircleRing,
            rotatingGear: circle45,
            areCompatible: false),
        TestCase(
            fixedGear: waveCircleRing,
            rotatingGear: circle32,
            areCompatible: true),
        TestCase(
            fixedGear: waveCircle,
            rotatingGear: circle60,
            areCompatible: false),
        TestCase(
            fixedGear: waveCircle, rotatingGear: circle56, areCompatible: true)
      ];

      for (var testCase in testCases) {
        expect(
            areGearsCompatible(
                fixedGear: testCase.fixedGear,
                rotatingGear: testCase.rotatingGear),
            testCase.areCompatible,
            reason:
                'Fixed gear ${testCase.fixedGear.id} should ${testCase.areCompatible ? '' : 'not '}be compatible with rotating gear ${testCase.rotatingGear.id}');
      }
    });
  });
}
