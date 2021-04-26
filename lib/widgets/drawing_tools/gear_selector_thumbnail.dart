import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/if_purchased.dart';
import 'package:inspiral/widgets/color_filters.dart';
import 'package:inspiral/widgets/drawing_tools/crown_if_not_entitled.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class GearSelectorThumbnail extends StatelessWidget {
  final GearDefinition gear;
  final bool isActive;
  final void Function() onGearTap;

  /// Whether or not this gear is compatible with the currently selected
  /// fixed gear. Only applies when showing a rotating gear.
  final bool isCompatibleWithFixedGear;

  GearSelectorThumbnail(
      {@required this.gear,
      @required this.isActive,
      @required this.onGearTap,
      this.isCompatibleWithFixedGear = true});

  @override
  Widget build(BuildContext context) {
    final snackbar = Provider.of<SnackbarState>(context, listen: false);
    final isDark = context.select<ColorState, bool>((colors) => colors.isDark);
    final activeColor =
        context.select<ColorState, TinyColor>((colors) => colors.activeColor);
    final uiTextColor =
        context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);
    final borderRadius = BorderRadius.all(Radius.circular(10.0));

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

    ColorFilter gearFilter;
    if (!isCompatibleWithFixedGear) {
      // Incompatible rotating gears are rendered partially transparent
      gearFilter = disabledThumbnailGearColorFilter;
      toothCountBubbleBackgroundColor = toothCountBubbleBackgroundColor
          .withOpacity(incompatibleGearDisplayOpacity);
      toothCountBubbleBorderColor = toothCountBubbleBorderColor
          .withOpacity(incompatibleGearDisplayOpacity);
      toothCountTextColor =
          toothCountTextColor.withOpacity(incompatibleGearDisplayOpacity);
    } else if (isActive) {
      gearFilter = activeThumbnailGearColorFilter;
    } else {
      gearFilter = noFilterColorFilter;
    }

    var toothCountTextStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: toothCountTextColor,
        letterSpacing: gear.toothCount > 99 ? -1.5 : 0);

    return Stack(children: [
      Positioned.fill(
          child: Padding(
              padding: EdgeInsets.all(2.5),
              child: Material(
                  borderRadius: borderRadius,
                  color: isActive ? activeColor.color : Colors.transparent,
                  child: InkWell(
                      onTap: ifPurchased(
                          context: context,
                          entitlement: gear.entitlement,
                          package: gear.package,
                          callbackIfPurchased: () {
                            if (isCompatibleWithFixedGear) {
                              onGearTap();
                            } else {
                              snackbar.showSnackbar(
                                  'This gear is not compatible with the currently selected fixed gear');
                            }
                          }),
                      borderRadius: borderRadius,
                      child: ColorFiltered(
                          colorFilter: gearFilter,
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
      CrownIfNotEntitled(entitlement: gear.entitlement)
    ]);
  }
}
