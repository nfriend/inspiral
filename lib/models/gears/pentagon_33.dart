// THIS FILE IS AUTO-GENERATED
// ---------------------------
//
// Do not edit by hand.
//
// This file is generated by the Node application
// in the `gear_generator` directory.

import 'dart:ui';
import 'package:inspiral/models/contact_point.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/models.dart';
import 'package:flutter/material.dart';

class _Pentagon33Clipper extends CustomClipper<Rect> {
  const _Pentagon33Clipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(146.62504386901855, 150.297776222229),
        width: 312,
        height: 312);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final pentagon33 = GearDefinition(
  id: 'pentagon33',
  image: 'images/gears/pentagon_33.png',
  thumbnailImage: 'images/gears/pentagon_33_thumb.png',
  size: Size(304, 300),
  center: Offset(146.62504386901855, 150.297776222229),
  toothCount: 32,
  entitlement: Entitlement.pentagongears,
  package: Package.pentagongears,
  points: [
    ContactPoint(
        position: Offset(143.99999999999756, 0.000007671528183646895),
        direction: 6.283184667885571),
    ContactPoint(
        position: Offset(136.18125632542328, -27.99968580927976),
        direction: 0.3514875063598),
    ContactPoint(
        position: Offset(125.54842042249307, -52.17109749217043),
        direction: 0.4773384539236112),
    ContactPoint(
        position: Offset(111.96610361867111, -74.81654392877365),
        direction: 0.6031584891694539),
    ContactPoint(
        position: Offset(95.64990852298331, -95.57882903278842),
        direction: 0.7289651525822833),
    ContactPoint(
        position: Offset(76.8570645909369, -114.12984069815607),
        direction: 0.8548106577542569),
    ContactPoint(
        position: Offset(54.50542363316648, -130.97101633016425),
        direction: 1.1134164475840844),
    ContactPoint(
        position: Offset(27.06616392144587, -138.23747213717377),
        direction: 1.4705012114744234),
    ContactPoint(
        position: Offset(-0.35307840450310857, -136.97946548205317),
        direction: 1.6836357646937365),
    ContactPoint(
        position: Offset(-26.3527606198611, -132.36176985782765),
        direction: 1.8094731429640083),
    ContactPoint(
        position: Offset(-51.56715626607533, -124.51837919273787),
        direction: 1.935276120390789),
    ContactPoint(
        position: Offset(-75.5984519977139, -113.57321596681852),
        direction: 2.061104960421517),
    ContactPoint(
        position: Offset(-98.48000366362336, -99.3912741789193),
        direction: 2.229886114381534),
    ContactPoint(
        position: Offset(-118.8741257739745, -79.31800251494556),
        direction: 2.585081912403303),
    ContactPoint(
        position: Offset(-128.01104911387148, -52.29190921792194),
        direction: 2.8899299651469303),
    ContactPoint(
        position: Offset(-132.96518169450357, -26.354050687964175),
        direction: 3.015779630789072),
    ContactPoint(
        position: Offset(-134.62504386901855, 0.000015719347948058098),
        direction: 3.1415926919697004),
    ContactPoint(
        position: Offset(-132.9651796120933, 26.35404444266245),
        direction: 3.2674057926505045),
    ContactPoint(
        position: Offset(-128.01105211147905, 52.29187053972674),
        direction: 3.3932552963242846),
    ContactPoint(
        position: Offset(-118.8741431698958, 79.31792510292131),
        direction: 3.6981036594298162),
    ContactPoint(
        position: Offset(-98.47997542564127, 99.3912703176338),
        direction: 4.053298148272624),
    ContactPoint(
        position: Offset(-75.59850961750358, 113.57317175576408),
        direction: 4.22207994869189),
    ContactPoint(
        position: Offset(-51.567216794246654, 124.51835268328493),
        direction: 4.347909232008023),
    ContactPoint(
        position: Offset(-26.352732133149694, 132.36175596124147),
        direction: 4.473712644371155),
    ContactPoint(
        position: Offset(-0.3530330191273303, 136.97944016537633),
        direction: 4.599549509694693),
    ContactPoint(
        position: Offset(27.066153658742152, 138.23745695747022),
        direction: 4.812683236160385),
    ContactPoint(
        position: Offset(54.50545321618772, 130.97103490995548),
        direction: 5.169768772793626),
    ContactPoint(
        position: Offset(76.8570886106016, 114.12981400278431),
        direction: 5.428375617119034),
    ContactPoint(
        position: Offset(95.6499074755211, 95.57881113219888),
        direction: 5.554220023552783),
    ContactPoint(
        position: Offset(111.96607096928432, 74.81658898547627),
        direction: 5.680026504829367),
    ContactPoint(
        position: Offset(125.54840341396854, 52.171131392626556),
        direction: 5.805846535872601),
    ContactPoint(
        position: Offset(136.1812254903636, 27.99976296896932),
        direction: 5.931697723976347),
  ],
  holes: [
    GearHole(name: '0', angle: 0, distance: 0),
    GearHole(name: '8', angle: 1.5707963267948966, distance: 8),
    GearHole(name: '9', angle: 2.356194490192345, distance: 9.000000000000002),
    GearHole(name: '10', angle: -3.141592653589793, distance: 10),
    GearHole(
        name: '11', angle: -2.3561944901923453, distance: 11.000000000000002),
    GearHole(name: '12', angle: -1.5707963267948966, distance: 12),
    GearHole(name: '13', angle: -0.7853981633974486, distance: 13),
    GearHole(name: '14', angle: 0, distance: 14),
    GearHole(
        name: '15', angle: 0.7853981633974482, distance: 14.999999999999998),
    GearHole(name: '16', angle: 1.5707963267948966, distance: 16),
    GearHole(name: '17', angle: 2.356194490192345, distance: 17),
    GearHole(name: '18', angle: -3.141592653589793, distance: 18),
    GearHole(
        name: '19', angle: -2.3561944901923453, distance: 18.999999999999996),
    GearHole(name: '20', angle: -1.570796326794897, distance: 20),
    GearHole(name: '21', angle: -0.7853981633974487, distance: 21),
    GearHole(name: '22', angle: -3.2297397080004555e-16, distance: 22),
    GearHole(name: '23', angle: 0.7853981633974481, distance: 23),
    GearHole(name: '24', angle: 1.5707963267948966, distance: 24),
    GearHole(
        name: '25', angle: 2.356194490192345, distance: 24.999999999999996),
    GearHole(name: '26', angle: -3.141592653589793, distance: 26),
    GearHole(
        name: '27', angle: -2.356194490192345, distance: 27.000000000000004),
  ],
  isRing: false,
  isRound: false,
  smallestConvexDiff: 0.1258029774267806,
  biggestConvexDiff: 0.3570855366332406,
  smallestConcaveDiff: 6.283185307179586,
  biggestConcaveDiff: 0,
  ovalClipper: const _Pentagon33Clipper(),
  pathClipper: null,
);
