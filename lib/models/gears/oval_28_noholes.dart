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

class _Oval28noholesClipper extends CustomClipper<Rect> {
  const _Oval28noholesClipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(135.99999986513285, 98.66666661835467),
        width: 272,
        height: 197.33333333333331);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final oval28Noholes = GearDefinition(
  id: 'oval28Noholes',
  image: 'images/gears/oval_28_noholes.png',
  thumbnailImage: 'images/gears/oval_28_noholes_thumb.png',
  size: Size(272, 196),
  center: Offset(136, 98),
  toothCount: 24,
  entitlement: Entitlement.ovalgears,
  package: Package.ovalgears,
  points: [
    ContactPoint(
        position: Offset(123.99999986513285, 0.6666640752231672), direction: 0),
    ContactPoint(
        position: Offset(117.03322567269402, -28.275968992069178),
        direction: 0.4464170608820268),
    ContactPoint(
        position: Offset(99.63953129239945, -51.21940708835071),
        direction: 0.8013659591763869),
    ContactPoint(
        position: Offset(77.15898745467135, -67.39018671365277),
        direction: 1.0581832229167443),
    ContactPoint(
        position: Offset(52.340754688604626, -78.0251791708145),
        direction: 1.2548076897451814),
    ContactPoint(
        position: Offset(26.39565877722849, -84.058075169204),
        direction: 1.4201173152560145),
    ContactPoint(
        position: Offset(0.0000417055412612186, -85.99999999999943),
        direction: 1.5707960190085837),
    ContactPoint(
        position: Offset(-26.39556963072102, -84.05809114276873),
        direction: 1.7214748753460292),
    ContactPoint(
        position: Offset(-52.340695955354384, -78.02520055111155),
        direction: 1.88678447311311),
    ContactPoint(
        position: Offset(-77.1589324758604, -67.39021826833901),
        direction: 2.0834092544581306),
    ContactPoint(
        position: Offset(-99.63950310604595, -51.21942398527091),
        direction: 2.3402262697395617),
    ContactPoint(
        position: Offset(-117.03319935207134, -28.276001096803512),
        direction: 2.695175798504284),
    ContactPoint(
        position: Offset(-123.99999999999969, 0.6667278796733832),
        direction: 3.1415928843642904),
    ContactPoint(
        position: Offset(-117.033181150435, 29.60937106444784),
        direction: 3.588010905046743),
    ContactPoint(
        position: Offset(-99.63947282892957, 52.55278045308256),
        direction: 3.942959230821339),
    ContactPoint(
        position: Offset(-77.15889306349669, 68.72358551745204),
        direction: 4.199776538501343),
    ContactPoint(
        position: Offset(-52.34066132040826, 79.3585305245383),
        direction: 4.396401195052981),
    ContactPoint(
        position: Offset(-26.395531934195425, 85.39143805989173),
        direction: 4.56171039386611),
    ContactPoint(
        position: Offset(0.00006443846394212142, 87.33332819875312),
        direction: 4.712389911015471),
    ContactPoint(
        position: Offset(26.39564699222417, 85.3913886737524),
        direction: 4.863069570861927),
    ContactPoint(
        position: Offset(52.340715833017, 79.35843852174094),
        direction: 5.028376886406913),
    ContactPoint(
        position: Offset(77.15895161054102, 68.72354743022305),
        direction: 5.225000115804626),
    ContactPoint(
        position: Offset(99.63948727678803, 52.5527812171084),
        direction: 5.4818195522746915),
    ContactPoint(
        position: Offset(117.03322343655584, 29.609294184940506),
        direction: 5.836767814680674),
  ],
  holes: [],
  isRing: false,
  isRound: false,
  smallestConvexDiff: 0.1506787037525692,
  biggestConvexDiff: 0.4464180206824526,
  smallestConcaveDiff: 6.283185307179586,
  biggestConcaveDiff: 0,
  ovalClipper: const _Oval28noholesClipper(),
  pathClipper: null,
);
