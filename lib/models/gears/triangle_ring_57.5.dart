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

class _Trianglering575Clipper extends CustomClipper<Path> {
  const _Trianglering575Clipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(428.9917907714844, 492.8962287902832),
        width: 674.8000000000001,
        height: 674.8000000000001));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 988);
    clip.lineTo(952, 988);
    clip.lineTo(952, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final triangleRing575 = GearDefinition(
  id: 'triangleRing575',
  image: 'images/gears/triangle_ring_57.5.png',
  thumbnailImage: 'images/gears/triangle_ring_57.5_thumb.png',
  size: Size(952, 988),
  center: Offset(428.9917907714844, 492.8962287902832),
  toothCount: 105,
  entitlement: Entitlement.trianglegears,
  package: Package.trianglegears,
  points: [
    ContactPoint(
        position: Offset(380.8602065865501, 155.013837585914),
        direction: 2.3179759654794516),
    ContactPoint(
        position: Offset(362.3756633368999, 171.7646378766541),
        direction: 2.2960708811847805),
    ContactPoint(
        position: Offset(343.52869039875503, 188.10611992932647),
        direction: 2.2741432850759526),
    ContactPoint(
        position: Offset(324.3278158423767, 204.03019977778737),
        direction: 2.2522252705644608),
    ContactPoint(
        position: Offset(304.78288888390983, 219.53003340526467),
        direction: 2.230297259702737),
    ContactPoint(
        position: Offset(284.9021952115392, 234.5970998100485),
        direction: 2.208376364694855),
    ContactPoint(
        position: Offset(264.6968609966783, 249.22533470562095),
        direction: 2.1864314526080655),
    ContactPoint(
        position: Offset(244.17413807884185, 263.4056656302425),
        direction: 2.16453422759737),
    ContactPoint(
        position: Offset(223.34725040866522, 277.13561142211483),
        direction: 2.14264410656933),
    ContactPoint(
        position: Offset(202.22423604144626, 290.40374646006455),
        direction: 2.1206807432427297),
    ContactPoint(
        position: Offset(180.8145973074283, 303.20581994329456),
        direction: 2.0987798793850843),
    ContactPoint(
        position: Offset(159.13045056692192, 315.536541793212),
        direction: 2.0768676539702415),
    ContactPoint(
        position: Offset(137.18043908647667, 327.38840303368414),
        direction: 2.054942131765733),
    ContactPoint(
        position: Offset(114.97672922345438, 338.7566180791886),
        direction: 2.0330199328164973),
    ContactPoint(
        position: Offset(92.52870697047305, 349.634843772557),
        direction: 2.0111030625406716),
    ContactPoint(
        position: Offset(69.84769788094995, 360.01940281108637),
        direction: 1.98917788087239),
    ContactPoint(
        position: Offset(46.94453293274488, 369.9030603989961),
        direction: 1.9672510375395111),
    ContactPoint(
        position: Offset(23.829966128101184, 379.28336225741043),
        direction: 1.9453357146248216),
    ContactPoint(
        position: Offset(0.5156362059485691, 388.15401714547977),
        direction: 1.9234066425893532),
    ContactPoint(
        position: Offset(-22.98743053895527, 396.51166526911805),
        direction: 1.9014959299129908),
    ContactPoint(
        position: Offset(-46.66816402611413, 404.3525388222915),
        direction: 1.8795667383673766),
    ContactPoint(
        position: Offset(-70.0392231150651, 411.5418748342488),
        direction: 1.8165257630771956),
    ContactPoint(
        position: Offset(-93.22830482005931, 416.1025986650158),
        direction: 1.6909278303706134),
    ContactPoint(
        position: Offset(-116.86189027870323, 417.1978971609999),
        direction: 1.5627610145286859),
    ContactPoint(
        position: Offset(-140.69100723133863, 415.6953112385468),
        direction: 1.4527625483160014),
    ContactPoint(
        position: Offset(-164.21086749012676, 411.5829960418059),
        direction: 1.3427812229102036),
    ContactPoint(
        position: Offset(-187.14149691077301, 404.9160749975333),
        direction: 1.2330749276463306),
    ContactPoint(
        position: Offset(-209.20884339997005, 395.7804085007898),
        direction: 1.1236660545970967),
    ContactPoint(
        position: Offset(-230.15040453495465, 384.2921737877388),
        direction: 1.0144252616590137),
    ContactPoint(
        position: Offset(-249.71398096153888, 370.5901792121994),
        direction: 0.9050908052118247),
    ContactPoint(
        position: Offset(-267.6616696765047, 354.8354192874853),
        direction: 0.7955245005151781),
    ContactPoint(
        position: Offset(-283.7742470956218, 337.21342740387564),
        direction: 0.685634815145189),
    ContactPoint(
        position: Offset(-297.8520102888175, 317.9293278487773),
        direction: 0.5755796645537252),
    ContactPoint(
        position: Offset(-309.7288724142749, 297.21286099311106),
        direction: 0.4658422269866138),
    ContactPoint(
        position: Offset(-319.13917789865735, 275.69970006274474),
        direction: 0.32280267394961815),
    ContactPoint(
        position: Offset(-324.6760454629605, 252.32783055434984),
        direction: 0.2235827070397054),
    ContactPoint(
        position: Offset(-329.9404053493988, 227.9444284468642),
        direction: 0.20167399038695244),
    ContactPoint(
        position: Offset(-334.66893320007193, 203.45174196997993),
        direction: 0.17974675443370813),
    ContactPoint(
        position: Offset(-338.85921673870354, 178.86117788310227),
        direction: 0.15783252895153055),
    ContactPoint(
        position: Offset(-342.5100870544643, 154.18476688309656),
        direction: 0.13590472827618072),
    ContactPoint(
        position: Offset(-345.61823958344075, 129.43420614160843),
        direction: 0.11398039376189484),
    ContactPoint(
        position: Offset(-348.18392748566094, 104.62141576984834),
        direction: 0.09206279258223127),
    ContactPoint(
        position: Offset(-350.20449967645555, 79.75839460634721),
        direction: 0.07013837788895394),
    ContactPoint(
        position: Offset(-351.68005714807845, 54.85697455912988),
        direction: 0.04822287490268984),
    ContactPoint(
        position: Offset(-352.6092675337978, 29.929315694875164),
        direction: 0.026299477622316658),
    ContactPoint(
        position: Offset(-352.99190609424863, 4.987216190807787),
        direction: 0.00438411809791539),
    ContactPoint(
        position: Offset(-352.82797924336717, -19.95721414506927),
        direction: 6.265646955649667),
    ContactPoint(
        position: Offset(-352.11701198260386, -44.89218789752949),
        direction: 6.243731644464033),
    ContactPoint(
        position: Offset(-350.8602649774972, -69.80544415516748),
        direction: 6.22180846622768),
    ContactPoint(
        position: Offset(-349.05702334843943, -94.6852999618357),
        direction: 6.199890244384323),
    ContactPoint(
        position: Offset(-346.7097195311601, -119.51959383809219),
        direction: 6.177967702506928),
    ContactPoint(
        position: Offset(-343.81771108398317, -144.29643349390912),
        direction: 6.156041298674172),
    ContactPoint(
        position: Offset(-340.38395073912176, -169.00397441293924),
        direction: 6.134125820951806),
    ContactPoint(
        position: Offset(-336.40909326365704, -193.63022486609773),
        direction: 6.112198028707512),
    ContactPoint(
        position: Offset(-331.8953837929236, -218.16362840283514),
        direction: 6.090285582527107),
    ContactPoint(
        position: Offset(-326.84544964761255, -242.5920886803364),
        direction: 6.068358887206594),
    ContactPoint(
        position: Offset(-321.38615182333064, -266.4266529242749),
        direction: 6.005325482873972),
    ContactPoint(
        position: Offset(-313.74166378993556, -288.7895342869576),
        direction: 5.879729985833914),
    ContactPoint(
        position: Offset(-302.87363077424516, -309.80448605552436),
        direction: 5.7515492365742515),
    ContactPoint(
        position: Offset(-289.65753527728947, -329.6896613065254),
        direction: 5.641551844161102),
    ContactPoint(
        position: Offset(-274.3363287676363, -348.0026044786515),
        direction: 5.531570881472016),
    ContactPoint(
        position: Offset(-257.09707599881983, -364.5274309925359),
        direction: 5.421869463814527),
    ContactPoint(
        position: Offset(-238.15195395530245, -379.0709363599044),
        direction: 5.3124592917874285),
    ContactPoint(
        position: Offset(-217.731994118747, -391.4623493865181),
        direction: 5.203204519133678),
    ContactPoint(
        position: Offset(-196.0836659258789, -401.5538410968722),
        direction: 5.093888945417414),
    ContactPoint(
        position: Offset(-173.4658691973844, -409.220209143746),
        direction: 4.98431135818867),
    ContactPoint(
        position: Offset(-150.1483431869141, -414.36236534840776),
        direction: 4.874418256812342),
    ContactPoint(
        position: Offset(-126.40889417718745, -416.91244331760066),
        direction: 4.764379652903848),
    ContactPoint(
        position: Offset(-102.52947517112925, -416.8399603470361),
        direction: 4.6546256358694444),
    ContactPoint(
        position: Offset(-79.19339048764496, -414.2325171711067),
        direction: 4.511584353872197),
    ContactPoint(
        position: Offset(-56.1840866569422, -407.34160538996633),
        direction: 4.412373332973155),
    ContactPoint(
        position: Offset(-32.435327919359814, -399.7089988375156),
        direction: 4.390464154188351),
    ContactPoint(
        position: Offset(-8.859793658161268, -391.5576820637284),
        direction: 4.368536239676157),
    ContactPoint(
        position: Offset(14.531441002235677, -382.8912447504162),
        direction: 4.34662230674952),
    ContactPoint(
        position: Offset(37.7272882772607, -373.7147898747794),
        direction: 4.324694668441465),
    ContactPoint(
        position: Offset(60.71594315647798, -364.0312392716414),
        direction: 4.302770481550764),
    ContactPoint(
        position: Offset(83.4873315439359, -353.84679713632937),
        direction: 4.280852848305324),
    ContactPoint(
        position: Offset(106.02960149766658, -343.16513711208836),
        direction: 4.2589274131744315),
    ContactPoint(
        position: Offset(128.3326346125404, -331.9922637128398),
        direction: 4.2370130786243685),
    ContactPoint(
        position: Offset(150.3852870182801, -320.3331603045861),
        direction: 4.2150903604273475),
    ContactPoint(
        position: Offset(172.17709254472717, -308.1934875077693),
        direction: 4.193174727066991),
    ContactPoint(
        position: Offset(193.69774629370107, -295.57927099763816),
        direction: 4.171250757771975),
    ContactPoint(
        position: Offset(214.9364869532959, -282.4960344315477),
        direction: 4.149335563736687),
    ContactPoint(
        position: Offset(235.8837463922223, -268.95099227367103),
        direction: 4.127414097247238),
    ContactPoint(
        position: Offset(256.5286084597783, -254.94948477192204),
        direction: 4.105494820727564),
    ContactPoint(
        position: Offset(276.8620950319156, -240.49948573291044),
        direction: 4.08357273293711),
    ContactPoint(
        position: Offset(296.8734276299826, -225.6065683504581),
        direction: 4.061645890968137),
    ContactPoint(
        position: Offset(316.55394264107576, -210.27899893062218),
        direction: 4.0397296155599385),
    ContactPoint(
        position: Offset(335.8934703787766, -194.52352250245207),
        direction: 4.017802928187994),
    ContactPoint(
        position: Offset(354.8831116815918, -178.34790538780015),
        direction: 3.9958894647614462),
    ContactPoint(
        position: Offset(373.51374480939745, -161.7602708453339),
        direction: 3.9739623018864862),
    ContactPoint(
        position: Offset(391.4254826219774, -145.11505698034216),
        direction: 3.910920873821354),
    ContactPoint(
        position: Offset(406.96962866587916, -127.31307863580238),
        direction: 3.7853208810265375),
    ContactPoint(
        position: Offset(419.73499666114844, -107.39337918158272),
        direction: 3.657157210285817),
    ContactPoint(
        position: Offset(430.3483234660571, -86.00553180065823),
        direction: 3.5471578848524112),
    ContactPoint(
        position: Offset(438.54683141633257, -63.580562647607884),
        direction: 3.437173632286413),
    ContactPoint(
        position: Offset(444.23831476440404, -40.388688097139365),
        direction: 3.327466574670384),
    ContactPoint(
        position: Offset(447.36020246146836, -16.709880478391135),
        direction: 3.218061904154136),
    ContactPoint(
        position: Offset(447.88199321067407, 7.170116728167379),
        direction: 3.1088195165476478),
    ContactPoint(
        position: Offset(445.7973608383946, 30.963519994823635),
        direction: 2.999481764488557),
    ContactPoint(
        position: Offset(441.12711827430155, 54.384203449189286),
        direction: 2.8899197502651983),
    ContactPoint(
        position: Offset(433.9223359729988, 77.14916242625861),
        direction: 2.780031417828863),
    ContactPoint(
        position: Offset(424.26079939286336, 98.98274172990637),
        direction: 2.669973562874513),
    ContactPoint(
        position: Offset(412.2581090588759, 119.62673531964397),
        direction: 2.5602380158553144),
    ContactPoint(
        position: Offset(398.33240155081023, 138.5329250553664),
        direction: 2.417198475197856),
  ],
  holes: [],
  isRing: true,
  isRound: false,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.02189012102804,
  biggestConcaveDiff: 0.14304128199724708,
  ovalClipper: null,
  pathClipper: const _Trianglering575Clipper(),
);
