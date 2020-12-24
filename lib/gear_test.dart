import 'package:flutter/material.dart';
import 'package:statsfl/statsfl.dart';

class GearTest extends StatefulWidget {
  GearTest({Key key}) : super(key: key);

  @override
  _GearTestState createState() => _GearTestState();
}

class _GearTestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var gradient = RadialGradient(
      center: const Alignment(0.7, -0.6),
      radius: 0.2,
      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_GearTestPainter oldDelegate) => false;
}

class _GearTestState extends State<GearTest> {
  double posx = 100.0;
  double posy = 100.0;
  double dragOffsetX = 0;
  double dragOffsetY = 0;
  bool isDraggingGear = false;
  GlobalKey _customPaintKey = GlobalKey();

  void _onGearPointerDown(PointerDownEvent event) {
    final RenderBox box = _customPaintKey.currentContext.findRenderObject();
    final Offset offset = box.globalToLocal(event.position);
    setState(() {
      dragOffsetX = offset.dx - posx;
      dragOffsetY = offset.dy - posy;
    });
    setState(() {
      isDraggingGear = true;
    });
  }

  void _onGlobalPointerUp(PointerUpEvent event) {
    setState(() {
      isDraggingGear = false;
    });
  }

  void _onGlobalPointerMove(PointerMoveEvent event, BuildContext context) {
    if (isDraggingGear) {
      final RenderBox box = _customPaintKey.currentContext.findRenderObject();
      final Offset offset = box.globalToLocal(event.position);
      setState(() {
        posx = offset.dx - dragOffsetX;
        posy = offset.dy - dragOffsetY;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatsFl(
        child: Listener(
            onPointerMove: (event) => {_onGlobalPointerMove(event, context)},
            child: Column(children: [
              AppBar(title: const Text('Inspiral')),
              Expanded(
                child: InteractiveViewer(
                  panEnabled: true,
                  child: Stack(children: [
                    Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(
                            key: _customPaintKey, painter: _GearTestPainter())),
                    Positioned(
                        left: posx - 50,
                        top: posy - 50,
                        child: Listener(
                            onPointerDown: _onGearPointerDown,
                            onPointerUp: _onGlobalPointerUp,
                            child:
                                Image.asset('images/gear_84.png', width: 100)))
                  ]),
                ),
              )
            ])));
  }
}
