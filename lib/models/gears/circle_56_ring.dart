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

class _Circle56ringClipper extends CustomClipper<Path> {
  const _Circle56ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(288, 287.9999999516903), width: 396, height: 396));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 576);
    clip.lineTo(576, 576);
    clip.lineTo(576, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle56Ring = GearDefinition(
  id: 'circle56Ring',
  image: 'images/gears/circle_56_ring.png',
  thumbnailImage: 'images/gears/circle_56_ring_thumb.png',
  size: Size(576, 576),
  center: Offset(288, 288),
  toothCount: 56,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(210.68518695511366, 23.752774559879985),
        direction: 3.030356774260857),
    ContactPoint(
        position: Offset(206.7297472664555, 47.19702664531652),
        direction: 2.91799904252921),
    ContactPoint(
        position: Offset(200.16068377279714, 70.03915702370331),
        direction: 2.8050449303668072),
    ContactPoint(
        position: Offset(191.05647184615597, 91.99571016029094),
        direction: 2.6921795714534182),
    ContactPoint(
        position: Offset(179.53803371298977, 112.79397471734418),
        direction: 2.57975423741584),
    ContactPoint(
        position: Offset(165.76092037478236, 132.17715525090824),
        direction: 2.4678254815757996),
    ContactPoint(
        position: Offset(149.90662536404267, 149.90662531573298),
        direction: 2.356194490192345),
    ContactPoint(
        position: Offset(132.1771283053241, 165.76094803072738),
        direction: 2.2445631230583487),
    ContactPoint(
        position: Offset(112.79379088869794, 179.53815622065423),
        direction: 2.1326348189375803),
    ContactPoint(
        position: Offset(91.9958361817527, 191.05640888022882),
        direction: 2.020209047839016),
    ContactPoint(
        position: Offset(70.03924699411692, 200.1606537773975),
        direction: 1.9073441939799824),
    ContactPoint(
        position: Offset(47.19699617604809, 206.7297472181458),
        direction: 1.7943899378554793),
    ContactPoint(
        position: Offset(23.752865758270033, 210.68515643420108),
        direction: 1.682032239886997),
    ContactPoint(
        position: Offset(-0.000022558218975607676, 211.99999995169253),
        direction: 1.5707969350807227),
    ContactPoint(
        position: Offset(-23.75278500119529, 210.6851857459415),
        direction: 1.4595613189356982),
    ContactPoint(
        position: Offset(-47.196890153711585, 206.7298080738443),
        direction: 1.3472027831787923),
    ContactPoint(
        position: Offset(-70.03917492867879, 200.16068281560155),
        direction: 1.2342488329284542),
    ContactPoint(
        position: Offset(-91.99569036955398, 191.05650452462766),
        direction: 1.1213828208912036),
    ContactPoint(
        position: Offset(-112.7938109659156, 179.53809695503992),
        direction: 1.008957557854953),
    ContactPoint(
        position: Offset(-132.17716952736546, 165.76090896667677),
        direction: 0.8970306720086967),
    ContactPoint(
        position: Offset(-149.9066198893079, 149.90666130804942),
        direction: 0.7853975181935606),
    ContactPoint(
        position: Offset(-165.76095799894767, 132.1770739088045),
        direction: 0.6737660831965506),
    ContactPoint(
        position: Offset(-179.53810925842967, 112.79382331847566),
        direction: 0.5618382990903559),
    ContactPoint(
        position: Offset(-191.0564180603155, 91.9957640745846),
        direction: 0.4494137409615515),
    ContactPoint(
        position: Offset(-200.16068693462174, 70.0392259095681),
        direction: 0.33654972439449704),
    ContactPoint(
        position: Offset(-206.72985040431288, 47.19693237543396),
        direction: 0.22359384327001308),
    ContactPoint(
        position: Offset(-210.68518484801564, 23.7529176292914),
        direction: 0.11123411852182308),
    ContactPoint(
        position: Offset(-212, 0.000029927515249994485),
        direction: 4.514610374428685e-8),
    ContactPoint(
        position: Offset(-210.68518684339693, -23.752889622004002),
        direction: 6.1719513910478465),
    ContactPoint(
        position: Offset(-206.72986281914274, -47.196854006123395),
        direction: 6.059591278290205),
    ContactPoint(
        position: Offset(-200.16068096542045, -70.03918638802195),
        direction: 5.94663612646938),
    ContactPoint(
        position: Offset(-191.05645621990502, -91.99569548049516),
        direction: 5.833771563797882),
    ContactPoint(
        position: Offset(-179.53810239239505, -112.7937840555035),
        direction: 5.7213468886820475),
    ContactPoint(
        position: Offset(-165.76090813939553, -132.1771325253822),
        direction: 5.609419769338466),
    ContactPoint(
        position: Offset(-149.90660828034007, -149.9066730136335),
        direction: 5.497787358850285),
    ContactPoint(
        position: Offset(-132.17714079832254, -165.7609152647213),
        direction: 5.386154444449405),
    ContactPoint(
        position: Offset(-112.79382297694208, -179.5380790345728),
        direction: 5.2742273178631045),
    ContactPoint(
        position: Offset(-91.9956946134371, -191.056464292518),
        direction: 5.161802799517349),
    ContactPoint(
        position: Offset(-70.03920058454993, -200.16067373907566),
        direction: 5.048938250612818),
    ContactPoint(
        position: Offset(-47.196929935076035, -206.7298486343502),
        direction: 4.935983036338031),
    ContactPoint(
        position: Offset(-23.752857298539425, -210.68519126034437),
        direction: 4.823623043891962),
    ContactPoint(
        position: Offset(0.000013975687712458037, -212.00000000000006),
        direction: 4.712388873459577),
    ContactPoint(
        position: Offset(23.752882780208907, -210.6851864584138),
        direction: 4.601154494608678),
    ContactPoint(
        position: Offset(47.1970192373801, -206.7298210126975),
        direction: 4.488794732107944),
    ContactPoint(
        position: Offset(70.03922644841485, -200.1606601084315),
        direction: 4.375839299297854),
    ContactPoint(
        position: Offset(91.99576761500045, -191.05642023896786),
        direction: 4.262975562514283),
    ContactPoint(
        position: Offset(112.79388379563126, -179.5380715414472),
        direction: 4.150550621590655),
    ContactPoint(
        position: Offset(132.17713121723696, -165.76092291428205),
        direction: 4.038622494635023),
    ContactPoint(
        position: Offset(149.90665861898862, -149.90660741619638),
        direction: 3.926991139589081),
    ContactPoint(
        position: Offset(165.76096933971388, -132.17710943033268),
        direction: 3.815358213490183),
    ContactPoint(
        position: Offset(179.5380948992703, -112.79379146842963),
        direction: 3.7034310934030836),
    ContactPoint(
        position: Offset(191.05647715533155, -91.9957373965783),
        direction: 3.5910067541266755),
    ContactPoint(
        position: Offset(200.16068226684718, -70.03922245995021),
        direction: 3.4781399967875752),
    ContactPoint(
        position: Offset(206.72977796349153, -47.196919141225045),
        direction: 3.3651863320948943),
    ContactPoint(
        position: Offset(210.68518646463215, -23.752855341632745),
        direction: 3.252828164710742),
    ContactPoint(
        position: Offset(212, -4.8309631543648786e-8),
        direction: 3.141592653589793),
  ],
  holes: [],
  isRing: true,
  isRound: true,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.11123396127784346,
  biggestConcaveDiff: 0.11295588112448396,
  ovalClipper: null,
  pathClipper: const _Circle56ringClipper(),
);
