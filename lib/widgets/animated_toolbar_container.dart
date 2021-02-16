import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class AnimatedToolbarContainer extends StatelessWidget {
  final Widget child;
  final double translateY;

  AnimatedToolbarContainer({@required this.child, @required this.translateY});

  @override
  Widget build(BuildContext context) {
    final rotatingGear = Provider.of<RotatingGearState>(context);
    final fixedGear = Provider.of<FixedGearState>(context);
    final canvas = Provider.of<CanvasState>(context);

    Matrix4 transform = Matrix4.identity();
    if (rotatingGear.isDragging ||
        fixedGear.isDragging ||
        canvas.isTransforming) {
      transform.translate(0.0, translateY);
    }

    return AnimatedContainer(
        transform: transform,
        duration: uiAnimationDuration,
        curve: Curves.easeOut,
        child: child);
  }
}
