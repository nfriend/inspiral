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

class _Circle52ringClipper extends CustomClipper<Path> {
  const _Circle52ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(272, 271.999999855071), width: 364, height: 364));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 544);
    clip.lineTo(544, 544);
    clip.lineTo(544, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle52Ring = GearDefinition(
  id: 'circle52Ring',
  image: 'images/gears/circle_52_ring.png',
  thumbnailImage: 'images/gears/circle_52_ring_thumb.png',
  size: Size(544, 544),
  center: Offset(272, 272),
  toothCount: 52,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(194.5897823059998, 23.641453263810494),
        direction: 3.0217153525845335),
    ContactPoint(
        position: Offset(190.34913955306996, 46.92726264871605),
        direction: 2.9006291126083337),
    ContactPoint(
        position: Offset(183.31654507632442, 69.51987112978885),
        direction: 2.778980039709661),
    ContactPoint(
        position: Offset(173.59243813608697, 91.09403054827945),
        direction: 2.657546177361157),
    ContactPoint(
        position: Offset(161.32789063432062, 111.34035618595767),
        direction: 2.5366673061531038),
    ContactPoint(
        position: Offset(146.71351764272856, 129.96929408430705),
        direction: 2.4162878425173195),
    ContactPoint(
        position: Offset(129.96938076500527, 146.71343039259418),
        direction: 2.2961016965765326),
    ContactPoint(
        position: Offset(111.34038343262924, 161.32789285107367),
        direction: 2.1757220202955114),
    ContactPoint(
        position: Offset(91.0941581896808, 173.59234358554073),
        direction: 2.0548422921545075),
    ContactPoint(
        position: Offset(69.51995490387992, 183.31648690235505),
        direction: 1.9334096468960507),
    ContactPoint(
        position: Offset(46.92731017293356, 190.34911224633953),
        direction: 1.8117610396218886),
    ContactPoint(
        position: Offset(23.64166026753689, 194.5897524582813),
        direction: 1.6906741955622815),
    ContactPoint(
        position: Offset(0.00003847455214230049, 195.9999998550732),
        direction: 1.5707969352794837),
    ContactPoint(
        position: Offset(-23.641575912554103, 194.58978210885337),
        direction: 1.4509190621759451),
    ContactPoint(
        position: Offset(-46.92722200482835, 190.3491419321813),
        direction: 1.329831904411769),
    ContactPoint(
        position: Offset(-69.51992829568788, 183.31651593675443),
        direction: 1.2081833551339054),
    ContactPoint(
        position: Offset(-91.09418715064766, 173.59234841521965),
        direction: 1.086749496579401),
    ContactPoint(
        position: Offset(-111.3403655557124, 161.32786941856295),
        direction: 0.9658695951004255),
    ContactPoint(
        position: Offset(-129.96933870844018, 146.71342033156253),
        direction: 0.8454922209044691),
    ContactPoint(
        position: Offset(-146.71354672584377, 129.96931331068868),
        direction: 0.7253060685053443),
    ContactPoint(
        position: Offset(-161.32788613621025, 111.34039872684417),
        direction: 0.6049241293361787),
    ContactPoint(
        position: Offset(-173.5923680293927, 91.094079815358),
        direction: 0.48404758418511484),
    ContactPoint(
        position: Offset(-183.31660033007827, 69.5199197528491),
        direction: 0.3626137201594011),
    ContactPoint(
        position: Offset(-190.34914429161245, 46.92726859139107),
        direction: 0.2409630310251636),
    ContactPoint(
        position: Offset(-194.58977269758122, 23.641652223108075),
        direction: 0.11987725106017244),
    ContactPoint(
        position: Offset(-196, 0.000029830717693357656),
        direction: 4.5160952311107394e-8),
    ContactPoint(
        position: Offset(-194.58977514654933, -23.64160520912556),
        direction: 6.16330792790985),
    ContactPoint(
        position: Offset(-190.34913199278554, -46.92726265733932),
        direction: 6.042221742064646),
    ContactPoint(
        position: Offset(-183.3165453283101, -69.51999551601328),
        direction: 5.92057151387732),
    ContactPoint(
        position: Offset(-173.5923219908105, -91.09415727179132),
        direction: 5.799137086849414),
    ContactPoint(
        position: Offset(-161.32779957190888, -111.34047020755183),
        direction: 5.6782598878945265),
    ContactPoint(
        position: Offset(-146.7134080412536, -129.96941098542027),
        direction: 5.557879888164802),
    ContactPoint(
        position: Offset(-129.96923874716475, -146.7135586412325),
        direction: 5.437693173043894),
    ContactPoint(
        position: Offset(-111.3403033580245, -161.327908093233),
        direction: 5.317313511017419),
    ContactPoint(
        position: Offset(-91.09402831094773, -173.5923920463863),
        direction: 5.19643639920379),
    ContactPoint(
        position: Offset(-69.51980242273935, -183.3166244808148),
        direction: 5.075002290971304),
    ContactPoint(
        position: Offset(-46.927212068884565, -190.3491490852748),
        direction: 4.953351636604494),
    ContactPoint(
        position: Offset(-23.641487205624248, -194.58979016215255),
        direction: 4.8322660061390135),
    ContactPoint(
        position: Offset(0.00007144507195412886, -196.00000000000097),
        direction: 4.71238857631191),
    ContactPoint(
        position: Offset(23.641628739247377, -194.58977122811564),
        direction: 4.5925110267825175),
    ContactPoint(
        position: Offset(46.9273848395053, -190.349101080198),
        direction: 4.471425437304919),
    ContactPoint(
        position: Offset(69.5200084301393, -183.31654630779624),
        direction: 4.349774991021997),
    ContactPoint(
        position: Offset(91.09416957781741, -173.59232150807128),
        direction: 4.228341214001381),
    ContactPoint(
        position: Offset(111.34045679987499, -161.32783883826232),
        direction: 4.107464536267979),
    ContactPoint(
        position: Offset(129.9693744437543, -146.71350113608844),
        direction: 3.9870829066430513),
    ContactPoint(
        position: Offset(146.71344615462456, -129.96932142425968),
        direction: 3.8668961515367446),
    ContactPoint(
        position: Offset(161.32786484011012, -111.34034964414195),
        direction: 3.7465186931546803),
    ContactPoint(
        position: Offset(173.59237931808772, -91.09410291507295),
        direction: 3.6256395268469506),
    ContactPoint(
        position: Offset(183.3165480824403, -69.51984823728549),
        direction: 3.504205973690947),
    ContactPoint(
        position: Offset(190.34914142446547, -46.92727058197013),
        direction: 3.3825568480678925),
    ContactPoint(
        position: Offset(194.58978225378237, -23.641576057483114),
        direction: 3.261469918208744),
    ContactPoint(
        position: Offset(196, -1.4492900537863178e-7),
        direction: 3.141592653589793),
  ],
  holes: [],
  isRing: true,
  isRound: true,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.11987720589922013,
  biggestConcaveDiff: 0.12165068913423749,
  ovalClipper: null,
  pathClipper: const _Circle52ringClipper(),
);
