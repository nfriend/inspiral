import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/should_render_landscape_mode.dart';
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
    final selectorDrawer = Provider.of<SelectorDrawerState>(context);
    final uiBackgroundColor = context
        .select<ColorState, TinyColor>((colors) => colors.uiBackgroundColor);
    final rotatingGearIsDragging = context.select<RotatingGearState, bool>(
        (rotatingGear) => rotatingGear.isDragging);
    final fixedGearIsDragging = context
        .select<FixedGearState, bool>((fixedGear) => fixedGear.isDragging);
    final canvasIsTransforming =
        context.select<CanvasState, bool>((canvas) => canvas.isTransforming);
    final useLandscapeMode = shouldRenderLandscapeMode(context);
    final viewPadding = useLandscapeMode
        ? MediaQuery.of(context).viewPadding.right
        : MediaQuery.of(context).viewPadding.bottom;

    var transform = Matrix4.identity()
      ..translate(useLandscapeMode ? -menuBarHeight - viewPadding : 0.0,
          useLandscapeMode ? 0.0 : -menuBarHeight - viewPadding);
    var opacity = 1.0;
    var height = menuBarHeight + selectorDrawerHeight + viewPadding;

    if (!selectorDrawer.isOpen ||
        rotatingGearIsDragging ||
        fixedGearIsDragging ||
        canvasIsTransforming) {
      transform.translate(
          useLandscapeMode ? height : 0.0, useLandscapeMode ? 0.0 : height);
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

    return AnimatedContainer(
        duration: uiAnimationDuration,
        curve: Curves.easeOut,
        transform: transform,
        child: AnimatedOpacity(
            duration: uiAnimationDuration,
            curve: Curves.easeOut,
            opacity: opacity,
            child: RotatedBox(
                quarterTurns: useLandscapeMode ? 3 : 0,
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
                            ]))))));
  }
}
