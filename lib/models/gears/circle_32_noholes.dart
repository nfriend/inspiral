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

class _Circle32noholesClipper extends CustomClipper<Rect> {
  const _Circle32noholesClipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(151.99999980675986, 151.99999995168304),
        width: 304,
        height: 304);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle32Noholes = GearDefinition(
  id: 'circle32Noholes',
  image: 'images/gears/circle_32_noholes.png',
  thumbnailImage: 'images/gears/circle_32_noholes_thumb.png',
  size: Size(304, 304),
  center: Offset(152, 152),
  toothCount: 32,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(139.99999980675986, -4.831694866425096e-8),
        direction: 0),
    ContactPoint(
        position: Offset(137.33514411755758, -27.311129671200003),
        direction: 0.19568957200494363),
    ContactPoint(
        position: Offset(129.3734565763229, -53.58963513605643),
        direction: 0.3929135624629385),
    ContactPoint(
        position: Offset(116.41389867022133, -77.79155351409555),
        direction: 0.5896983922372767),
    ContactPoint(
        position: Offset(98.99495204592867, -98.99495488745805),
        direction: 0.7853985413854776),
    ContactPoint(
        position: Offset(77.79152030403132, -116.41390562864969),
        direction: 0.9810977978157052),
    ContactPoint(
        position: Offset(53.58961793244026, -129.3734746899631),
        direction: 1.1778829179794554),
    ContactPoint(
        position: Offset(27.31111158988283, -137.33513628766204),
        direction: 1.3751069740558144),
    ContactPoint(
        position: Offset(0.00001569553353138113, -139.99999999999997),
        direction: 1.5707962742961792),
    ContactPoint(
        position: Offset(-27.311102507652876, -137.33513927486675),
        direction: 1.766485523275298),
    ContactPoint(
        position: Offset(-53.58961540387291, -129.37347780549558),
        direction: 1.9637094726516002),
    ContactPoint(
        position: Offset(-77.79151677807418, -116.41392095283855),
        direction: 2.160494845973906),
    ContactPoint(
        position: Offset(-98.9949351916863, -98.99496831348443),
        direction: 2.3561943281975277),
    ContactPoint(
        position: Offset(-116.41389619142622, -77.79155398155801),
        direction: 2.551893831990142),
    ContactPoint(
        position: Offset(-129.37344849174525, -53.58967301277476),
        direction: 2.7486791155057855),
    ContactPoint(
        position: Offset(-137.33511846193613, -27.31118816281244),
        direction: 2.945902649517422),
    ContactPoint(
        position: Offset(-139.9999999999976, -0.00011441965571071048),
        direction: 3.141592023605183),
    ContactPoint(
        position: Offset(-137.33515318639692, 27.31102669607815),
        direction: 3.3372812634177444),
    ContactPoint(
        position: Offset(-129.37350703128592, 53.58953313087376),
        direction: 3.5345052818821694),
    ContactPoint(
        position: Offset(-116.41396884914654, 77.79143540451902),
        direction: 3.7312903051776227),
    ContactPoint(
        position: Offset(-98.99505391616061, 98.99485330706062),
        direction: 3.926989575026574),
    ContactPoint(
        position: Offset(-77.79165577021335, 116.41384342141083),
        direction: 4.122689146983253),
    ContactPoint(
        position: Offset(-53.58979120850412, 129.37340956071742),
        direction: 4.319475116662157),
    ContactPoint(
        position: Offset(-27.311189958138662, 137.33512766838655),
        direction: 4.516698836102652),
    ContactPoint(
        position: Offset(-0.00007618852093081453, 139.99999995168082),
        direction: 4.712388369490522),
    ContactPoint(
        position: Offset(27.31102834382481, 137.33516141097448),
        direction: 4.9080777425085165),
    ContactPoint(
        position: Offset(53.589537943950226, 129.37350473481632),
        direction: 5.105302055925026),
    ContactPoint(
        position: Offset(77.79148291638603, 116.4139330170892),
        direction: 5.3020868205181335),
    ContactPoint(
        position: Offset(98.99490764413662, 98.99500300731431),
        direction: 5.497786927789294),
    ContactPoint(
        position: Offset(116.41391025086884, 77.79152458217537),
        direction: 5.693486363771747),
    ContactPoint(
        position: Offset(129.37342668364676, 53.58970982563548),
        direction: 5.890271880725211),
    ContactPoint(
        position: Offset(137.33514341215493, 27.311117874345303),
        direction: 6.087495432857195),
  ],
  holes: [],
  isRing: false,
  isRound: true,
  smallestConvexDiff: 0.1956892398125616,
  biggestConvexDiff: 0.19722431341650992,
  smallestConcaveDiff: 6.283185307179586,
  biggestConcaveDiff: 0,
  ovalClipper: const _Circle32noholesClipper(),
  pathClipper: null,
);
