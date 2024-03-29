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

class _Circle48ringClipper extends CustomClipper<Path> {
  const _Circle48ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(256, 255.99999990338065), width: 332, height: 332));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 512);
    clip.lineTo(512, 512);
    clip.lineTo(512, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle48Ring = GearDefinition(
  id: 'circle48Ring',
  image: 'images/gears/circle_48_ring.png',
  thumbnailImage: 'images/gears/circle_48_ring_thumb.png',
  size: Size(512, 512),
  center: Offset(256, 256),
  toothCount: 48,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(178.47976841011996, 23.51114421198911),
        direction: 3.0116308576625803),
    ContactPoint(
        position: Offset(173.9105387445725, 46.6075465623162),
        direction: 2.880353699665834),
    ContactPoint(
        position: Offset(166.34669395414764, 68.89707977653099),
        direction: 2.7485901039669494),
    ContactPoint(
        position: Offset(155.91892534310148, 90.00433646657586),
        direction: 2.6172040595798003),
    ContactPoint(
        position: Offset(142.81748527133206, 109.57457727369777),
        direction: 2.486473715988047),
    ContactPoint(
        position: Offset(127.27918395779268, 127.27930593148587),
        direction: 2.356194490192345),
    ContactPoint(
        position: Offset(109.57455110983888, 142.8175124215061),
        direction: 2.225914817020554),
    ContactPoint(
        position: Offset(90.00434520346411, 155.91892024892223),
        direction: 2.0951840890152678),
    ContactPoint(
        position: Offset(68.89702423404427, 166.34669162049394),
        direction: 1.9637983896363576),
    ContactPoint(
        position: Offset(46.607406595535416, 173.9105698965426),
        direction: 1.8320355165796656),
    ContactPoint(
        position: Offset(23.511132477402096, 178.47976786552135),
        direction: 1.700757834660961),
    ContactPoint(
        position: Offset(-0.000015258789061765212, 179.99999990338068),
        direction: 1.5707963267948966),
    ContactPoint(
        position: Offset(-23.51120830197067, 178.47976792686805),
        direction: 1.4408347794814391),
    ContactPoint(
        position: Offset(-46.6074132131449, 173.91057220675557),
        direction: 1.3095563916212072),
    ContactPoint(
        position: Offset(-68.89706829910384, 166.34666181237034),
        direction: 1.1777941095752151),
    ContactPoint(
        position: Offset(-90.004409843435, 155.91889205917315),
        direction: 1.0464081771324931),
    ContactPoint(
        position: Offset(-109.57449853405333, 142.81751764558834),
        direction: 0.9156771220223483),
    ContactPoint(
        position: Offset(-127.27923537514108, 127.27924307004606),
        direction: 0.7853983786270522),
    ContactPoint(
        position: Offset(-142.81754180353195, 109.57449158180104),
        direction: 0.655118321689856),
    ContactPoint(
        position: Offset(-155.9188862844492, 90.00434134038474),
        direction: 0.5243881248134787),
    ContactPoint(
        position: Offset(-166.34671360465555, 68.89701044832891),
        direction: 0.3930032977443769),
    ContactPoint(
        position: Offset(-173.91058578056894, 46.60744574070742),
        direction: 0.2612384372335068),
    ContactPoint(
        position: Offset(-178.47973647168777, 23.511166693656804),
        direction: 0.12996118890154307),
    ContactPoint(
        position: Offset(-180, 0.00003073483900034296),
        direction: 6.283185281022901),
    ContactPoint(
        position: Offset(-178.47973520568533, -23.51112076392935),
        direction: 6.153224089149148),
    ContactPoint(
        position: Offset(-173.91057493381928, -46.607458958412266),
        direction: 6.021946677213237),
    ContactPoint(
        position: Offset(-166.34669862571087, -68.89697642036134),
        direction: 5.890182363581405),
    ContactPoint(
        position: Offset(-155.91892180628736, -90.00428936884022),
        direction: 5.758797301833802),
    ContactPoint(
        position: Offset(-142.81753043442865, -109.57446382422238),
        direction: 5.628066453460624),
    ContactPoint(
        position: Offset(-127.27920775911693, -127.27922891763866),
        direction: 5.4977870361674865),
    ContactPoint(
        position: Offset(-109.57444249892171, -142.81754451481993),
        direction: 5.367507659707541),
    ContactPoint(
        position: Offset(-90.00428995647869, -155.91891578508404),
        direction: 5.236776919857701),
    ContactPoint(
        position: Offset(-68.89695405226675, -166.3467099107535),
        direction: 5.105391868349175),
    ContactPoint(
        position: Offset(-46.607385518151766, -173.9105971298639),
        direction: 4.973627355857611),
    ContactPoint(
        position: Offset(-23.511047905556477, -178.47974735763066),
        direction: 4.842349901562436),
    ContactPoint(
        position: Offset(0.000040697211486600686, -180.00000000000108),
        direction: 4.712388557121715),
    ContactPoint(
        position: Offset(23.51120525427707, -178.4797275104396),
        direction: 4.582427176936748),
    ContactPoint(
        position: Offset(46.60758509607705, -173.91054032648898),
        direction: 4.4511493933785165),
    ContactPoint(
        position: Offset(68.89715513898578, -166.34661878683548),
        direction: 4.31938496150895),
    ContactPoint(
        position: Offset(90.00443289963711, -155.91882349067856),
        direction: 4.188000846897252),
    ContactPoint(
        position: Offset(109.57454996143981, -142.8174982382852),
        direction: 4.057270369474476),
    ContactPoint(
        position: Offset(127.27927003167522, -127.27920479205646),
        direction: 3.9269901712981525),
    ContactPoint(
        position: Offset(142.81754385340165, -109.57445858944601),
        direction: 3.796711255659759),
    ContactPoint(
        position: Offset(155.9189226733706, -90.0043260167145),
        direction: 3.665980803252197),
    ContactPoint(
        position: Offset(166.34669278856222, -68.89702174617298),
        direction: 3.534594949579911),
    ContactPoint(
        position: Offset(173.91056974949126, -46.607422862377206),
        direction: 3.402831764754246),
    ContactPoint(
        position: Offset(178.47976796214067, -23.511117315232383),
        direction: 3.2715541614558576),
    ContactPoint(
        position: Offset(180, -9.66193468828497e-8),
        direction: 3.141592653589793),
  ],
  holes: [],
  isRing: true,
  isRound: true,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.1299611918737531,
  biggestConcaveDiff: 0.1317648605108701,
  ovalClipper: null,
  pathClipper: const _Circle48ringClipper(),
);
