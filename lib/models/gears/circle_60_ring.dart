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

class _Circle60ringClipper extends CustomClipper<Path> {
  const _Circle60ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(303.99999951689966, 303.999999855071),
        width: 428,
        height: 428));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 608);
    clip.lineTo(608, 608);
    clip.lineTo(608, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle60Ring = GearDefinition(
  id: 'circle60Ring',
  image: 'images/gears/circle_60_ring.png',
  thumbnailImage: 'images/gears/circle_60_ring_thumb.png',
  size: Size(608, 608),
  center: Offset(304, 304),
  toothCount: 60,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(226.76835731586638, 23.848772889931034),
        direction: 3.0378390878931465),
    ContactPoint(
        position: Offset(223.06281002586348, 47.427292803276856),
        direction: 2.9330545593265356),
    ContactPoint(
        position: Offset(216.90167342559118, 70.47831705775162),
        direction: 2.8276417519692414),
    ContactPoint(
        position: Offset(208.34636508609682, 92.75198103430765),
        direction: 2.7222299650107633),
    ContactPoint(
        position: Offset(197.49572228685983, 114.00706189527483),
        direction: 2.6171608967391573),
    ContactPoint(
        position: Offset(184.47707679034895, 134.01427753580913),
        direction: 2.512533371613522),
    ContactPoint(
        position: Offset(169.44180502315368, 152.55911795512307),
        direction: 2.4082635945399957),
    ContactPoint(
        position: Offset(152.5590353551835, 169.44188854355158),
        direction: 2.3041243437199515),
    ContactPoint(
        position: Offset(134.0139802651368, 184.47728475314435),
        direction: 2.19985475920941),
    ContactPoint(
        position: Offset(114.00694640188745, 197.4957796600738),
        direction: 2.0952274179198014),
    ContactPoint(
        position: Offset(92.75177184142117, 208.34648536881977),
        direction: 1.9901585803144881),
    ContactPoint(
        position: Offset(70.47808595430283, 216.90176097367265),
        direction: 1.8847460565222622),
    ContactPoint(
        position: Offset(47.42718436516779, 223.0628379252864),
        direction: 1.7793332310790522),
    ContactPoint(
        position: Offset(23.848536006454633, 226.7683873807369),
        direction: 1.6745492561261344),
    ContactPoint(
        position: Offset(-0.00013051471847018556, 227.9999998550732),
        direction: 1.5707957186712775),
    ContactPoint(
        position: Offset(-23.84903028626816, 226.76835792800853),
        direction: 1.4670425406539351),
    ContactPoint(
        position: Offset(-47.42731031191461, 223.062813249825),
        direction: 1.3622570709512747),
    ContactPoint(
        position: Offset(-70.47844031428612, 216.9016430649452),
        direction: 1.256845474080908),
    ContactPoint(
        position: Offset(-92.75229063679436, 208.34627898055507),
        direction: 1.1514325926023865),
    ContactPoint(
        position: Offset(-114.0073121550202, 197.4955801007073),
        direction: 1.0463628951013888),
    ContactPoint(
        position: Offset(-134.01441990447535, 184.47699346906953),
        direction: 0.941735926887624),
    ContactPoint(
        position: Offset(-152.55931876083932, 169.44163436921212),
        direction: 0.8374657596394641),
    ContactPoint(
        position: Offset(-169.44202515404896, 152.55885831678953),
        direction: 0.7333273743409183),
    ContactPoint(
        position: Offset(-184.4773765136597, 134.01388438578016),
        direction: 0.6290589131733366),
    ContactPoint(
        position: Offset(-197.49592357634424, 114.00680363415955),
        direction: 0.5244301782811256),
    ContactPoint(
        position: Offset(-208.3464996286689, 92.75171907233944),
        direction: 0.4193615301831297),
    ContactPoint(
        position: Offset(-216.90180049555946, 70.47809280377069),
        direction: 0.3139491592343857),
    ContactPoint(
        position: Offset(-223.0628645151202, 47.42700509990332),
        direction: 0.2085366059854028),
    ContactPoint(
        position: Offset(-226.76842608031964, 23.848480613171027),
        direction: 0.10375248496656386),
    ContactPoint(
        position: Offset(-228.00000000000773, -0.00026117734985282057),
        direction: 6.28318417169773),
    ContactPoint(
        position: Offset(-226.76837201917567, -23.849032685878473),
        direction: 6.179430471979868),
    ContactPoint(
        position: Offset(-223.06274637510555, -47.42758364843007),
        direction: 6.0746459675612385),
    ContactPoint(
        position: Offset(-216.90161778451437, -70.47861769768696),
        direction: 5.969233982750506),
    ContactPoint(
        position: Offset(-208.34629236659765, -92.75224157498653),
        direction: 5.863821304080004),
    ContactPoint(
        position: Offset(-197.49568887435908, -114.00715588781813),
        direction: 5.758752288322588),
    ContactPoint(
        position: Offset(-184.47707746632761, -134.01429062807694),
        direction: 5.654124985751383),
    ContactPoint(
        position: Offset(-169.44171665401683, -152.55920310231747),
        direction: 5.549855497137327),
    ContactPoint(
        position: Offset(-152.55896536526714, -169.44192523022357),
        direction: 5.445717254344053),
    ContactPoint(
        position: Offset(-134.01408672076306, -184.47721144813082),
        direction: 5.341448335350125),
    ContactPoint(
        position: Offset(-114.0069531175692, -197.49581596827534),
        direction: 5.236820986983661),
    ContactPoint(
        position: Offset(-92.75195247651399, -208.34642043352903),
        direction: 5.131751547455252),
    ContactPoint(
        position: Offset(-70.47822501918169, -216.90175433793814),
        direction: 5.026338642684916),
    ContactPoint(
        position: Offset(-47.427147469159536, -223.06283881569448),
        direction: 4.920926510275301),
    ContactPoint(
        position: Offset(-23.848702372793177, -226.76840687962283),
        direction: 4.8161421146967),
    ContactPoint(
        position: Offset(0.00007056578194443679, -228.00000000000114),
        direction: 4.712388543296104),
    ContactPoint(
        position: Offset(23.848888338920723, -226.76838613549202),
        direction: 4.6086348882611725),
    ContactPoint(
        position: Offset(47.42741128839882, -223.06277986975755),
        direction: 4.503850609544343),
    ContactPoint(
        position: Offset(70.47843809047494, -216.90168763215453),
        direction: 4.398438017483997),
    ContactPoint(
        position: Offset(92.75206753110103, -208.34634302181627),
        direction: 4.29302586135939),
    ContactPoint(
        position: Offset(114.00709146372428, -197.49575378588258),
        direction: 4.187957164716348),
    ContactPoint(
        position: Offset(134.01414281566562, -184.47718174470768),
        direction: 4.083328429553914),
    ContactPoint(
        position: Offset(152.55908881883636, -169.4418002873693),
        direction: 3.9790601141991573),
    ContactPoint(
        position: Offset(169.44183666848807, -152.55907884624054),
        direction: 3.874921853044685),
    ContactPoint(
        position: Offset(184.47719696581606, -134.0141278417497),
        direction: 3.770651667197595),
    ContactPoint(
        position: Offset(197.4957542935328, -114.00699857574384),
        direction: 3.6660246582653793),
    ContactPoint(
        position: Offset(208.34639470452964, -92.75201385863176),
        direction: 3.5609551581492864),
    ContactPoint(
        position: Offset(216.9016720335744, -70.47830637604982),
        direction: 3.4555431795808245),
    ContactPoint(
        position: Offset(223.06284217801235, -47.42725485128767),
        direction: 3.3501314057967866),
    ContactPoint(
        position: Offset(226.76838715997985, -23.848779647500443),
        direction: 3.2453456773964513),
    ContactPoint(
        position: Offset(227.99999951690182, -0.0000074424146611332356),
        direction: 3.1415920454659885),
  ],
  holes: [],
  isRing: true,
  isRound: true,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.10375295757284198,
  biggestConcaveDiff: 0.10541290477033627,
  ovalClipper: null,
  pathClipper: const _Circle60ringClipper(),
);
