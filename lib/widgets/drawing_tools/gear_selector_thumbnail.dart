import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/if_purchased.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:inspiral/widgets/drawing_tools/crown_image.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class GearSelectorThumbnail extends StatelessWidget {
  final GearDefinition gear;
  final bool isActive;
  final Function onGearTap;

  GearSelectorThumbnail(
      {@required this.gear, @required this.isActive, @required this.onGearTap});

  @override
  Widget build(BuildContext context) {
    final purchases = Provider.of<PurchasesState>(context);
    final bool isDark =
        context.select<ColorState, bool>((colors) => colors.isDark);
    final TinyColor activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final TinyColor uiTextColor =
        context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(10.0));
    final Widget crown =
        purchases.purchased(gear.product) ? Container() : CrownImage();

    Color toothCountTextColor;
    Color toothCountBubbleBackgroundColor;
    Color toothCountBubbleBorderColor;
    if (isActive) {
      toothCountTextColor = isDark ? Colors.white : Colors.black;
      toothCountBubbleBackgroundColor =
          isDark ? Color(0xFF222222) : Colors.white;
      toothCountBubbleBorderColor =
          isDark ? Color(0xFFF0F0F0) : Color(0xFF666666);
    } else {
      toothCountTextColor = uiTextColor.color;
      toothCountBubbleBackgroundColor =
          isDark ? Color(0xFF333333) : Color(0xFFF3F3F3);
      toothCountBubbleBorderColor =
          isDark ? Color(0xFFD0D0D0) : Color(0xFF888888);
    }

    TextStyle toothCountTextStyle =
        TextStyle(fontWeight: FontWeight.bold, color: toothCountTextColor);

    return Stack(children: [
      Positioned.fill(
          child: Padding(
              padding: EdgeInsets.all(2.5),
              child: Material(
                  borderRadius: borderRadius,
                  color: isActive ? activeColor.color : Colors.transparent,
                  child: InkWell(
                      onTap: ifPurchased(context, gear.product, onGearTap),
                      borderRadius: borderRadius,
                      child: ColorFiltered(
                          colorFilter: isActive
                              ? activeThumbnailGearColorFilter
                              : noFilterColorFilter,
                          child: Image.asset(gear.thumbnailImage,
                              width: thumbnailSize, height: thumbnailSize)))))),
      Positioned(
          bottom: 0,
          left: 0,
          child: Container(
              decoration: BoxDecoration(
                  color: toothCountBubbleBackgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2.0, color: toothCountBubbleBorderColor)),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    gear.toothCount.toString(),
                    style: toothCountTextStyle,
                  )))),
      crown
    ]);
  }
}
