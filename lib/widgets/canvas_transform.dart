import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/extensions/extensions.dart';

class CanvasTransform extends StatefulWidget {
  final Widget child;

  CanvasTransform({@required this.child});

  @override
  _CanvasTransformState createState() => _CanvasTransformState();
}

class _CanvasTransformState extends State<CanvasTransform>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: uiAnimationDuration,
      vsync: this,
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelectingHole =
        context.select<CanvasState, bool>((canvas) => canvas.isSelectingHole);
    final Matrix4 canvasTransform =
        context.select<CanvasState, Matrix4>((canvas) => canvas.transform);
    final bool areGearsVisible = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isVisible);
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    bool zoomToRotatingGear = isSelectingHole && areGearsVisible;

    if (!zoomToRotatingGear && _animationController.isDismissed) {
      // If we're not selecting a hole, and any previous animations have
      // finished, just return a basic `Transform` to save us from doing
      // all the extra computation below.
      return Transform(transform: canvasTransform, child: this.widget.child);
    }

    if (zoomToRotatingGear) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    final rotatingGear = Provider.of<RotatingGearState>(context, listen: false);
    double availableWidth = MediaQuery.of(context).size.width;
    double availableHeight = MediaQuery.of(context).size.height;
    final Size gearSize = rotatingGear.definition.size;

    // The amount of space, in logical pixels, that has already been claimed
    // by the UI (vertically, if in portrait mode, or horizontally,
    // if in landscape mode)
    final double unavailablePixels = menuBarHeight * 2.0 + selectorDrawerHeight;

    // Subtract the unavailable pixels from the relevant dimension
    if (isLandscape) {
      availableWidth -= unavailablePixels;
    } else {
      availableHeight -= unavailablePixels;
    }

    // Scale the gear so that it exactly fits in the available screen space
    final double newScale =
        min(availableWidth / gearSize.width, availableHeight / gearSize.height);

    Matrix4 gearViewTransform = Matrix4.identity();

    // Move the view by half the screen dimensions along the X axis
    // (to center the gear horizontally) and position the gear 50 logical
    // pixels from the top. This renders the gear slightly below
    // the menu bar.
    Offset centerTranslation;
    final double menuBarBuffer = menuBarHeight + 2.0;
    if (isLandscape) {
      centerTranslation =
          Offset(menuBarBuffer + (availableWidth / 2), availableHeight / 2);
    } else {
      centerTranslation =
          Offset(availableWidth / 2, menuBarBuffer + (availableHeight / 2));
    }

    gearViewTransform.translate(centerTranslation.toVector3());

    // Keep the same rotation as the current canvas
    double canvasRotation = canvasTransform.decompose2D().rotation;
    gearViewTransform.rotateZ(canvasRotation);

    gearViewTransform.scale(newScale);
    gearViewTransform
        .translate((-canvasCenter - rotatingGear.position).toVector3());

    return AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return Transform(
              transform: canvasTransform.interpolateTo(
                  gearViewTransform, _animation.value),
              child: this.widget.child);
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
