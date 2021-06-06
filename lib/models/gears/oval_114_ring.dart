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

class _Oval114ringClipper extends CustomClipper<Path> {
  const _Oval114ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(519.9999995652165, 368), width: 860, height: 556));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 736);
    clip.lineTo(1040, 736);
    clip.lineTo(1040, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final oval114Ring = GearDefinition(
  id: 'oval114Ring',
  image: 'images/gears/oval_114_ring.png',
  thumbnailImage: 'images/gears/oval_114_ring_thumb.png',
  size: Size(1040, 736),
  center: Offset(520, 368),
  toothCount: 96,
  entitlement: Entitlement.ovalgears,
  package: Package.ovalgears,
  points: [
    ContactPoint(
        position: Offset(442.5607750038785, 23.606529438443463),
        direction: 3.020036394344152),
    ContactPoint(
        position: Offset(438.2697561752526, 46.88681807692994),
        direction: 2.900280032304515),
    ContactPoint(
        position: Offset(431.24652020914783, 69.55221434864944),
        direction: 2.785106073829213),
    ContactPoint(
        position: Offset(421.6962086842283, 91.365604439716),
        direction: 2.6767836921512362),
    ContactPoint(
        position: Offset(409.87470490832743, 112.14953171610921),
        direction: 2.5765352033190148),
    ContactPoint(
        position: Offset(396.0563669779956, 131.7878949792813),
        direction: 2.484657215612749),
    ContactPoint(
        position: Offset(380.5076766047275, 150.21505955320617),
        direction: 2.400796389902278),
    ContactPoint(
        position: Offset(363.47369128668896, 167.40441772233805),
        direction: 2.3242735059723985),
    ContactPoint(
        position: Offset(345.171716701979, 183.35637038605557),
        direction: 2.25422112940986),
    ContactPoint(
        position: Offset(325.7876320767266, 198.08789952549748),
        direction: 2.1897859614233717),
    ContactPoint(
        position: Offset(305.48223718742287, 211.626140627296),
        direction: 2.130181491683448),
    ContactPoint(
        position: Offset(284.3909836732075, 224.00273919622228),
        direction: 2.0746616731172622),
    ContactPoint(
        position: Offset(262.62898346697204, 235.2499589645666),
        direction: 2.022610458086495),
    ContactPoint(
        position: Offset(240.29560890081532, 245.4000062625876),
        direction: 1.9734870244014076),
    ContactPoint(
        position: Offset(217.47434571811291, 254.48285369012333),
        direction: 1.9268611825697342),
    ContactPoint(
        position: Offset(194.24042669139652, 262.527493249346),
        direction: 1.8823074761312144),
    ContactPoint(
        position: Offset(170.65727203749663, 269.5567211267946),
        direction: 1.839523170785026),
    ContactPoint(
        position: Offset(146.78221910659917, 275.5961118304274),
        direction: 1.7982682712414473),
    ContactPoint(
        position: Offset(122.66761188932675, 280.6646807147142),
        direction: 1.7582210553867785),
    ContactPoint(
        position: Offset(98.35906560637389, 284.7790890241675),
        direction: 1.719218994151456),
    ContactPoint(
        position: Offset(73.89954293348184, 287.9561755880097),
        direction: 1.6811063790331549),
    ContactPoint(
        position: Offset(49.32852766592873, 290.20934998357603),
        direction: 1.6437517313239747),
    ContactPoint(
        position: Offset(24.682775908839535, 291.5528828393898),
        direction: 1.6070840569888034),
    ContactPoint(
        position: Offset(-0.0005958404252305733, 292.0000000042866),
        direction: 1.570823055748118),
    ContactPoint(
        position: Offset(-24.68334875866048, 291.55421925182884),
        direction: 1.5345232105293949),
    ContactPoint(
        position: Offset(-49.32883487316625, 290.21010462822335),
        direction: 1.4978155201800938),
    ContactPoint(
        position: Offset(-73.8998102231818, 287.95625443729386),
        direction: 1.46047279042687),
    ContactPoint(
        position: Offset(-98.35956101752076, 284.7791536863472),
        direction: 1.4223716155290411),
    ContactPoint(
        position: Offset(-122.66827866985824, 280.6645975679237),
        direction: 1.3833814875966688),
    ContactPoint(
        position: Offset(-146.78311831572242, 275.5965944876045),
        direction: 1.3433490158476387),
    ContactPoint(
        position: Offset(-170.65793302375891, 269.55790911140286),
        direction: 1.3020605952543303),
    ContactPoint(
        position: Offset(-194.2409698690882, 262.52760567482585),
        direction: 1.2592712052879413),
    ContactPoint(
        position: Offset(-217.47503559303297, 254.48330275872527),
        direction: 1.2147262541843435),
    ContactPoint(
        position: Offset(-240.29589942415538, 245.39994930328461),
        direction: 1.168091784086637),
    ContactPoint(
        position: Offset(-262.6295161223603, 235.24972333145521),
        direction: 1.11898057168065),
    ContactPoint(
        position: Offset(-284.3913571568794, 224.0025609731467),
        direction: 1.0669301377759748),
    ContactPoint(
        position: Offset(-305.4825762543044, 211.62596550755518),
        direction: 1.0114099078638858),
    ContactPoint(
        position: Offset(-325.788065858085, 198.08761205386548),
        direction: 0.9518041494031859),
    ContactPoint(
        position: Offset(-345.1719602436102, 183.35610934965302),
        direction: 0.8873697265007117),
    ContactPoint(
        position: Offset(-363.4741203123188, 167.4040201401691),
        direction: 0.8173192515928092),
    ContactPoint(
        position: Offset(-380.5079384089249, 150.214791558584),
        direction: 0.7407955111809645),
    ContactPoint(
        position: Offset(-396.0565964934357, 131.78766103744275),
        direction: 0.6569343646932335),
    ContactPoint(
        position: Offset(-409.8748744138714, 112.14929836399826),
        direction: 0.5650563857580924),
    ContactPoint(
        position: Offset(-421.6965245311119, 91.3651422560266),
        direction: 0.46480652852901905),
    ContactPoint(
        position: Offset(-431.2465920537806, 69.55191598647524),
        direction: 0.3564832601204193),
    ContactPoint(
        position: Offset(-438.2698024310254, 46.88661572677414),
        direction: 0.24131165384637931),
    ContactPoint(
        position: Offset(-442.56075640050494, 23.606422348463813),
        direction: 0.12155500160469757),
    ContactPoint(
        position: Offset(-444.0000000001255, -0.0003905752004625148),
        direction: 0.000004573486757308842),
    ContactPoint(
        position: Offset(-442.5609798018035, -23.607049975459034),
        direction: 6.161634317930856),
    ContactPoint(
        position: Offset(-438.26999946475513, -46.887317466200095),
        direction: 6.041874948692081),
    ContactPoint(
        position: Offset(-431.246958004185, -69.55226689208689),
        direction: 5.926692544796785),
    ContactPoint(
        position: Offset(-421.69645943454293, -91.36521554845817),
        direction: 5.818368541459728),
    ContactPoint(
        position: Offset(-409.8747283524904, -112.14955348621487),
        direction: 5.718128499386541),
    ContactPoint(
        position: Offset(-396.05648079954983, -131.7878004107956),
        direction: 5.626249551835486),
    ContactPoint(
        position: Offset(-380.5078625716819, -150.21484375213012),
        direction: 5.54238879753093),
    ContactPoint(
        position: Offset(-363.4739751136987, -167.4041195475613),
        direction: 5.465866083023963),
    ContactPoint(
        position: Offset(-345.17183898871997, -183.35620645131246),
        direction: 5.3958163129735315),
    ContactPoint(
        position: Offset(-325.78802879575244, -198.08767012203913),
        direction: 5.331381827415067),
    ContactPoint(
        position: Offset(-305.48253965699183, -211.62604368393963),
        direction: 5.271774496840168),
    ContactPoint(
        position: Offset(-284.39128661090103, -224.00258753842513),
        direction: 5.2162531704117825),
    ContactPoint(
        position: Offset(-262.6293210125976, -235.2497751578225),
        direction: 5.164204434041536),
    ContactPoint(
        position: Offset(-240.2956561107814, -245.40004431831989),
        direction: 5.1150934481611525),
    ContactPoint(
        position: Offset(-217.47495290588003, -254.48330327611518),
        direction: 5.0684582647536605),
    ContactPoint(
        position: Offset(-194.24081963262196, -262.52762399113044),
        direction: 5.023913896030969),
    ContactPoint(
        position: Offset(-170.65788580334103, -269.5578870084554),
        direction: 4.981126155647881),
    ContactPoint(
        position: Offset(-146.78312877110744, -275.5966430000825),
        direction: 4.939838007378171),
    ContactPoint(
        position: Offset(-122.66817613636836, -280.66467683263545),
        direction: 4.899802162497706),
    ContactPoint(
        position: Offset(-98.35945209402234, -284.7791397996571),
        direction: 4.860812583903403),
    ContactPoint(
        position: Offset(-73.89967533740463, -287.9562825597933),
        direction: 4.822713591240488),
    ContactPoint(
        position: Offset(-49.32857216076265, -290.2101618951895),
        direction: 4.785371338778504),
    ContactPoint(
        position: Offset(-24.68330106094341, -291.5543191718576),
        direction: 4.7486609844653564),
    ContactPoint(
        position: Offset(-0.00003060353844695553, -292),
        direction: 4.712389009453287),
    ContactPoint(
        position: Offset(24.683178311891613, -291.5543206252467),
        direction: 4.676116992216796),
    ContactPoint(
        position: Offset(49.328479246097935, -290.21016383853595),
        direction: 4.639406580851079),
    ContactPoint(
        position: Offset(73.89967595078923, -287.95627285877714),
        direction: 4.602064493864096),
    ContactPoint(
        position: Offset(98.35942258542956, -284.7791409492816),
        direction: 4.563965535152292),
    ContactPoint(
        position: Offset(122.66811698044802, -280.664683940751),
        direction: 4.52497603142114),
    ContactPoint(
        position: Offset(146.78309193773464, -275.5966576120762),
        direction: 4.484939487540801),
    ContactPoint(
        position: Offset(170.65788171773247, -269.5578573765726),
        direction: 4.443651527140436),
    ContactPoint(
        position: Offset(194.24082287806328, -262.52761312931545),
        direction: 4.400864424995923),
    ContactPoint(
        position: Offset(217.47484283288503, -254.4833270539006),
        direction: 4.356319483350767),
    ContactPoint(
        position: Offset(240.29563984030293, -245.40002912007282),
        direction: 4.309684499734881),
    ContactPoint(
        position: Offset(262.62927922656564, -235.24976898463495),
        direction: 4.260573976890823),
    ContactPoint(
        position: Offset(284.3911178760534, -224.0026714720203),
        direction: 4.208524788587535),
    ContactPoint(
        position: Offset(305.4824242562242, -211.62607711072462),
        direction: 4.153004205166816),
    ContactPoint(
        position: Offset(325.787925886177, -198.087755034818),
        direction: 4.093398182790941),
    ContactPoint(
        position: Offset(345.1717601632593, -183.35633892085292),
        direction: 4.028962289114732),
    ContactPoint(
        position: Offset(363.47386469217287, -167.40425134595117),
        direction: 3.958910692861272),
    ContactPoint(
        position: Offset(380.5077382692601, -150.21493679471288),
        direction: 3.8823889949923913),
    ContactPoint(
        position: Offset(396.05637650349485, -131.7879131454444),
        direction: 3.798529391386774),
    ContactPoint(
        position: Offset(409.87475789527815, -112.14952915132054),
        direction: 3.706648851331855),
    ContactPoint(
        position: Offset(421.69626386811296, -91.36543300290796),
        direction: 3.6064005272329824),
    ContactPoint(
        position: Offset(431.24652343742747, -69.55219042094947),
        direction: 3.4980800042256233),
    ContactPoint(
        position: Offset(438.26975466229146, -46.88691577721165),
        direction: 3.382904747292865),
    ContactPoint(
        position: Offset(442.56071364645464, -23.60665414686853),
        direction: 3.2631486913584737),
    ContactPoint(
        position: Offset(443.9999995652254, 0.0000146123881406813),
        direction: 3.141593871288805),
  ],
  holes: [],
  isRing: true,
  isRound: false,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.03626100124068543,
  biggestConcaveDiff: 0.1215574769446528,
  ovalClipper: null,
  pathClipper: const _Oval114ringClipper(),
);
