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

class _Square26noholesClipper extends CustomClipper<Rect> {
  const _Square26noholesClipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(127.99999237060547, 127.99996879550235),
        width: 256,
        height: 256);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final square26Noholes = GearDefinition(
  id: 'square26Noholes',
  image: 'images/gears/square_26_noholes.png',
  thumbnailImage: 'images/gears/square_26_noholes_thumb.png',
  size: Size(256, 256),
  center: Offset(127.99999237060547, 127.99996879550235),
  toothCount: 24,
  entitlement: Entitlement.squaregears,
  package: Package.squaregears,
  points: [
    ContactPoint(
        position: Offset(115.99999999999937, 0.000003860686493436841),
        direction: 6.283184985455712),
    ContactPoint(
        position: Offset(105.39406901471325, -29.021180274915604),
        direction: 0.45811361392647054),
    ContactPoint(
        position: Offset(91.2764380441761, -52.57392834933371),
        direction: 0.6218128398919331),
    ContactPoint(
        position: Offset(73.51085487954074, -73.5108438857821),
        direction: 0.7853981899335833),
    ContactPoint(
        position: Offset(52.57395974584676, -91.27640390846356),
        direction: 0.9489837878868137),
    ContactPoint(
        position: Offset(29.021247625254148, -105.3940000971571),
        direction: 1.1126821261005624),
    ContactPoint(
        position: Offset(0.00013353768638134052, -115.99996879542891),
        direction: 1.570792828048896),
    ContactPoint(
        position: Offset(-29.021139535688473, -105.39417795287484),
        direction: 2.028908282113207),
    ContactPoint(
        position: Offset(-52.573871149504846, -91.27648132639362),
        direction: 2.1926103420878205),
    ContactPoint(
        position: Offset(-73.51078821522452, -73.51090673539701),
        direction: 2.3561938002535836),
    ContactPoint(
        position: Offset(-91.27638385310398, -52.57402055471542),
        direction: 2.5197777913091577),
    ContactPoint(
        position: Offset(-105.39412725026038, -29.0212468808875),
        direction: 2.683479230933764),
    ContactPoint(
        position: Offset(-115.99999237057872, 0.00004059451150901713),
        direction: 3.141594764899997),
    ContactPoint(
        position: Offset(-105.39402323883846, 29.02120133479933),
        direction: 3.599706806518263),
    ContactPoint(
        position: Offset(-91.27639864375006, 52.57394651038593),
        direction: 3.7634053999360235),
    ContactPoint(
        position: Offset(-73.5108209975985, 73.51085487954074),
        direction: 3.9269907904511063),
    ContactPoint(
        position: Offset(-52.57392147995745, 91.27642497452001),
        direction: 4.090576453668326),
    ContactPoint(
        position: Offset(-29.02116581763443, 105.39404186397374),
        direction: 4.254276000863224),
    ContactPoint(
        position: Offset(0.00005349773890862997, 115.99996948241939),
        direction: 4.712389623832333),
    ContactPoint(
        position: Offset(29.02121953364651, 105.39400743134725),
        direction: 5.170502697608881),
    ContactPoint(
        position: Offset(52.573987337820874, 91.27639646835058),
        direction: 5.334201219350453),
    ContactPoint(
        position: Offset(73.51087036349638, 73.51083984591826),
        direction: 5.497787143782138),
    ContactPoint(
        position: Offset(91.27645457525591, 52.5739303886983),
        direction: 5.6613726493005085),
    ContactPoint(
        position: Offset(105.39405536112109, 29.021199907790844),
        direction: 5.825071995716263),
  ],
  holes: [],
  isRing: false,
  isRound: false,
  smallestConvexDiff: 0.16358345816576314,
  biggestConvexDiff: 0.4581155339662333,
  smallestConcaveDiff: 6.283185307179586,
  biggestConcaveDiff: 0,
  ovalClipper: const _Square26noholesClipper(),
  pathClipper: null,
);
