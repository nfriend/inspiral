import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/menu_bar.dart';
import 'package:provider/provider.dart';

class MenuBarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rotatingGear = Provider.of<RotatingGearState>(context);
    final fixedGear = Provider.of<FixedGearState>(context);

    Matrix4 transform = Matrix4.identity();
    if (rotatingGear.isDragging || fixedGear.isDragging) {
      transform.translate(0.0, -42.0);
    }

    return AnimatedContainer(
        transform: transform,
        duration: uiAnimationDuration,
        curve: Curves.easeOut,
        child: MenuBar());
  }
}
