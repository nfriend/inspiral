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

class _Circle105ringClipper extends CustomClipper<Path> {
  const _Circle105ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(483.81518816947937, 483.9534487761557),
        width: 788,
        height: 788));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 968);
    clip.lineTo(968, 968);
    clip.lineTo(968, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle105Ring = GearDefinition(
  id: 'circle105Ring',
  image: 'images/gears/circle_105_ring.png',
  thumbnailImage: 'images/gears/circle_105_ring_thumb.png',
  size: Size(968, 968),
  center: Offset(484, 484),
  toothCount: 105,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(407.0966499164693, 24.367270534319317),
        direction: 3.0825605491439223),
    ContactPoint(
        position: Offset(404.9351234731951, 48.69023759483892),
        direction: 3.0230829629589078),
    ContactPoint(
        position: Offset(401.3259294072818, 72.83577831477592),
        direction: 2.963175588623117),
    ContactPoint(
        position: Offset(396.2742406957045, 96.71800969563684),
        direction: 2.903010432343817),
    ContactPoint(
        position: Offset(389.79389362782575, 120.25125219697014),
        direction: 2.8427150253189235),
    ContactPoint(
        position: Offset(381.9064020211795, 143.35066700158785),
        direction: 2.7824129179292507),
    ContactPoint(
        position: Offset(372.64154198812713, 165.93383001148445),
        direction: 2.722197145107299),
    ContactPoint(
        position: Offset(362.0350324973996, 187.92034160455498),
        direction: 2.662086036533957),
    ContactPoint(
        position: Offset(350.1268085091116, 209.23249730980106),
        direction: 2.602127341960695),
    ContactPoint(
        position: Offset(336.96416398476435, 229.79540427059447),
        direction: 2.54233707510735),
    ContactPoint(
        position: Offset(322.59657274160753, 249.53751289097414),
        direction: 2.4826801796779874),
    ContactPoint(
        position: Offset(307.07791999071253, 268.3898644726402),
        direction: 2.4231242335386605),
    ContactPoint(
        position: Offset(290.4649400977291, 286.28611765144177),
        direction: 2.3636282692310413),
    ContactPoint(
        position: Offset(272.81726698838213, 303.1637070619807),
        direction: 2.3041392942150285),
    ContactPoint(
        position: Offset(254.197840282772, 318.9612198932053),
        direction: 2.2446034630962073),
    ContactPoint(
        position: Offset(234.67178646456696, 333.62179785124295),
        direction: 2.184979746978591),
    ContactPoint(
        position: Offset(214.30732610863046, 347.09069416578313),
        direction: 2.1252251654994065),
    ContactPoint(
        position: Offset(193.1758478816676, 359.3168652109914),
        direction: 2.065304673827902),
    ContactPoint(
        position: Offset(171.3508679669973, 370.2526484571759),
        direction: 2.005228621591348),
    ContactPoint(
        position: Offset(148.90884657604974, 379.85668673830827),
        direction: 1.94504425269181),
    ContactPoint(
        position: Offset(125.93099660780123, 388.0917627948368),
        direction: 1.884749065843673),
    ContactPoint(
        position: Offset(102.49858812135504, 394.9257090437731),
        direction: 1.8244389337088096),
    ContactPoint(
        position: Offset(78.69551934287676, 400.33632789195667),
        direction: 1.7642391516067821),
    ContactPoint(
        position: Offset(54.607907146250916, 404.3069744814417),
        direction: 1.7042492095529758),
    ContactPoint(
        position: Offset(30.321338914678837, 406.83032695165696),
        direction: 1.6446382664408201),
    ContactPoint(
        position: Offset(5.92172091906676, 407.9082432726037),
        direction: 1.5855346504345302),
    ContactPoint(
        position: Offset(-18.50077861485941, 407.5498432546448),
        direction: 1.5265609127703605),
    ContactPoint(
        position: Offset(-42.85444162221181, 405.7494791288877),
        direction: 1.4671957488492344),
    ContactPoint(
        position: Offset(-67.05254723258241, 402.50209445567594),
        direction: 1.4073909529443114),
    ContactPoint(
        position: Offset(-91.0085372187399, 397.81028321948736),
        direction: 1.3472670372422204),
    ContactPoint(
        position: Offset(-114.63662955533928, 391.68500453423866),
        direction: 1.2869933251100223),
    ContactPoint(
        position: Offset(-137.85269477210795, 384.1469746862196),
        direction: 1.2266894048121735),
    ContactPoint(
        position: Offset(-160.57249546317803, 375.2231816148841),
        direction: 1.1664398308847481),
    ContactPoint(
        position: Offset(-182.7155502011858, 364.94836565063133),
        direction: 1.106304862385108),
    ContactPoint(
        position: Offset(-204.20334953477783, 353.36160288214455),
        direction: 1.0463059110988189),
    ContactPoint(
        position: Offset(-224.96040498094595, 340.50790099887655),
        direction: 0.9864726521916314),
    ContactPoint(
        position: Offset(-244.9142132409984, 326.43671125286664),
        direction: 0.9267853034101936),
    ContactPoint(
        position: Offset(-263.9953528513409, 311.2004788383022),
        direction: 0.8672081996725627),
    ContactPoint(
        position: Offset(-282.13665049366443, 294.8556118669247),
        direction: 0.8077034852653808),
    ContactPoint(
        position: Offset(-299.27449208381006, 277.4610546163643),
        direction: 0.7482201959217099),
    ContactPoint(
        position: Offset(-315.3476615938677, 259.07862133782663),
        direction: 0.6887006535070643),
    ContactPoint(
        position: Offset(-330.2976368028025, 239.77300551525164),
        direction: 0.6290989615223506),
    ContactPoint(
        position: Offset(-344.06934243059845, 219.61157163732025),
        direction: 0.5693798958861018),
    ContactPoint(
        position: Offset(-356.61081792652243, 198.664908293987),
        direction: 0.5095040863998221),
    ContactPoint(
        position: Offset(-367.8734460169201, 177.00617179011144),
        direction: 0.4494661769968964),
    ContactPoint(
        position: Offset(-377.81408744055966, 154.7111193274084),
        direction: 0.38930303048364845),
    ContactPoint(
        position: Offset(-386.3944571107158, 131.85965981245153),
        direction: 0.32902804422899923),
    ContactPoint(
        position: Offset(-393.58114263149474, 108.53297569409902),
        direction: 0.2687204244392003),
    ContactPoint(
        position: Offset(-399.3497231140715, 84.81458936191),
        direction: 0.20848527533597228),
    ContactPoint(
        position: Offset(-403.68145208648707, 60.79017776352172),
        direction: 0.14842508596338178),
    ContactPoint(
        position: Offset(-406.56691440699484, 36.5454346643629),
        direction: 0.08869556884619278),
    ContactPoint(
        position: Offset(-408.0052088449548, 12.165773325307706),
        direction: 0.029465295497859145),
    ContactPoint(
        position: Offset(-408.00517944756376, -12.259765934403253),
        direction: 6.2537178969356475),
    ContactPoint(
        position: Offset(-406.5668467541365, -36.63921423520634),
        direction: 6.194487665088371),
    ContactPoint(
        position: Offset(-403.68134182310183, -60.88393322633895),
        direction: 6.134758673230397),
    ContactPoint(
        position: Offset(-399.3496079530292, -84.90818245765587),
        direction: 6.074697634021946),
    ContactPoint(
        position: Offset(-393.5809513867074, -108.62654403306875),
        direction: 6.014462947454469),
    ContactPoint(
        position: Offset(-386.394205785127, -131.95339065525934),
        direction: 5.954156164525639),
    ContactPoint(
        position: Offset(-377.813815575317, -154.80475963407),
        direction: 5.8938812446884485),
    ContactPoint(
        position: Offset(-367.8732153887146, -177.09971980608458),
        direction: 5.833718001831345),
    ContactPoint(
        position: Offset(-356.6104848078097, -198.75854862216582),
        direction: 5.773680129132531),
    ContactPoint(
        position: Offset(-344.0690736310383, -219.70508025918832),
        direction: 5.713803326372879),
    ContactPoint(
        position: Offset(-330.29728754489315, -239.86648139592734),
        direction: 5.6540839447216396),
    ContactPoint(
        position: Offset(-315.3473422058335, -259.17199717234513),
        direction: 5.594484516447351),
    ContactPoint(
        position: Offset(-299.2742080176748, -277.55444185709484),
        direction: 5.534966263623032),
    ContactPoint(
        position: Offset(-282.1363578114186, -294.94904568912165),
        direction: 5.475480381310074),
    ContactPoint(
        position: Offset(-263.99494425933955, -311.29388589370217),
        direction: 5.415975068878967),
    ContactPoint(
        position: Offset(-244.91393566019997, -326.5299990003006),
        direction: 5.356400308322953),
    ContactPoint(
        position: Offset(-224.9600501450214, -340.60128830275994),
        direction: 5.296713043015448),
    ContactPoint(
        position: Offset(-204.2029890778606, -353.4549690297145),
        direction: 5.236878842114603),
    ContactPoint(
        position: Offset(-182.71528429765587, -365.04166970540166),
        direction: 5.17687962878154),
    ContactPoint(
        position: Offset(-160.57208240262472, -375.31653086168683),
        direction: 5.116742807368585),
    ContactPoint(
        position: Offset(-137.8521347998341, -384.24026075106025),
        direction: 5.056494144153838),
    ContactPoint(
        position: Offset(-114.63634593112363, -391.77821704413446),
        direction: 4.996190111269598),
    ContactPoint(
        position: Offset(-91.0081059592523, -397.90343686251964),
        direction: 4.935916004904563),
    ContactPoint(
        position: Offset(-67.05207869097121, -402.5952330126626),
        direction: 4.875795264522873),
    ContactPoint(
        position: Offset(-42.85412778311976, -405.84266275084923),
        direction: 4.8159877273242),
    ContactPoint(
        position: Offset(-18.500320984088788, -407.64288936036615),
        direction: 4.756621837701717),
    ContactPoint(
        position: Offset(5.922109412637215, -408.00130340689145),
        direction: 4.697649970425083),
    ContactPoint(
        position: Offset(30.321753330571728, -406.923341775983),
        direction: 4.63854596863375),
    ContactPoint(
        position: Offset(54.60831109494937, -404.39998135155616),
        direction: 4.578934138759228),
    ContactPoint(
        position: Offset(78.69592857693617, -400.4292459942395),
        direction: 4.518944626041214),
    ContactPoint(
        position: Offset(102.49883443495229, -395.0186697843729),
        direction: 4.458746560537015),
    ContactPoint(
        position: Offset(125.9315565281718, -388.18465199116537),
        direction: 4.39843717041244),
    ContactPoint(
        position: Offset(148.90952180175407, -379.9495568890199),
        direction: 4.338141398193565),
    ContactPoint(
        position: Offset(171.35115125447916, -370.34566569355474),
        direction: 4.277954674776382),
    ContactPoint(
        position: Offset(193.17625739674332, -359.4097483373063),
        direction: 4.2178789546628765),
    ContactPoint(
        position: Offset(214.30780780400949, -347.1835107745557),
        direction: 4.157959496159277),
    ContactPoint(
        position: Offset(234.6722177982949, -333.71463038767115),
        direction: 4.098205977011648),
    ContactPoint(
        position: Offset(254.19823927837504, -319.05412364568303),
        direction: 4.038578831472296),
    ContactPoint(
        position: Offset(272.81760499886974, -303.25642292980683),
        direction: 3.979042849804771),
    ContactPoint(
        position: Offset(290.46504378669715, -286.3790785385679),
        direction: 3.9195548553991846),
    ContactPoint(
        position: Offset(307.0780349554653, -268.482654612333),
        direction: 3.8600601740646665),
    ContactPoint(
        position: Offset(322.5966973180692, -249.63038322043028),
        direction: 3.8005054686093325),
    ContactPoint(
        position: Offset(336.9642293238966, -229.88828679407592),
        direction: 3.740848867970711),
    ContactPoint(
        position: Offset(350.127058419559, -209.325239168149),
        direction: 3.6810589012504225),
    ContactPoint(
        position: Offset(362.0350841643092, -188.01333999838508),
        direction: 3.621097578431719),
    ContactPoint(
        position: Offset(372.64160419768575, -166.02674671961637),
        direction: 3.560988402408281),
    ContactPoint(
        position: Offset(381.90658452028066, -143.44340485330983),
        direction: 3.5007722454958037),
    ContactPoint(
        position: Offset(389.7940112855681, -120.34400275530857),
        direction: 3.4404690330316567),
    ContactPoint(
        position: Offset(396.27429829248194, -96.81094317511976),
        direction: 3.3801736623868677),
    ContactPoint(
        position: Offset(401.3259282386412, -72.92876517256198),
        direction: 3.320009169811472),
    ContactPoint(
        position: Offset(404.93512367697605, -48.783338331056235),
        direction: 3.2601024878507143),
    ContactPoint(
        position: Offset(407.0966499164693, -24.46031194685165),
        direction: 3.200624758035664),
    ContactPoint(
        position: Offset(407.81518816947937, -0.04655122384429125),
        direction: 3.141592653589793),
  ],
  holes: [],
  isRing: true,
  isRound: true,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.058932705741797875,
  biggestConcaveDiff: 0.06031013213486336,
  ovalClipper: null,
  pathClipper: const _Circle105ringClipper(),
);
