import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

const _dotGradient = LinearGradient(
    begin: Alignment(0.0, -1.0),
    end: Alignment(0.0, 1.0),
    colors: [Color(0xFFA4E2EB), Color(0xFF30B5C9)]);

class SnapPoints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFixedGearVisible =
        context.select<FixedGearState, bool>((state) => state.isVisible);
    final snapPointsState = Provider.of<SnapPointState>(context);

    if (!isFixedGearVisible || !snapPointsState.areVisible) {
      return Container();
    }

    return IgnorePointer(
        child: Stack(children: [
      for (var point in snapPointsState.snapPoints)
        Positioned(
            left: point.dx + canvasPadding - snapPointOuterSize.width / 2,
            top: point.dy + canvasPadding - snapPointOuterSize.height / 2,
            child: Container(
                width: snapPointOuterSize.width,
                height: snapPointOuterSize.height,
                decoration: snapPointsState.activeSnapPoint == point
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 4.0, color: const Color(0xFF30B5C9)))
                    : null,
                child: Center(
                    child: Container(
                        width: snapPointInnerSize.width,
                        height: snapPointInnerSize.height,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0, color: const Color(0xFF777777)),
                            shape: BoxShape.circle,
                            gradient: _dotGradient)))))
    ]));
  }
}
