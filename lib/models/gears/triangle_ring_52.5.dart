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

class _Trianglering525Clipper extends CustomClipper<Path> {
  const _Trianglering525Clipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(397.24647521972656, 455.6451473236084),
        width: 611.6,
        height: 611.6));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 912);
    clip.lineTo(880, 912);
    clip.lineTo(880, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final triangleRing525 = GearDefinition(
  id: 'triangleRing525',
  image: 'images/gears/triangle_ring_52.5.png',
  thumbnailImage: 'images/gears/triangle_ring_52.5_thumb.png',
  size: Size(880, 912),
  center: Offset(397.24647521972656, 455.6451473236084),
  toothCount: 96,
  entitlement: Entitlement.trianglegears,
  package: Package.trianglegears,
  points: [
    ContactPoint(
        position: Offset(345.4664049224089, 142.21686547140013),
        direction: 2.315926001733967),
    ContactPoint(
        position: Offset(326.97444881865715, 158.87124158927472),
        direction: 2.291956025051964),
    ContactPoint(
        position: Offset(308.08826795421953, 175.07680357902677),
        direction: 2.267976491219141),
    ContactPoint(
        position: Offset(288.8191867052846, 190.82548596855656),
        direction: 2.2440036135573855),
    ContactPoint(
        position: Offset(269.17804280196464, 206.10723834722793),
        direction: 2.2200263957324218),
    ContactPoint(
        position: Offset(249.17628881052732, 220.91405902201416),
        direction: 2.196046468728338),
    ContactPoint(
        position: Offset(228.82489449157475, 235.23675663996218),
        direction: 2.172070712207484),
    ContactPoint(
        position: Offset(208.13628403422604, 249.0678840080927),
        direction: 2.14809422406244),
    ContactPoint(
        position: Offset(187.12177157899612, 262.3985524747875),
        direction: 2.1241252673550033),
    ContactPoint(
        position: Offset(165.79445239630903, 275.2222258406882),
        direction: 2.10012909866036),
    ContactPoint(
        position: Offset(144.16462677952438, 287.52937509126724),
        direction: 2.0761703004841516),
    ContactPoint(
        position: Offset(122.24700449085871, 299.3170671474956),
        direction: 2.0522166462649274),
    ContactPoint(
        position: Offset(100.0528656543988, 310.5741426734333),
        direction: 2.0282214919397603),
    ContactPoint(
        position: Offset(77.59526540785244, 321.2966984790678),
        direction: 2.004248997566517),
    ContactPoint(
        position: Offset(54.88696569041894, 331.4772180438258),
        direction: 1.9802732488193175),
    ContactPoint(
        position: Offset(31.941539937187652, 341.11085468227964),
        direction: 1.956273163712103),
    ContactPoint(
        position: Offset(8.77062036073658, 350.1901690010834),
        direction: 1.9323169595900485),
    ContactPoint(
        position: Offset(-14.61033821709448, 358.71397794485495),
        direction: 1.9083617574442613),
    ContactPoint(
        position: Offset(-38.189064340401835, 366.6730315004194),
        direction: 1.8843669226436779),
    ContactPoint(
        position: Offset(-61.54421477919817, 373.9516797654066),
        direction: 1.8251233233549495),
    ContactPoint(
        position: Offset(-84.60083536222679, 378.81829676227755),
        direction: 1.6967705635309436),
    ContactPoint(
        position: Offset(-108.04755059108783, 379.8614422602182),
        direction: 1.555880657790544),
    ContactPoint(
        position: Offset(-131.69692151970895, 378.0836266494937),
        direction: 1.435559662683449),
    ContactPoint(
        position: Offset(-154.96268460682126, 373.47768931986246),
        direction: 1.315336851470187),
    ContactPoint(
        position: Offset(-177.51326226903998, 366.1174808054067),
        direction: 1.1954486493243053),
    ContactPoint(
        position: Offset(-199.02657464111587, 356.11481210363934),
        direction: 1.0758608993064094),
    ContactPoint(
        position: Offset(-219.1957512108449, 343.619447195008),
        direction: 0.9563588419707871),
    ContactPoint(
        position: Offset(-237.7285381790654, 328.8092389112658),
        direction: 0.8366353583046973),
    ContactPoint(
        position: Offset(-254.35385113743757, 311.8921050381526),
        direction: 0.7165511331592054),
    ContactPoint(
        position: Offset(-268.8271262763877, 293.1046766553734),
        direction: 0.5962194675505383),
    ContactPoint(
        position: Offset(-280.94079554386747, 272.7124284847349),
        direction: 0.47613377818465263),
    ContactPoint(
        position: Offset(-290.40616810282074, 251.37153870629962),
        direction: 0.3248446122692936),
    ContactPoint(
        position: Offset(-295.89670967104115, 228.07418850338718),
        direction: 0.2215315443597401),
    ContactPoint(
        position: Offset(-301.07375185427907, 203.73255817735816),
        direction: 0.19756033109098148),
    ContactPoint(
        position: Offset(-305.6651353643177, 179.27388282044168),
        direction: 0.17358312329558778),
    ContactPoint(
        position: Offset(-309.6693742249181, 154.71214287120753),
        direction: 0.1496065907410804),
    ContactPoint(
        position: Offset(-313.083090025178, 130.06128786591398),
        direction: 0.12562957898104266),
    ContactPoint(
        position: Offset(-315.90532217767344, 105.33598062130318),
        direction: 0.10165250239079704),
    ContactPoint(
        position: Offset(-318.13345202696763, 80.5499127114614),
        direction: 0.07767783475857648),
    ContactPoint(
        position: Offset(-319.7673519546852, 55.71747139280485),
        direction: 0.05370087930704681),
    ContactPoint(
        position: Offset(-320.8047789222321, 30.853149850877596),
        direction: 0.029728463410175543),
    ContactPoint(
        position: Offset(-321.2466737505749, 5.971042766834988),
        direction: 0.00575226615924862),
    ContactPoint(
        position: Offset(-321.09105810725714, -18.91438482783907),
        direction: 6.264961647445887),
    ContactPoint(
        position: Offset(-320.33976016656686, -43.78911536396184),
        direction: 6.240989183207794),
    ContactPoint(
        position: Offset(-318.9916412109746, -68.63866593663242),
        direction: 6.217012567272501),
    ContactPoint(
        position: Offset(-317.04884040166684, -93.448752387841),
        direction: 6.193038231271673),
    ContactPoint(
        position: Offset(-314.51124324299997, -118.20495033038104),
        direction: 6.169060915479538),
    ContactPoint(
        position: Offset(-311.3813687656571, -142.89343865727946),
        direction: 6.1450850094033544),
    ContactPoint(
        position: Offset(-307.6600233535306, -167.4996295342754),
        direction: 6.1211082320283285),
    ContactPoint(
        position: Offset(-303.3503271463186, -192.009552632914),
        direction: 6.097130215518855),
    ContactPoint(
        position: Offset(-298.4536873492058, -216.40911240816072),
        direction: 6.073156869043247),
    ContactPoint(
        position: Offset(-293.0795268965736, -240.27474311437382),
        direction: 6.013919725787849),
    ContactPoint(
        position: Offset(-285.7661864211923, -262.6756696517368),
        direction: 5.885563802459754),
    ContactPoint(
        position: Offset(-274.94605449160747, -283.50261943111184),
        direction: 5.7446681466784755),
    ContactPoint(
        position: Offset(-261.5816789969901, -303.09480812885727),
        direction: 5.624359867606403),
    ContactPoint(
        position: Offset(-245.9603287068089, -320.9408407314366),
        direction: 5.504125475255122),
    ContactPoint(
        position: Offset(-228.3104863180856, -336.7897556660178),
        direction: 5.384237634767454),
    ContactPoint(
        position: Offset(-208.89137569230158, -350.42001949792314),
        direction: 5.2646544590192415),
    ContactPoint(
        position: Offset(-187.98536509389518, -361.6390480047449),
        direction: 5.145143192415341),
    ContactPoint(
        position: Offset(-165.89300040044174, -370.2838205502663),
        direction: 5.02542599947971),
    ContactPoint(
        position: Offset(-142.92957791895077, -376.22322359500964),
        direction: 4.905347956233098),
    ContactPoint(
        position: Offset(-119.42242610125682, -379.364079194569),
        direction: 4.785015833186935),
    ContactPoint(
        position: Offset(-95.70557626027993, -379.65867007482996),
        direction: 4.664910403156039),
    ContactPoint(
        position: Offset(-72.4910807378383, -377.1848464944798),
        direction: 4.513621969482902),
    ContactPoint(
        position: Offset(-49.56950376028363, -370.2910660123256),
        direction: 4.410321984515298),
    ContactPoint(
        position: Offset(-25.90060759604133, -362.6037482391841),
        direction: 4.3863508127201865),
    ContactPoint(
        position: Offset(-2.4229083081973624, -354.35060632971835),
        direction: 4.362372858064899),
    ContactPoint(
        position: Offset(20.85035893059854, -345.53745858147306),
        direction: 4.338396678554816),
    ContactPoint(
        position: Offset(43.90537582031156, -336.1684596715575),
        direction: 4.314419933937309),
    ContactPoint(
        position: Offset(66.72929594293258, -326.2498951458853),
        direction: 4.290442684539756),
    ContactPoint(
        position: Offset(89.30872565021289, -315.78648554603984),
        direction: 4.266468144810249),
    ContactPoint(
        position: Offset(111.63108500857786, -304.78531767796323),
        direction: 4.242490316308709),
    ContactPoint(
        position: Offset(133.68295204917052, -293.2515465157901),
        direction: 4.218518689459513),
    ContactPoint(
        position: Offset(155.45250834944713, -281.1931861070427),
        direction: 4.194541602982337),
    ContactPoint(
        position: Offset(176.92611700480444, -268.61561079049454),
        direction: 4.170565973029753),
    ContactPoint(
        position: Offset(198.0926668677827, -255.52763034768273),
        direction: 4.146595579913447),
    ContactPoint(
        position: Offset(218.9388510106053, -241.93544240850602),
        direction: 4.122616440846258),
    ContactPoint(
        position: Offset(239.45358437829702, -227.8478166808553),
        direction: 4.0986412749273935),
    ContactPoint(
        position: Offset(259.62437976669884, -213.27200150508403),
        direction: 4.074665068861124),
    ContactPoint(
        position: Offset(279.4402227913996, -198.217238435889),
        direction: 4.050689985336744),
    ContactPoint(
        position: Offset(298.88918971277326, -182.6913559957069),
        direction: 4.026712697756354),
    ContactPoint(
        position: Offset(317.96056819402565, -166.7040149255649),
        direction: 4.002735564179719),
    ContactPoint(
        position: Offset(336.6429101630642, -150.26369504485825),
        direction: 3.978761045930818),
    ContactPoint(
        position: Offset(354.62385017113303, -133.67678234605387),
        direction: 3.919518088256251),
    ContactPoint(
        position: Offset(370.3668188687079, -116.14261453636985),
        direction: 3.791167301085297),
    ContactPoint(
        position: Offset(382.99354253469124, -96.35870340044475),
        direction: 3.6502757504221646),
    ContactPoint(
        position: Offset(393.2786406062306, -74.98882883715036),
        direction: 3.529954136347206),
    ContactPoint(
        position: Offset(400.92257943311205, -52.53714854303828),
        direction: 3.4097292603611717),
    ContactPoint(
        position: Offset(405.8237013279755, -29.32759886136412),
        direction: 3.289840767534384),
    ContactPoint(
        position: Offset(407.91770942335756, -5.695106731492821),
        direction: 3.170254472154428),
    ContactPoint(
        position: Offset(407.18100729810254, 18.0195823215063),
        direction: 3.050753443251112),
    ContactPoint(
        position: Offset(403.62135880384807, 41.47443516957958),
        direction: 2.93103111950662),
    ContactPoint(
        position: Offset(397.2834345065334, 64.33094158037153),
        direction: 2.8109452605359992),
    ContactPoint(
        position: Offset(388.24956570982584, 86.2588283955078),
        direction: 2.690611531647429),
    ContactPoint(
        position: Offset(376.64614269246414, 106.94574810685017),
        direction: 2.5705296980410193),
    ContactPoint(
        position: Offset(362.8971234516592, 125.8134896332548),
        direction: 2.419239354384384),
  ],
  holes: [],
  isRing: true,
  isRound: false,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.02395365421922424,
  biggestConcaveDiff: 0.15129034365663507,
  ovalClipper: null,
  pathClipper: const _Trianglering525Clipper(),
);
