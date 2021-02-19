import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:provider/provider.dart';

class GearSelectorThumbnail extends StatelessWidget {
  final String assetPath;
  final bool isActive;
  final Function onGearTap;

  GearSelectorThumbnail(
      {@required this.assetPath,
      @required this.isActive,
      @required this.onGearTap});

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<ColorState>(context);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(children: [
          Positioned.fill(
              child: Container(
                  color: isActive ? colors.activeColor.color : null,
                  child: Center(
                      child: ColorFiltered(
                          colorFilter: isActive
                              ? activeThumbnailGearColorFilter
                              : noFilterColorFilter,
                          child: Image.asset(assetPath,
                              width: thumbnailSize, height: thumbnailSize))))),
          Positioned.fill(
              child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: onGearTap,
                  )))
        ]));
  }
}
