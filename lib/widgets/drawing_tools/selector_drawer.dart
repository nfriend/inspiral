import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/drawing_tools/pen_selector.dart';
import 'package:inspiral/widgets/drawing_tools/gear_selector.dart';
import 'package:inspiral/widgets/drawing_tools/tools_selector.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class SelectorDrawer extends StatefulWidget {
  @override
  _SelectorDrawerState createState() => _SelectorDrawerState();
}

class _SelectorDrawerState extends State<SelectorDrawer>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SelectorDrawerState selectorDrawer =
        Provider.of<SelectorDrawerState>(context);
    final TinyColor uiBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.uiBackgroundColor);
    final bool rotatingGearIsDragging = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isDragging);
    final bool fixedGearIsDragging = context
        .select<FixedGearState, bool>((fixedGear) => fixedGear.isDragging);
    final bool canvasIsTransforming =
        context.select<CanvasState, bool>((canvas) => canvas.isTransforming);
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Matrix4 transform = Matrix4.identity()
      ..translate(isLandscape ? -menuBarHeight : 0.0,
          isLandscape ? 0.0 : -menuBarHeight);
    double opacity = 1.0;
    double height = menuBarHeight + selectorDrawerHeight;

    if (!selectorDrawer.isOpen ||
        rotatingGearIsDragging ||
        fixedGearIsDragging ||
        canvasIsTransforming) {
      transform.translate(
          isLandscape ? height : 0.0, isLandscape ? 0.0 : height);
      opacity = 0.0;
    }

    _tabController.animateTo(selectorDrawer.activeTab.index);

    // Listen for changes to the active tab due to swipes, and update
    // our provider state to keep them in sync.
    _tabController.addListener(() {
      if (_tabController.index != selectorDrawer.activeTab.index) {
        selectorDrawer.syncActiveTab(
            newActiveTab: DrawerTab.values[_tabController.index]);
      }
    });

    return WillPopScope(
        onWillPop: () async {
          // When Android's back button is pressed, and the drawer is open,
          // close the drawer and prevent the default behavior.
          if (selectorDrawer.isOpen) {
            selectorDrawer.closeDrawer();
            return false;
          }

          // Otherwise, allow the native behavior to continue.
          return true;
        },
        child: AnimatedContainer(
            duration: uiAnimationDuration,
            curve: Curves.easeOut,
            transform: transform,
            child: AnimatedOpacity(
                duration: uiAnimationDuration,
                curve: Curves.easeOut,
                opacity: opacity,
                child: RotatedBox(
                    quarterTurns: isLandscape ? 3 : 0,
                    child: Container(
                        color: uiBackgroundColor.color,
                        height: selectorDrawerHeight,
                        child: GestureDetector(
                            onPanUpdate: (details) {
                              if (details.delta.dy > 0) {
                                selectorDrawer.closeDrawer();
                              }
                            },
                            child: TabBarView(
                                controller: _tabController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  ToolsSelector(),
                                  PenSelector(),
                                  GearSelector(),
                                ])))))));
  }
}
