import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class AnimatedToolbarContainer extends StatelessWidget {
  final Widget child;
  final double translateY;
  final double translateX;

  AnimatedToolbarContainer(
      {required this.child, this.translateY = 0.0, this.translateX = 0.0});

  @override
  Widget build(BuildContext context) {
    final rotatingGearIsDragging = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isDragging);
    final fixedGearIsDragging = context
        .select<FixedGearState, bool>((fixedGear) => fixedGear.isDragging);
    final canvasIsTransforming =
        context.select<CanvasState, bool>((canvas) => canvas.isTransforming);

    var transform = Matrix4.identity();
    if (rotatingGearIsDragging || fixedGearIsDragging || canvasIsTransforming) {
      transform.translate(translateX, translateY);
    }

    return AnimatedContainer(
        transform: transform,
        duration: uiAnimationDuration,
        curve: Curves.easeOut,
        child: child);
  }
}
