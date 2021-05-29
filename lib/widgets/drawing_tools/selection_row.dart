import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/util/reverse_if.dart';
import 'package:inspiral/util/should_render_landscape_mode.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

class SelectionrRowDefinition {
  final String label;
  final List<Widget> children;
  final String storageKey;

  SelectionrRowDefinition(
      {required this.label,
      required this.children,
      required this.storageKey});
}

class SelectionRows extends StatelessWidget {
  final Iterable<SelectionrRowDefinition> rowDefs;

  SelectionRows({required this.rowDefs});

  @override
  Widget build(BuildContext context) {
    final uiTextColor =
        context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);
    final useLandscapeMode = shouldRenderLandscapeMode(context);
    final padding = 2.5;

    var textStyle =
        TextStyle(color: uiTextColor.color, fontWeight: FontWeight.bold);

    return Padding(
        padding: EdgeInsets.all(padding),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          for (var def in rowDefs)
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: reverseIf(condition: useLandscapeMode, list: [
                          Padding(
                              padding: EdgeInsets.only(right: padding / 2),
                              child: Center(
                                  child: RotatedBox(
                                      quarterTurns: useLandscapeMode ? 1 : 3,
                                      child:
                                          Text(def.label, style: textStyle)))),
                          Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  key: PageStorageKey(def.storageKey),
                                  scrollDirection: Axis.horizontal,
                                  reverse: useLandscapeMode,
                                  itemExtent: thumbnailSize + 10.0,
                                  itemCount: def.children.length,
                                  itemBuilder: (context, index) {
                                    var child = def.children[index];

                                    return useLandscapeMode
                                        ? RotatedBox(
                                            quarterTurns: 1, child: child)
                                        : child;
                                  }))
                        ]))))
        ]));
  }
}
