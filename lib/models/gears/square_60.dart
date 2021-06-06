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

class _Square60Clipper extends CustomClipper<Rect> {
  const _Square60Clipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: Offset(263.9999583661556, 263.9999876320362),
        width: 528,
        height: 528);
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final square60 = GearDefinition(
  id: 'square60',
  image: 'images/gears/square_60.png',
  thumbnailImage: 'images/gears/square_60_thumb.png',
  size: Size(528, 528),
  center: Offset(263.9999583661556, 263.9999876320362),
  toothCount: 56,
  entitlement: Entitlement.squaregears,
  package: Package.squaregears,
  points: [
    ContactPoint(position: Offset(252, 0), direction: 0),
    ContactPoint(
        position: Offset(243.0443431127906, -28.161000772025616),
        direction: 0.3645535503487496),
    ContactPoint(
        position: Offset(232.89694164274798, -52.188139378457436),
        direction: 0.4347031543047928),
    ContactPoint(
        position: Offset(221.08918023289854, -75.44487834092524),
        direction: 0.5048966910916821),
    ContactPoint(
        position: Offset(207.67944553094608, -97.81602089269407),
        direction: 0.5750737373675356),
    ContactPoint(
        position: Offset(192.73458463111587, -119.19186494060229),
        direction: 0.6452281573393126),
    ContactPoint(
        position: Offset(176.32867308524783, -139.46708136666058),
        direction: 0.7153210597965618),
    ContactPoint(
        position: Offset(158.54424042781216, -158.54434905406333),
        direction: 0.7853982703313065),
    ContactPoint(
        position: Offset(139.46696485750735, -176.32878169370218),
        direction: 0.8554754953158188),
    ContactPoint(
        position: Offset(119.19175843433356, -192.7346759540844),
        direction: 0.9255681376169305),
    ContactPoint(
        position: Offset(97.81592818729322, -207.6795362766579),
        direction: 0.9957242191919882),
    ContactPoint(
        position: Offset(75.4447323782049, -221.08919835594278),
        direction: 1.06590045774157),
    ContactPoint(
        position: Offset(52.188035339649474, -232.8969899463688),
        direction: 1.136092917737197),
    ContactPoint(
        position: Offset(28.160884723223514, -243.04435998926928),
        direction: 1.2062436003646795),
    ContactPoint(
        position: Offset(-0.0000737334533404255, -251.9999876320295),
        direction: 1.5707973849863208),
    ContactPoint(
        position: Offset(-28.161057596113263, -243.04431917224713),
        direction: 1.9353467795253687),
    ContactPoint(
        position: Offset(-52.18816651661516, -232.89711732874477),
        direction: 2.0054907588950037),
    ContactPoint(
        position: Offset(-75.4450956148387, -221.08957354024722),
        direction: 2.075689006967451),
    ContactPoint(
        position: Offset(-97.81636311325289, -207.67968021296997),
        direction: 2.1458767735633684),
    ContactPoint(
        position: Offset(-119.19196252817873, -192.7346603208801),
        direction: 2.2160203390231823),
    ContactPoint(
        position: Offset(-139.46754338286894, -176.3290691213812),
        direction: 2.2861203827252776),
    ContactPoint(
        position: Offset(-158.5443288879664, -158.54422244693498),
        direction: 2.3561949179272768),
    ContactPoint(
        position: Offset(-176.3292257815025, -139.46735559036273),
        direction: 2.426269115074076),
    ContactPoint(
        position: Offset(-192.73482610614178, -119.19174657579725),
        direction: 2.496368884314806),
    ContactPoint(
        position: Offset(-207.6798418566062, -97.81614728958887),
        direction: 2.566512425358015),
    ContactPoint(
        position: Offset(-221.08966861065826, -75.44496717967267),
        direction: 2.6367005794368668),
    ContactPoint(
        position: Offset(-232.89721295411871, -52.188005157432336),
        direction: 2.706899027379291),
    ContactPoint(
        position: Offset(-243.04442598861257, -28.160801211376956),
        direction: 2.7770446539752545),
    ContactPoint(
        position: Offset(-251.99995836612453, 0.00014938365693801256),
        direction: 3.1415949297018297),
    ContactPoint(
        position: Offset(-243.04429242990315, 28.161079927062463),
        direction: 3.506146459133488),
    ContactPoint(
        position: Offset(-232.89688633295668, 52.1882585061583),
        direction: 3.5762969394865793),
    ContactPoint(
        position: Offset(-221.08906945816148, 75.44495145248607),
        direction: 3.6464890416749896),
    ContactPoint(
        position: Offset(-207.67943322475946, 97.81609263120778),
        direction: 3.7166659385730725),
    ContactPoint(
        position: Offset(-192.73453558260798, 119.19188454658196),
        direction: 3.786821264349524),
    ContactPoint(
        position: Offset(-176.3286326699161, 139.46715264205062),
        direction: 3.8569140016032706),
    ContactPoint(
        position: Offset(-158.54414343089215, 158.54440027461146),
        direction: 3.9269915655242524),
    ContactPoint(
        position: Offset(-139.46690714491075, 176.32882458335186),
        direction: 3.99706778212021),
    ContactPoint(
        position: Offset(-119.19169583586331, 192.73471913367112),
        direction: 4.0671625457833045),
    ContactPoint(
        position: Offset(-97.81580388066588, 207.679518652634),
        direction: 4.137317094862306),
    ContactPoint(
        position: Offset(-75.44469026080237, 221.08921349985545),
        direction: 4.2074927629480285),
    ContactPoint(
        position: Offset(-52.187999276643104, 232.8969429301895),
        direction: 4.277686080832524),
    ContactPoint(
        position: Offset(-28.160780521475957, 243.04437615949118),
        direction: 4.3478360211756915),
    ContactPoint(
        position: Offset(0.00008403587469763197, 251.9999389648217),
        direction: 4.712390897111227),
    ContactPoint(
        position: Offset(28.161135974472913, 243.04428288918774),
        direction: 5.076942341046613),
    ContactPoint(
        position: Offset(52.18832471353847, 232.89684196968136),
        direction: 5.147093741497865),
    ContactPoint(
        position: Offset(75.44495522069681, 221.08905783881292),
        direction: 5.217285727255041),
    ContactPoint(
        position: Offset(97.81611596653651, 207.67939210356045),
        direction: 5.287461552123733),
    ContactPoint(
        position: Offset(119.19200548352408, 192.73449065933167),
        direction: 5.3576174729316755),
    ContactPoint(
        position: Offset(139.46712202228454, 176.328640388094),
        direction: 5.427710317117388),
    ContactPoint(
        position: Offset(158.5443975525226, 158.5442071881405),
        direction: 5.49778757151771),
    ContactPoint(
        position: Offset(176.32880016372582, 139.46693064385346),
        direction: 5.567864883719124),
    ContactPoint(
        position: Offset(192.7346153172042, 119.19181894036134),
        direction: 5.637957173190737),
    ContactPoint(
        position: Offset(207.67945178896272, 97.81602649627794),
        direction: 5.708112528637139),
    ContactPoint(
        position: Offset(221.08927583008125, 75.44464214116829),
        direction: 5.778289312853898),
    ContactPoint(
        position: Offset(232.89700198394524, 52.187973026329445),
        direction: 5.8484820155576465),
    ContactPoint(
        position: Offset(243.04434287375585, 28.160986139620626),
        direction: 5.918631700960537),
  ],
  holes: [
    GearHole(name: '0', angle: 0, distance: 0),
    GearHole(name: '8', angle: 1.5707963267948966, distance: 8),
    GearHole(name: '9', angle: 2.356194490192345, distance: 9.000000000000002),
    GearHole(name: '10', angle: -3.141592653589793, distance: 10),
    GearHole(
        name: '11', angle: -2.3561944901923444, distance: 11.000000000000004),
    GearHole(name: '12', angle: -1.5707963267948966, distance: 12),
    GearHole(
        name: '13', angle: -0.7853981633974483, distance: 13.000000000000004),
    GearHole(name: '14', angle: 0, distance: 14),
    GearHole(
        name: '15', angle: 0.7853981633974483, distance: 15.000000000000002),
    GearHole(name: '16', angle: 1.5707963267948966, distance: 16),
    GearHole(
        name: '17', angle: 2.356194490192345, distance: 16.999999999999996),
    GearHole(name: '18', angle: -3.141592653589793, distance: 18),
    GearHole(
        name: '19', angle: -2.3561944901923453, distance: 18.999999999999996),
    GearHole(name: '20', angle: -1.570796326794897, distance: 20),
    GearHole(name: '21', angle: -0.7853981633974487, distance: 21),
    GearHole(name: '22', angle: -3.2297397080004555e-16, distance: 22),
    GearHole(name: '23', angle: 0.7853981633974481, distance: 23),
    GearHole(name: '24', angle: 1.5707963267948966, distance: 24),
    GearHole(name: '25', angle: 2.356194490192345, distance: 25),
    GearHole(name: '26', angle: -3.141592653589793, distance: 26),
    GearHole(
        name: '27', angle: -2.356194490192345, distance: 27.000000000000004),
    GearHole(name: '28', angle: -1.570796326794897, distance: 28),
    GearHole(
        name: '29', angle: -0.7853981633974486, distance: 29.000000000000004),
    GearHole(name: '30', angle: -2.3684757858670006e-16, distance: 30),
    GearHole(name: '31', angle: 0.785398163397448, distance: 31),
    GearHole(name: '32', angle: 1.5707963267948966, distance: 32),
    GearHole(name: '33', angle: 2.356194490192345, distance: 33),
    GearHole(name: '34', angle: 3.141592653589793, distance: 34),
    GearHole(name: '35', angle: -2.356194490192345, distance: 35),
    GearHole(name: '36', angle: -1.570796326794897, distance: 36),
    GearHole(
        name: '37', angle: -0.7853981633974485, distance: 37.00000000000001),
    GearHole(name: '38', angle: -1.8698493046318425e-16, distance: 38),
    GearHole(
        name: '39', angle: 0.7853981633974481, distance: 39.00000000000001),
    GearHole(name: '40', angle: 1.5707963267948966, distance: 40),
    GearHole(name: '41', angle: 2.356194490192345, distance: 41),
    GearHole(name: '42', angle: 3.141592653589793, distance: 42),
    GearHole(name: '43', angle: -2.3561944901923453, distance: 43),
    GearHole(name: '44', angle: -1.5707963267948968, distance: 44),
    GearHole(
        name: '45', angle: -0.7853981633974485, distance: 44.99999999999999),
    GearHole(name: '46', angle: -3.089316242435218e-16, distance: 46),
    GearHole(name: '47', angle: 0.785398163397448, distance: 47),
    GearHole(name: '48', angle: 1.5707963267948966, distance: 48),
    GearHole(name: '49', angle: 2.356194490192345, distance: 49),
    GearHole(name: '50', angle: 3.141592653589793, distance: 50),
    GearHole(name: '52', angle: -1.5707963267948968, distance: 52),
    GearHole(name: '54', angle: -2.631639762074445e-16, distance: 54),
  ],
  isRing: false,
  isRound: false,
  smallestConvexDiff: 0.0700741971467993,
  biggestConvexDiff: 0.3645548759355357,
  smallestConcaveDiff: 6.283185307179586,
  biggestConcaveDiff: 0,
  ovalClipper: const _Square60Clipper(),
  pathClipper: null,
);
