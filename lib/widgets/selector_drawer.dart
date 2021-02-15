import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

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
    final colors = context.watch<ColorState>();
    final selectorDrawer = Provider.of<SelectorDrawerState>(context);
    final rotatingGear = Provider.of<RotatingGearState>(context);
    final fixedGear = Provider.of<FixedGearState>(context);

    Matrix4 transform = Matrix4.identity();
    double opacity = 1.0;
    double height = 200;

    if (!selectorDrawer.isOpen ||
        rotatingGear.isDragging ||
        fixedGear.isDragging) {
      transform.translate(0.0, height);
      opacity = 0.0;
    }

    _tabController.index = selectorDrawer.activeTab.index;

    return AnimatedContainer(
        duration: uiAnimationDuration,
        curve: Curves.easeOut,
        transform: transform,
        child: AnimatedOpacity(
            duration: uiAnimationDuration,
            curve: Curves.easeOut,
            opacity: opacity,
            child: Container(
                color: colors.uiBackgroundColor.color,
                height: 200,
                child: TabBarView(controller: _tabController, children: [
                  Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text("This is the Pen tab"))),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text("This is the Colors tab"))),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text("This is the Gears tab"))),
                ]))));
  }
}
