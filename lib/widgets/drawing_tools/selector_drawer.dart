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

    Matrix4 transform = Matrix4.identity();
    double opacity = 1.0;
    double height = 200;

    if (!selectorDrawer.isOpen ||
        rotatingGearIsDragging ||
        fixedGearIsDragging ||
        canvasIsTransforming) {
      transform.translate(0.0, height);
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
            child: Container(
                color: uiBackgroundColor.color,
                height: 168,
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
                        ])))));
  }
}
