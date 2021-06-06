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

class _Triangle36noholesClipper extends CustomClipper<Rect> {
  const _Triangle36noholesClipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(135.63674926757812, 149.598237991333),
        width: 336,
        height: 336);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final triangle36Noholes = GearDefinition(
  id: 'triangle36Noholes',
  image: 'images/gears/triangle_36_noholes.png',
  thumbnailImage: 'images/gears/triangle_36_noholes_thumb.png',
  size: Size(304, 300),
  center: Offset(135.63674926757812, 149.598237991333),
  toothCount: 32,
  entitlement: Entitlement.trianglegears,
  package: Package.trianglegears,
  points: [
    ContactPoint(position: Offset(156, 0), direction: 0),
    ContactPoint(
        position: Offset(142.54346655661968, -28.232462462182852),
        direction: 0.546858423684796),
    ContactPoint(
        position: Offset(127.59437644635423, -49.87057782678295),
        direction: 0.6624271016754326),
    ContactPoint(
        position: Offset(110.24630936552339, -69.6388079259356),
        direction: 0.7780834603748774),
    ContactPoint(
        position: Offset(90.73571866251037, -87.27281270067427),
        direction: 0.8935502139248435),
    ContactPoint(
        position: Offset(69.32730121643937, -102.54284083650775),
        direction: 1.0088062327806462),
    ContactPoint(
        position: Offset(46.30663164345864, -115.25104963469134),
        direction: 1.1239915422761033),
    ContactPoint(
        position: Offset(21.976416056156395, -125.22941516704958),
        direction: 1.2393058936907977),
    ContactPoint(
        position: Offset(-3.3437669977078883, -132.3399323043072),
        direction: 1.3548517840746044),
    ContactPoint(
        position: Offset(-29.316820858082902, -136.48117640519166),
        direction: 1.4705245865022274),
    ContactPoint(
        position: Offset(-57.13573798185247, -137.47342653095018),
        direction: 1.7151503027362178),
    ContactPoint(
        position: Offset(-84.56325848762546, -126.86864743516304),
        direction: 2.2890378366918767),
    ContactPoint(
        position: Offset(-99.78094522534803, -101.5553710122114),
        direction: 2.679734160927347),
    ContactPoint(
        position: Offset(-110.12128895687806, -77.37252282266313),
        direction: 2.7953838023167488),
    ContactPoint(
        position: Offset(-117.60052364319554, -52.15797769957148),
        direction: 2.9109952585760377),
    ContactPoint(
        position: Offset(-122.12333691746298, -26.252097104657512),
        direction: 3.026380208266898),
    ContactPoint(
        position: Offset(-123.63674926757781, 0.00006379580098534044),
        direction: 3.141592883643521),
    ContactPoint(
        position: Offset(-122.12332462489314, 26.252195989223317),
        direction: 3.256805713976298),
    ContactPoint(
        position: Offset(-117.60048810368606, 52.15813542957741),
        direction: 3.37219048876422),
    ContactPoint(
        position: Offset(-110.12123007994964, 77.37271814941272),
        direction: 3.4878019116567973),
    ContactPoint(
        position: Offset(-99.78088534709124, 101.55553275425252),
        direction: 3.603451643282658),
    ContactPoint(
        position: Offset(-84.56317007098377, 126.868831598644),
        direction: 3.9941488121507756),
    ContactPoint(
        position: Offset(-57.13559929059266, 137.4735513280711),
        direction: 4.568037689009601),
    ContactPoint(
        position: Offset(-29.316701647918485, 136.48122665618143),
        direction: 4.81266175911356),
    ContactPoint(
        position: Offset(-3.343722422088031, 132.34000695430578),
        direction: 4.928333420663444),
    ContactPoint(
        position: Offset(21.976488711260124, 125.22947792476356),
        direction: 5.043880437570644),
    ContactPoint(
        position: Offset(46.306700349437335, 115.25106121823006),
        direction: 5.159194473721857),
    ContactPoint(
        position: Offset(69.32731916071985, 102.54288873644973),
        direction: 5.274379338865902),
    ContactPoint(
        position: Offset(90.7357241301275, 87.27284645104183),
        direction: 5.38963567792567),
    ContactPoint(
        position: Offset(110.24634436348093, 69.63880337952432),
        direction: 5.505102378727683),
    ContactPoint(
        position: Offset(127.59440774936611, 49.870546302240044),
        direction: 5.620758311925886),
    ContactPoint(
        position: Offset(142.5434678358281, 28.232490878533014),
        direction: 5.736327088493658),
  ],
  holes: [],
  isRing: false,
  isRound: false,
  smallestConvexDiff: 0.11518486514404547,
  biggestConvexDiff: 0.5738888768588253,
  smallestConcaveDiff: 6.283185307179586,
  biggestConcaveDiff: 0,
  ovalClipper: const _Triangle36noholesClipper(),
  pathClipper: null,
);
