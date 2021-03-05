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
    final bool rotatingGearIsDragging = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isDragging);
    final bool fixedGearIsDragging = context
        .select<FixedGearState, bool>((fixedGear) => fixedGear.isDragging);
    final bool canvasIsTransforming =
        context.select<CanvasState, bool>((canvas) => canvas.isTransforming);

    Matrix4 transform = Matrix4.identity();
    if (rotatingGearIsDragging || fixedGearIsDragging || canvasIsTransforming) {
      transform.translate(0.0, translateY);
    }

    return AnimatedContainer(
        transform: transform,
        duration: uiAnimationDuration,
        curve: Curves.easeOut,
        child: child);
  }
}
