import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/models.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/extensions/extensions.dart';
import 'package:tinycolor/tinycolor.dart';

class HoleSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSelectingHole =
        context.select<CanvasState, bool>((canvas) => canvas.isSelectingHole);
    final activeHole = context.select<RotatingGearState, GearHole>(
        (rotatingGear) => rotatingGear.activeHole);
    final areGearsVisible = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isVisible);
    final canvasSize =
        context.select<CanvasState, Size>((canvas) => canvas.canvasSize);

    if (!isSelectingHole || !areGearsVisible) {
      return Container();
    }

    final gear = Provider.of<RotatingGearState>(context);
    final isDark = context.select<ColorState, bool>((colors) => colors.isDark);
    var penColor =
        context.select<ColorState, TinyColor>((colors) => colors.penColor);

    // If the pen color is fully transparent, replace it with a generic gray
    // so that the user has some visual indication which hole is active
    if (penColor.color == Colors.transparent) {
      penColor = TinyColor(Color(isDark ? 0xBBCCCCCC : 0xBB555555));
    }

    final inactivePenColor = isDark
        ? penColor.desaturate(50).darken()
        : penColor.desaturate(50).lighten();
    final dotSize = inkDotSize * 2;

    return Stack(children: [
      AbsorbPointer(
          child: Container(width: canvasSize.width, height: canvasSize.height)),
      Transform.translate(
          offset: gear.position - gear.definition.center,
          child: Transform.rotate(
              origin: gear.definition.center -
                  gear.definition.size.toOffset() / 2.0,
              angle: gear.rotation,
              child: Container(
                  width: gear.definition.size.width,
                  height: gear.definition.size.height,
                  child: Stack(children: [
                    for (GearHole hole in gear.definition.holes)
                      if (hole == activeHole)
                        Transform.translate(
                            offset: _getHoleOffset(
                                hole: hole,
                                gearCenter: gear.definition.center,
                                dotSize: dotSize),
                            child: Container(
                              width: dotSize.width,
                              height: dotSize.height,
                              decoration: BoxDecoration(
                                  color: penColor.color,
                                  shape: BoxShape.circle),
                            ))
                      else
                        Transform.translate(
                            offset: _getHoleOffset(
                                hole: hole,
                                gearCenter: gear.definition.center,
                                dotSize: dotSize),
                            child: Listener(
                                onPointerDown: (event) {
                                  gear.activeHole = hole;
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  margin: EdgeInsets.all(dotSize.width / 4),
                                  width: dotSize.width / 2,
                                  height: dotSize.height / 2,
                                  decoration: BoxDecoration(
                                      color: inactivePenColor.color,
                                      shape: BoxShape.circle),
                                )))
                  ]))))
    ]);
  }

  Offset _getHoleOffset({GearHole hole, Offset gearCenter, Size dotSize}) {
    return hole.relativeOffset + gearCenter - (dotSize / 2).toOffset();
  }
}
