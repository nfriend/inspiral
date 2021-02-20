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
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(10.0));

    return Padding(
        padding: EdgeInsets.all(2.5),
        child: Material(
            borderRadius: borderRadius,
            color: isActive ? colors.activeColor.color : Colors.transparent,
            child: InkWell(
                onTap: onGearTap,
                borderRadius: borderRadius,
                child: ColorFiltered(
                    colorFilter: isActive
                        ? activeThumbnailGearColorFilter
                        : noFilterColorFilter,
                    child: Image.asset(assetPath,
                        width: thumbnailSize, height: thumbnailSize)))));
  }
}
