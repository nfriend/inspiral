import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';
import 'package:tinycolor/tinycolor.dart';

class ModalProgress extends StatelessWidget {
  final Widget child;

  ModalProgress({@required this.child});

  @override
  Widget build(BuildContext context) {
    final ProgressState progress = Provider.of<ProgressState>(context);
    final TinyColor primaryColor =
        context.select<ColorState, TinyColor>((colors) => colors.primaryColor);

    if (!progress.isLoading) {
      return child;
    }

    Animation<Color> indicatorColor =
        AlwaysStoppedAnimation<Color>(primaryColor.color);

    List<Widget> columnChildren = [];

    if (!isBlank(progress.loadingMessage)) {
      columnChildren.add(Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Text(progress.loadingMessage,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600))));
    }

    columnChildren.add(
        CircularProgressIndicator(value: null, valueColor: indicatorColor));

    return Stack(children: [
      Positioned.fill(child: child),
      Positioned.fill(
          child: Container(
              color: Color(0xAA000000),
              child: Align(
                  alignment: Alignment.center,
                  child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: columnChildren))))),
    ]);
  }
}
