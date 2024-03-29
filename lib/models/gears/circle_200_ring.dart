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

class _Circle200ringClipper extends CustomClipper<Path> {
  const _Circle200ringClipper();

  @override
  Path getClip(Size size) {
    final clip = Path()..fillType = PathFillType.evenOdd;

    clip.addOval(Rect.fromCenter(
        center: Offset(863.9999988405591, 863.999998840568),
        width: 1548,
        height: 1548));

    clip.close();

    clip.moveTo(0, 0);
    clip.lineTo(0, 1728);
    clip.lineTo(1728, 1728);
    clip.lineTo(1728, 0);
    clip.close();

    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

final circle200Ring = GearDefinition(
  id: 'circle200Ring',
  image: 'images/gears/circle_200_ring.png',
  thumbnailImage: 'images/gears/circle_200_ring_thumb.png',
  size: Size(1728, 1728),
  center: Offset(864, 864),
  toothCount: 200,
  entitlement: Entitlement.free,
  package: Package.free,
  points: [
    ContactPoint(
        position: Offset(787.6176670153532, 24.76190641181243),
        direction: 3.1106891633498073),
    ContactPoint(
        position: Offset(786.4698952750231, 49.49791447893024),
        direction: 3.0796728540149716),
    ContactPoint(
        position: Offset(784.553560048203, 74.18476083375954),
        direction: 3.0484871082766976),
    ContactPoint(
        position: Offset(781.866589797132, 98.79735138350482),
        direction: 3.017155876589361),
    ContactPoint(
        position: Offset(778.408425047379, 123.31351946210876),
        direction: 2.9857178718089274),
    ContactPoint(
        position: Offset(774.1805603436474, 147.70656788201742),
        direction: 2.9541900141486077),
    ContactPoint(
        position: Offset(769.1850349791423, 171.95309971575813),
        direction: 2.9225999684302812),
    ContactPoint(
        position: Offset(763.4256677245921, 196.02976585015972),
        direction: 2.8909747454536165),
    ContactPoint(
        position: Offset(756.9076128732648, 219.9117715527122),
        direction: 2.8593279192850263),
    ContactPoint(
        position: Offset(749.6372325461851, 243.57485730261436),
        direction: 2.82763497110464),
    ContactPoint(
        position: Offset(741.619715502562, 266.9953578006986),
        direction: 2.7959555435894856),
    ContactPoint(
        position: Offset(732.8652347363594, 290.15176183024124),
        direction: 2.764331921641709),
    ContactPoint(
        position: Offset(723.3830284533086, 313.01971579939624),
        direction: 2.7327061425998926),
    ContactPoint(
        position: Offset(713.1824457619811, 335.5762106494377),
        direction: 2.701107784368995),
    ContactPoint(
        position: Offset(702.2741578251497, 357.8013217746728),
        direction: 2.669583187277759),
    ContactPoint(
        position: Offset(690.6722121263231, 379.670992424695),
        direction: 2.6380680654872704),
    ContactPoint(
        position: Offset(678.3857674347063, 401.16473017022344),
        direction: 2.6065913835148464),
    ContactPoint(
        position: Offset(665.4299905990202, 422.26269946049536),
        direction: 2.575189582554664),
    ContactPoint(
        position: Offset(651.8181566404344, 442.9438949196414),
        direction: 2.5438096597963566),
    ContactPoint(
        position: Offset(637.5643571435925, 463.18814968939125),
        direction: 2.512481399637682),
    ContactPoint(
        position: Offset(622.6836783392799, 482.97727367740123),
        direction: 2.4811763389411747),
    ContactPoint(
        position: Offset(607.1902877402789, 502.29105644629874),
        direction: 2.4499097284950024),
    ContactPoint(
        position: Offset(591.1017369221881, 521.1119106178336),
        direction: 2.4186517558146146),
    ContactPoint(
        position: Offset(574.431529471116, 539.4205107194238),
        direction: 2.3874227377916126),
    ContactPoint(
        position: Offset(557.1996539897581, 557.200386411642),
        direction: 2.356194490192345),
    ContactPoint(
        position: Offset(539.4194256916433, 574.4326153231676),
        direction: 2.324964687035802),
    ContactPoint(
        position: Offset(521.1109562292638, 591.1025718507093),
        direction: 2.2937347603525997),
    ContactPoint(
        position: Offset(502.29033590598976, 607.190888251907),
        direction: 2.2624779662956156),
    ContactPoint(
        position: Offset(482.9767853961424, 622.6840445502263),
        direction: 2.2312126414435145),
    ContactPoint(
        position: Offset(463.18742075907494, 637.5649649541612),
        direction: 2.1999072208884476),
    ContactPoint(
        position: Offset(442.9430811003659, 651.8187392984619),
        direction: 2.1685752200981385),
    ContactPoint(
        position: Offset(422.2616404154067, 665.430575776643),
        direction: 2.137195488336351),
    ContactPoint(
        position: Offset(401.1635222491496, 678.3863702109364),
        direction: 2.1057963586844206),
    ContactPoint(
        position: Offset(379.66976623139135, 690.672825502364),
        direction: 2.0743214372411005),
    ContactPoint(
        position: Offset(357.7995015510969, 702.2751288584169),
        direction: 2.0428047797047775),
    ContactPoint(
        position: Offset(335.5753953376425, 713.1827935044307),
        direction: 2.0112775864323833),
    ContactPoint(
        position: Offset(313.0185196324635, 723.3835061028674),
        direction: 1.979680609403765),
    ContactPoint(
        position: Offset(290.1509230193461, 732.8654726634485),
        direction: 1.9480556531209672),
    ContactPoint(
        position: Offset(266.99488602772044, 741.6198316283956),
        direction: 1.9164319746329328),
    ContactPoint(
        position: Offset(243.57411923456897, 749.637356449799),
        direction: 1.884754503974829),
    ContactPoint(
        position: Offset(219.91059669675582, 756.9079834888562),
        direction: 1.8530623789145562),
    ContactPoint(
        position: Offset(196.02884966636816, 763.4259120332745),
        direction: 1.8214142913983924),
    ContactPoint(
        position: Offset(171.95245918658506, 769.1852722521006),
        direction: 1.789786377574817),
    ContactPoint(
        position: Offset(147.7056099902352, 774.1806788734963),
        direction: 1.7581973826155401),
    ContactPoint(
        position: Offset(123.3124291574065, 778.4086678792552),
        direction: 1.7266704060485072),
    ContactPoint(
        position: Offset(98.79694385846254, 781.8665873303869),
        direction: 1.6952314475674024),
    ContactPoint(
        position: Offset(74.18394253228448, 784.5536844384123),
        direction: 1.663903951483947),
    ContactPoint(
        position: Offset(49.49730772717737, 786.4700171221597),
        direction: 1.6327158258088463),
    ContactPoint(
        position: Offset(24.76089747906536, 787.6177881995807),
        direction: 1.6016974271506905),
    ContactPoint(
        position: Offset(-0.0005213331877584481, 787.9999988406033),
        direction: 1.5707938982399474),
    ContactPoint(
        position: Offset(-24.762151521247628, 787.617667057097),
        direction: 1.5398927239959388),
    ContactPoint(
        position: Offset(-49.49828480865428, 786.4698951634391),
        direction: 1.5088766775008757),
    ContactPoint(
        position: Offset(-74.18513475898992, 784.553559544413),
        direction: 1.4776912330559746),
    ContactPoint(
        position: Offset(-98.79797839138098, 781.8665880037787),
        direction: 1.446360753891506),
    ContactPoint(
        position: Offset(-123.31338183309383, 778.4085499271679),
        direction: 1.4149200369320791),
    ContactPoint(
        position: Offset(-147.70668547779232, 774.1805616318774),
        direction: 1.3833931111476083),
    ContactPoint(
        position: Offset(-171.95346824556856, 769.1850349791512),
        direction: 1.3518036416353851),
    ContactPoint(
        position: Offset(-196.0298762358939, 763.4256713094966),
        direction: 1.3201772140722206),
    ContactPoint(
        position: Offset(-219.9118846519199, 756.9076161474627),
        direction: 1.288530612893025),
    ContactPoint(
        position: Offset(-243.57522086928444, 749.6371120873988),
        direction: 1.2568382094586337),
    ContactPoint(
        position: Offset(-266.99579922914853, 741.6195891603189),
        direction: 1.2251602675605149),
    ContactPoint(
        position: Offset(-290.15193002533243, 732.8652415633005),
        direction: 1.1935340504706407),
    ContactPoint(
        position: Offset(-313.01962329282145, 723.383029871411),
        direction: 1.161909518576575),
    ContactPoint(
        position: Offset(-335.5766766639746, 713.1823065104091),
        direction: 1.130314815573616),
    ContactPoint(
        position: Offset(-357.8010868671083, 702.2744140152635),
        direction: 1.098784652055178),
    ContactPoint(
        position: Offset(-379.6711485291518, 690.6721062080404),
        direction: 1.067268949149117),
    ContactPoint(
        position: Offset(-401.16468982595325, 678.3857565464716),
        direction: 1.0357968363982781),
    ContactPoint(
        position: Offset(-422.2628543672589, 665.4299905990291),
        direction: 1.0043932557597675),
    ContactPoint(
        position: Offset(-442.94383027401636, 651.8181606776579),
        direction: 0.9730127352266695),
    ContactPoint(
        position: Offset(-463.1886288494226, 637.5640991192803),
        direction: 0.9416870390636252),
    ContactPoint(
        position: Offset(-482.9775411209991, 622.6835636743249),
        direction: 0.9103790061697126),
    ContactPoint(
        position: Offset(-502.29109771728486, 607.1903060288314),
        direction: 0.8791110122969643),
    ContactPoint(
        position: Offset(-521.1118629884479, 591.1017271404107),
        direction: 0.8478566611211305),
    ContactPoint(
        position: Offset(-539.4204146003219, 574.4317514112198),
        direction: 0.8166291130418832),
    ContactPoint(
        position: Offset(-557.200542452605, 557.19963759681),
        direction: 0.7854000953278142),
    ContactPoint(
        position: Offset(-574.4325245480883, 539.4197773003319),
        direction: 0.7541700298168887),
    ContactPoint(
        position: Offset(-591.1024825115921, 521.1113225595099),
        direction: 0.7229384202997924),
    ContactPoint(
        position: Offset(-607.1908778174649, 502.290595446095),
        direction: 0.691679973270019),
    ContactPoint(
        position: Offset(-622.6843453636053, 482.97654985686574),
        direction: 0.6604154070323922),
    ContactPoint(
        position: Offset(-637.5648102934241, 463.1877930046472),
        direction: 0.6291102721347892),
    ContactPoint(
        position: Offset(-651.8187510278791, 442.94318934958017),
        direction: 0.5977802866937525),
    ContactPoint(
        position: Offset(-665.4305910239121, 422.2618882207577),
        direction: 0.5663987996321449),
    ContactPoint(
        position: Offset(-678.3862438174554, 401.1638162172047),
        direction: 0.5349952051655134),
    ContactPoint(
        position: Offset(-690.6727016159434, 379.66977373742805),
        direction: 0.5035243963105476),
    ContactPoint(
        position: Offset(-702.2748833209234, 357.79993733102833),
        direction: 0.472013365145056),
    ContactPoint(
        position: Offset(-713.1828322825647, 335.5756268731216),
        direction: 0.44048242091528245),
    ContactPoint(
        position: Offset(-723.3833316697311, 313.018941610747),
        direction: 0.40887921781993253),
    ContactPoint(
        position: Offset(-732.8653318430104, 290.15092805550006),
        direction: 0.37725887490219545),
    ContactPoint(
        position: Offset(-741.6199016868121, 266.9946338622125),
        direction: 0.3456363586142057),
    ContactPoint(
        position: Offset(-749.6373392461851, 243.573888225275),
        direction: 0.31395702666452774),
    ContactPoint(
        position: Offset(-756.9078367895041, 219.9108219518008),
        direction: 0.2822676907656776),
    ContactPoint(
        position: Offset(-763.4258614767597, 196.02903070007542),
        direction: 0.2506181428185865),
    ContactPoint(
        position: Offset(-769.1852263450654, 171.95232241235013),
        direction: 0.21899130608777284),
    ContactPoint(
        position: Offset(-774.1807649733288, 147.70546352473963),
        direction: 0.1874031249810777),
    ContactPoint(
        position: Offset(-778.4087282319289, 123.31228370582839),
        direction: 0.15587605160583085),
    ContactPoint(
        position: Offset(-781.866730667464, 98.79706693288699),
        direction: 0.12443503644522558),
    ContactPoint(
        position: Offset(-784.5537040940012, 74.18408830883764),
        direction: 0.09310564057595982),
    ContactPoint(
        position: Offset(-786.4700815333177, 49.497212830253126),
        direction: 0.061917230217906294),
    ContactPoint(
        position: Offset(-787.6177104814238, 24.760790446753003),
        direction: 0.03089984659133016),
    ContactPoint(
        position: Offset(-788.000000000004, -0.0006017350647240001),
        direction: 6.283184492518769),
    ContactPoint(
        position: Offset(-787.6176701227514, -24.76205542562676),
        direction: 6.252283869972954),
    ContactPoint(
        position: Offset(-786.4700027285264, -49.4984167442749),
        direction: 6.221266481573817),
    ContactPoint(
        position: Offset(-784.5535922367011, -74.18523028674943),
        direction: 6.190077991940107),
    ContactPoint(
        position: Offset(-781.8665632055393, -98.79832885307073),
        direction: 6.1587484116125175),
    ContactPoint(
        position: Offset(-778.408524778921, -123.31341738892002),
        direction: 6.127306867980815),
    ContactPoint(
        position: Offset(-774.1804573148652, -147.7068525695601),
        direction: 6.095780733276558),
    ContactPoint(
        position: Offset(-769.1849244405983, -171.95359177100227),
        direction: 6.064192746247873),
    ContactPoint(
        position: Offset(-763.425478962788, -196.03047213961548),
        direction: 6.032564951644082),
    ContactPoint(
        position: Offset(-756.9074383470141, -219.9120245766399),
        direction: 6.000915846613382),
    ContactPoint(
        position: Offset(-749.6368918043863, -243.5752367737907),
        direction: 5.969228583335035),
    ContactPoint(
        position: Offset(-741.6194980897435, -266.9959052127712),
        direction: 5.937547823124428),
    ContactPoint(
        position: Offset(-732.864857986834, -290.15218533493794),
        direction: 5.905924032008744),
    ContactPoint(
        position: Offset(-723.3828753350525, -313.0200216568664),
        direction: 5.874304190718491),
    ContactPoint(
        position: Offset(-713.1823446408574, -335.57667976490757),
        direction: 5.842701270138854),
    ContactPoint(
        position: Offset(-702.2743611634639, -357.8009688817357),
        direction: 5.811171159294308),
    ContactPoint(
        position: Offset(-690.6720953385462, -379.6709755145528),
        direction: 5.779658889597489),
    ContactPoint(
        position: Offset(-678.3856302513487, -401.1648052933887),
        direction: 5.748188133373928),
    ContactPoint(
        position: Offset(-665.4300667025872, -422.2627602383584),
        direction: 5.716784995505513),
    ContactPoint(
        position: Offset(-651.8181833459066, -442.9439672780824),
        direction: 5.685403221178805),
    ContactPoint(
        position: Offset(-637.5642840808933, -463.18850741493463),
        direction: 5.654076084980419),
    ContactPoint(
        position: Offset(-622.6837360145971, -482.9774772861529),
        direction: 5.6227676911307505),
    ContactPoint(
        position: Offset(-607.1903452872542, -502.2911389051172),
        direction: 5.591501147213351),
    ContactPoint(
        position: Offset(-591.101804321432, -521.1120039763024),
        direction: 5.560247743834868),
    ContactPoint(
        position: Offset(-574.4319787565527, -539.4204024614288),
        direction: 5.529016705506613),
    ContactPoint(
        position: Offset(-557.1998296196033, -557.200459560171),
        direction: 5.497786499810326),
    ContactPoint(
        position: Offset(-539.4196487286066, -574.4326872708159),
        direction: 5.46655652940272),
    ContactPoint(
        position: Offset(-521.1113165298741, -591.102417175935),
        direction: 5.43532493701356),
    ContactPoint(
        position: Offset(-502.290270372362, -607.1910488045742),
        direction: 5.404071357527272),
    ContactPoint(
        position: Offset(-482.9766661724441, -622.6843363761548),
        direction: 5.372805239346793),
    ContactPoint(
        position: Offset(-463.18754082755675, -637.5649787257877),
        direction: 5.341497174500143),
    ContactPoint(
        position: Offset(-442.9429378354382, -651.8188796975742),
        direction: 5.310170244228453),
    ContactPoint(
        position: Offset(-422.2618546079778, -665.4306707606581),
        direction: 5.278788314684067),
    ContactPoint(
        position: Offset(-401.16368977346036, -678.3863240775678),
        direction: 5.247384833825136),
    ContactPoint(
        position: Offset(-379.6699868846216, -690.6726726379369),
        direction: 5.215913642589987),
    ContactPoint(
        position: Offset(-357.79982390533183, -702.2749716443509),
        direction: 5.184401753667152),
    ContactPoint(
        position: Offset(-335.57557343536365, -713.1829060883642),
        direction: 5.152870915004059),
    ContactPoint(
        position: Offset(-313.0186955460606, -723.3834555784963),
        direction: 5.1212685835474785),
    ContactPoint(
        position: Offset(-290.1508272362291, -732.865447059806),
        direction: 5.08964889376592),
    ContactPoint(
        position: Offset(-266.9948864457594, -741.6198842227997),
        direction: 5.0580247965830845),
    ContactPoint(
        position: Offset(-243.57396556486228, -749.6373614080101),
        direction: 5.026344781689454),
    ContactPoint(
        position: Offset(-219.9107772652951, -756.9078517941991),
        direction: 4.994655453828484),
    ContactPoint(
        position: Offset(-196.02878991420462, -763.4259127099779),
        direction: 4.9630070340960675),
    ContactPoint(
        position: Offset(-171.95244648410824, -769.1851939907766),
        direction: 4.931380313571956),
    ContactPoint(
        position: Offset(-147.7055868749164, -774.180736560116),
        direction: 4.899792193492807),
    ContactPoint(
        position: Offset(-123.31228427279378, -778.4087237388625),
        direction: 4.868265179774566),
    ContactPoint(
        position: Offset(-98.79706936617819, -781.866728745795),
        direction: 4.83682400722076),
    ContactPoint(
        position: Offset(-74.18396732680696, -784.5537142224799),
        direction: 4.805494723956003),
    ContactPoint(
        position: Offset(-49.49733803496542, -786.4700733765175),
        direction: 4.774306142511544),
    ContactPoint(
        position: Offset(-24.76079218211159, -787.6177095159745),
        direction: 4.7432888756254385),
    ContactPoint(
        position: Offset(0.000660380198622263, -788.0000000000041),
        direction: 4.712388159794754),
    ContactPoint(
        position: Offset(24.762052088108078, -787.6176688727304),
        direction: 4.681487458250366),
    ContactPoint(
        position: Offset(49.498415666545434, -786.4700002673833),
        direction: 4.650470258406129),
    ContactPoint(
        position: Offset(74.18498462800447, -784.5536112354064),
        direction: 4.619281732164911),
    ContactPoint(
        position: Offset(98.79820895088305, -781.8665750420495),
        direction: 4.58795246164785),
    ContactPoint(
        position: Offset(123.31336003404745, -778.4085390949152),
        direction: 4.556511047251389),
    ContactPoint(
        position: Offset(147.7067259526592, -774.1804958842703),
        direction: 4.524984217530374),
    ContactPoint(
        position: Offset(171.9534644610746, -769.1849422567732),
        direction: 4.493396170102497),
    ContactPoint(
        position: Offset(196.02999641467545, -763.4255819662238),
        direction: 4.461769904423033),
    ContactPoint(
        position: Offset(219.91185666023287, -756.9075324516191),
        direction: 4.430121038930376),
    ContactPoint(
        position: Offset(243.57509622894275, -749.6369771587082),
        direction: 4.398430841043866),
    ContactPoint(
        position: Offset(266.9958375985141, -741.6194843650227),
        direction: 4.366751118994808),
    ContactPoint(
        position: Offset(290.15188437409523, -732.864981282876),
        direction: 4.335128290884166),
    ContactPoint(
        position: Offset(313.01965256340554, -723.3830129083759),
        direction: 4.3035078127328825),
    ContactPoint(
        position: Offset(335.57659232084416, -713.182372128665),
        direction: 4.271905535496204),
    ContactPoint(
        position: Offset(357.80078195181596, -702.2744458553962),
        direction: 4.240374691631242),
    ContactPoint(
        position: Offset(379.6708681781428, -690.6721240913209),
        direction: 4.208864185232047),
    ContactPoint(
        position: Offset(401.1646552789815, -678.3857875691742),
        direction: 4.177392280495678),
    ContactPoint(
        position: Offset(422.262600509392, -665.4301536923664),
        direction: 4.145988192493277),
    ContactPoint(
        position: Offset(442.9436727846382, -651.8184033754077),
        direction: 4.114608205117205),
    ContactPoint(
        position: Offset(463.18839536388157, -637.5644193813382),
        direction: 4.083277884521401),
    ContactPoint(
        position: Offset(482.97725858559454, -622.6837839337956),
        direction: 4.051971073242955),
    ContactPoint(
        position: Offset(502.29096030582525, -607.190512725533),
        direction: 4.0207088609144055),
    ContactPoint(
        position: Offset(521.1119391754542, -591.1019887033897),
        direction: 3.9894512562534605),
    ContactPoint(
        position: Offset(539.420250100666, -574.4321118450226),
        direction: 3.958217180526977),
    ContactPoint(
        position: Offset(557.2002279126564, -557.1999521368655),
        direction: 3.9269865238187887),
    ContactPoint(
        position: Offset(574.4322310992155, -539.4198286550346),
        direction: 3.8957588214496144),
    ContactPoint(
        position: Offset(591.1020932438832, -521.1114358641386),
        direction: 3.8645323057285115),
    ContactPoint(
        position: Offset(607.1906692756753, -502.2906435326686),
        direction: 3.83327758082973),
    ContactPoint(
        position: Offset(622.6839216600462, -482.9770939462654),
        direction: 3.8020088568649486),
    ContactPoint(
        position: Offset(637.5644628075822, -463.1880829993391),
        direction: 3.7707015840639615),
    ContactPoint(
        position: Offset(651.8185222729888, -442.9433487715544),
        direction: 3.739375561744256),
    ContactPoint(
        position: Offset(665.4303436139862, -422.2622647672005),
        direction: 3.7079936753043086),
    ContactPoint(
        position: Offset(678.385998793256, -401.1642047402129),
        direction: 3.6765918344399555),
    ContactPoint(
        position: Offset(690.6724762542093, -379.6705006981277),
        direction: 3.6451206936006924),
    ContactPoint(
        position: Offset(702.2747729430264, -357.8004602647338),
        direction: 3.613602993472651),
    ContactPoint(
        position: Offset(713.1825414167255, -335.5761469379938),
        direction: 3.5820723599999695),
    ContactPoint(
        position: Offset(723.3831459168283, -313.0193015038622),
        direction: 3.5504781990074212),
    ContactPoint(
        position: Offset(732.8653626449204, -290.1515052743839),
        direction: 3.5188547062561755),
    ContactPoint(
        position: Offset(741.6197062129949, -266.99544695256475),
        direction: 3.4872274786379593),
    ContactPoint(
        position: Offset(749.6372313782501, -243.5746190778568),
        direction: 3.4555500209195023),
    ContactPoint(
        position: Offset(756.9077416091463, -219.91138467663174),
        direction: 3.423859382147395),
    ContactPoint(
        position: Offset(763.425794276032, -196.02944548890855),
        direction: 3.3922120674608656),
    ContactPoint(
        position: Offset(769.1851494940803, -171.953074946982),
        direction: 3.3605824405727565),
    ContactPoint(
        position: Offset(774.1805562974004, -147.70616429273602),
        direction: 3.32899348318109),
    ContactPoint(
        position: Offset(778.4085516831174, -123.31294341333451),
        direction: 3.29746988601853),
    ContactPoint(
        position: Offset(781.8665877793051, -98.79773604529127),
        direction: 3.266028075782526),
    ContactPoint(
        position: Offset(784.5535592925074, -74.18464917542154),
        direction: 3.234697521543267),
    ContactPoint(
        position: Offset(786.4698949960426, -49.49792129756199),
        direction: 3.2035120774639796),
    ContactPoint(
        position: Offset(787.6176670153532, -24.761481484582745),
        direction: 3.172496143829779),
    ContactPoint(
        position: Offset(787.9999988405591, -0.000001159432032742021),
        direction: 3.141592653589793),
  ],
  holes: [],
  isRing: true,
  isRound: true,
  smallestConvexDiff: 6.283185307179586,
  biggestConvexDiff: 0,
  smallestConcaveDiff: 0.030900622545814826,
  biggestConcaveDiff: 0.03169294818038626,
  ovalClipper: null,
  pathClipper: const _Circle200ringClipper(),
);
