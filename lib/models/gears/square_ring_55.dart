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

class _Squarering55Clipper extends CustomClipper<Path> {
  const _Squarering55Clipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(503.9777780715376, 503.97744523733854),
        width: 722.4,
        height: 722.4));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 1008);
    clip.lineTo(1008, 1008);
    clip.lineTo(1008, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final squareRing55 = GearDefinition(
  id: 'squareRing55',
  image: 'images/gears/square_ring_55.png',
  thumbnailImage: 'images/gears/square_ring_55_thumb.png',
  size: Size(1008, 1008),
  center: Offset(503.9777780715376, 503.97744523733854),
  toothCount: 105,
  entitlement: Entitlement.squaregears,
  package: Package.squaregears,
  points: [
    ContactPoint(
        position: Offset(371.9753878889069, 144.7707830744842),
        direction: 2.5043983229071003),
    ContactPoint(
        position: Offset(356.992198715737, 164.5392236853757),
        direction: 2.4816011450905315),
    ContactPoint(
        position: Offset(341.56121049425326, 183.9597015011669),
        direction: 2.458799594732171),
    ContactPoint(
        position: Offset(325.69251674814484, 203.0244222129704),
        direction: 2.4360032715027984),
    ContactPoint(
        position: Offset(309.3923108163099, 221.7215746245835),
        direction: 2.4131967739446862),
    ContactPoint(
        position: Offset(292.6705404253439, 240.04320518896148),
        direction: 2.390406834063232),
    ContactPoint(
        position: Offset(275.53541400965963, 257.9781598009654),
        direction: 2.367602743759586),
    ContactPoint(
        position: Offset(257.9960264168378, 275.5180311722912),
        direction: 2.344809518331984),
    ContactPoint(
        position: Offset(240.061265873785, 292.6536269145729),
        direction: 2.3220036761644143),
    ContactPoint(
        position: Offset(221.7401652953669, 309.375711835871),
        direction: 2.2992154517109724),
    ContactPoint(
        position: Offset(203.04324798242624, 325.67646643060726),
        direction: 2.276409486369463),
    ContactPoint(
        position: Offset(183.97883975289284, 341.5456951670369),
        direction: 2.253611931314591),
    ContactPoint(
        position: Offset(164.55843657721564, 356.9772753726915),
        direction: 2.230808540996832),
    ContactPoint(
        position: Offset(144.79059444637997, 371.96064939213136),
        direction: 2.2080122392630877),
    ContactPoint(
        position: Offset(124.77768092979275, 386.42776737197056),
        direction: 2.1760022734118367),
    ContactPoint(
        position: Offset(104.65987206867361, 399.75982310826214),
        direction: 2.098373758242113),
    ContactPoint(
        position: Offset(83.53962177165668, 410.504404137601),
        direction: 1.9842210045749855),
    ContactPoint(
        position: Offset(61.3329603111461, 418.76795238593434),
        direction: 1.8699160687943452),
    ContactPoint(
        position: Offset(38.32686585828414, 424.44647871426287),
        direction: 1.755802897010705),
    ContactPoint(
        position: Offset(14.820824231903929, 427.47219138389147),
        direction: 1.6419425336025295),
    ContactPoint(
        position: Offset(-8.878142930182157, 427.8104410571116),
        direction: 1.5282088582207436),
    ContactPoint(
        position: Offset(-32.46160571197229, 425.45744353432536),
        direction: 1.414394947202223),
    ContactPoint(
        position: Offset(-55.62174673424487, 420.4398088318795),
        direction: 1.3003410263279376),
    ContactPoint(
        position: Offset(-78.05664897240645, 412.8166101473488),
        direction: 1.186062850608737),
    ContactPoint(
        position: Offset(-99.47522165237469, 402.6829877761066),
        direction: 1.071806990909943),
    ContactPoint(
        position: Offset(-119.83018074822877, 390.0179008703248),
        direction: 0.9807700632409535),
    ContactPoint(
        position: Offset(-139.75696432887008, 375.6643777639994),
        direction: 0.9373783136622427),
    ContactPoint(
        position: Offset(-159.62881421038506, 360.7804908341013),
        direction: 0.9165052977556165),
    ContactPoint(
        position: Offset(-179.1374330037241, 345.46029301055484),
        direction: 0.8937098916816115),
    ContactPoint(
        position: Offset(-198.2923935617887, 329.7006269752614),
        direction: 0.8709055637839045),
    ContactPoint(
        position: Offset(-217.08194902642222, 313.5071509298746),
        direction: 0.8481069815914166),
    ContactPoint(
        position: Offset(-235.4988206409867, 296.8906122426657),
        direction: 0.8253091644624693),
    ContactPoint(
        position: Offset(-253.5307683582516, 279.8575204871003),
        direction: 0.8025031753960823),
    ContactPoint(
        position: Offset(-271.1707890973485, 262.41856906551163),
        direction: 0.779712459516487),
    ContactPoint(
        position: Offset(-288.4079951643984, 244.5814243301188),
        direction: 0.7569063174974007),
    ContactPoint(
        position: Offset(-305.2344373306662, 226.35635985972448),
        direction: 0.7341131454924748),
    ContactPoint(
        position: Offset(-321.64092902928525, 207.75220196297488),
        direction: 0.711309852215436),
    ContactPoint(
        position: Offset(-337.6190641854865, 188.7788471374042),
        direction: 0.6885174983325539),
    ContactPoint(
        position: Offset(-353.1605260256672, 169.44666014531998),
        direction: 0.6657122102311623),
    ContactPoint(
        position: Offset(-368.25699280449504, 149.76447830609905),
        direction: 0.642916236891077),
    ContactPoint(
        position: Offset(-382.8828346987894, 129.76987043600073),
        direction: 0.6174667879604891),
    ContactPoint(
        position: Offset(-396.6721606734325, 109.78693136384393),
        direction: 0.5512917341864236),
    ContactPoint(
        position: Offset(-408.0463927778449, 88.93232066599072),
        direction: 0.4420065091022618),
    ContactPoint(
        position: Offset(-416.94144101804415, 66.97128404972572),
        direction: 0.3276865555553039),
    ContactPoint(
        position: Offset(-423.2740199742511, 44.13694139567622),
        direction: 0.2135089002737116),
    ContactPoint(
        position: Offset(-426.96735312085946, 20.727514911874522),
        direction: 0.09959028379859003),
    ContactPoint(
        position: Offset(-427.9789803596953, -2.952298772459379),
        direction: 6.269029576687759),
    ContactPoint(
        position: Offset(-426.297484345711, -26.593551072126637),
        direction: 6.155254032981036),
    ContactPoint(
        position: Offset(-421.941741379175, -49.888078974308684),
        direction: 6.0412684784114745),
    ContactPoint(
        position: Offset(-414.96249657712093, -72.5322502472932),
        direction: 5.927031999342908),
    ContactPoint(
        position: Offset(-405.445284246926, -94.231552095793),
        direction: 5.812733524412404),
    ContactPoint(
        position: Offset(-393.4331566922401, -114.83205783906641),
        direction: 5.7111444747113405),
    ContactPoint(
        position: Offset(-379.3051836829484, -134.75011092439726),
        direction: 5.6563471919202595),
    ContactPoint(
        position: Offset(-364.5404360862191, -154.69766677357998),
        direction: 5.634593742811532),
    ContactPoint(
        position: Offset(-349.33227122759985, -174.29348879745788),
        direction: 5.6117948016443275),
    ContactPoint(
        position: Offset(-333.6814158086328, -193.53749711535016),
        direction: 5.588996283218043),
    ContactPoint(
        position: Offset(-317.5958890793233, -212.41970794068857),
        direction: 5.566197322756018),
    ContactPoint(
        position: Offset(-301.0840073268044, -230.9304412793185),
        direction: 5.5433987852408),
    ContactPoint(
        position: Offset(-284.15449838610914, -249.05985096600259),
        direction: 5.520600288717721),
    ContactPoint(
        position: Offset(-266.8161795005501, -266.79856964176633),
        direction: 5.497798760842522),
    ContactPoint(
        position: Offset(-249.07783391591303, -284.13733024564715),
        direction: 5.474997686489829),
    ContactPoint(
        position: Offset(-230.9488310957183, -301.06727759187584),
        direction: 5.452199268704767),
    ContactPoint(
        position: Offset(-212.43860379112795, -317.57948423822046),
        direction: 5.429399976964453),
    ContactPoint(
        position: Offset(-193.5566144284233, -333.66556589834175),
        direction: 5.406601378272779),
    ContactPoint(
        position: Offset(-174.31301449439144, -349.31685088914327),
        direction: 5.383802813938586),
    ContactPoint(
        position: Offset(-154.71752922355202, -364.5254723296323),
        direction: 5.3610033527836265),
    ContactPoint(
        position: Offset(-134.77015027734302, -379.29079073665775),
        direction: 5.339259597674633),
    ContactPoint(
        position: Offset(-114.85231188763109, -393.4198525751583),
        direction: 5.284506385136902),
    ContactPoint(
        position: Offset(-94.2527960700462, -405.4344877201505),
        direction: 5.182954539997927),
    ContactPoint(
        position: Offset(-72.55463831329097, -414.9542145809052),
        direction: 5.068657306379585),
    ContactPoint(
        position: Offset(-49.91134526046782, -421.9360016242728),
        direction: 4.954420043988586),
    ContactPoint(
        position: Offset(-26.61717093963115, -426.2944629068757),
        direction: 4.840435701284994),
    ContactPoint(
        position: Offset(-2.9762934698047836, -427.9786660620223),
        direction: 4.726653419762008),
    ContactPoint(
        position: Offset(20.70363713201419, -426.9694569851858),
        direction: 4.612912615180281),
    ContactPoint(
        position: Offset(44.11372366082554, -423.2790444523792),
        direction: 4.499000304351389),
    ContactPoint(
        position: Offset(66.94855694781563, -416.9491344765348),
        direction: 4.3848159846737245),
    ContactPoint(
        position: Offset(88.91080930517695, -408.05649930088305),
        direction: 4.270498148238083),
    ContactPoint(
        position: Offset(109.76644436196771, -396.6848944721286),
        direction: 4.161188842244017),
    ContactPoint(
        position: Offset(129.74966875626248, -382.89730115729105),
        direction: 4.09496595661684),
    ContactPoint(
        position: Offset(149.74454591832293, -368.2719270312042),
        direction: 4.0694945268669205),
    ContactPoint(
        position: Offset(169.42691775221775, -353.1759889536703),
        direction: 4.046699667731213),
    ContactPoint(
        position: Offset(188.75966797924025, -337.6348508699488),
        direction: 4.023896305338456),
    ContactPoint(
        position: Offset(207.73342737277244, -321.6571916882637),
        direction: 4.001101937775691),
    ContactPoint(
        position: Offset(226.33776066607268, -305.2512173381592),
        direction: 3.9782982425886098),
    ContactPoint(
        position: Offset(244.56331370688144, -288.42515556796366),
        direction: 3.9555055802895467),
    ContactPoint(
        position: Offset(262.40073825040116, -271.1884082666889),
        direction: 3.9326969763077857),
    ContactPoint(
        position: Offset(279.8399997856301, -253.54877109700254),
        direction: 3.909907329615018),
    ContactPoint(
        position: Offset(296.8735946240442, -235.51713435780357),
        direction: 3.887103684955476),
    ContactPoint(
        position: Offset(313.4905025920835, -217.10075293048186),
        direction: 3.864306865403593),
    ContactPoint(
        position: Offset(329.68456582675884, -198.3114890676657),
        direction: 3.8415059534089355),
    ContactPoint(
        position: Offset(345.4445982633448, -179.1568388649413),
        direction: 3.8187022842314224),
    ContactPoint(
        position: Offset(360.76522398080476, -159.6487581190036),
        direction: 3.7959076501238798),
    ContactPoint(
        position: Offset(375.64962877038937, -139.77709351747887),
        direction: 3.7750308815352307),
    ContactPoint(
        position: Offset(390.0037487967986, -119.85025209084215),
        direction: 3.731684116198016),
    ContactPoint(
        position: Offset(402.6713714537578, -99.49630376530071),
        direction: 3.640695473274895),
    ContactPoint(
        position: Offset(412.80754984727287, -78.0787664579843),
        direction: 3.526442065440355),
    ContactPoint(
        position: Offset(420.4333446676611, -55.64472860640802),
        direction: 3.412163889999203),
    ContactPoint(
        position: Offset(425.45369366289844, -32.485099310935865),
        direction: 3.298110305700286),
    ContactPoint(
        position: Offset(427.8094017983317, -8.90205057689124),
        direction: 3.18429617981118),
    ContactPoint(
        position: Offset(427.47392464704416, 14.796959500988827),
        direction: 3.07056117874908),
    ContactPoint(
        position: Offset(424.4508653625502, 38.30318853333626),
        direction: 2.9567002885066023),
    ContactPoint(
        position: Offset(418.7749884781118, 61.31012086472037),
        direction: 2.8425889344092132),
    ContactPoint(
        position: Offset(410.5139862945673, 83.51774258856459),
        direction: 2.728282008871939),
    ContactPoint(
        position: Offset(399.77183697273966, 104.63914742409851),
        direction: 2.6141179264563528),
    ContactPoint(
        position: Offset(386.4419647425798, 124.75767590367897),
        direction: 2.5364438386121364),
  ],
  holes: [],
  isRing: true,
  isRound: false,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.020873015906626158,
  biggestConcaveDiff: 0.1143199535469579,
  ovalClipper: null,
  pathClipper: const _Squarering55Clipper(),
);
