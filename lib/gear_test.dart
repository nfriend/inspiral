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

  void onDragUpdate(BuildContext context, DragUpdateDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatsFl(
        child: GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) =>
                onDragUpdate(context, details),
            onHorizontalDragUpdate: (DragUpdateDetails details) =>
                onDragUpdate(context, details),
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
                        child: CustomPaint(painter: _GearTestPainter())),
                    Positioned(
                        left: posx - 50,
                        top: posy - 50,
                        child: Image.asset('images/gear_84.png', width: 100))
                  ]),
                ),
              )
            ])));
  }
}
