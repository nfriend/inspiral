import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/util/reverse_if.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';
import 'package:tinycolor/tinycolor.dart';

class SelectionrRowDefinition {
  final String label;
  final List<Widget> children;
  final String storageKey;

  SelectionrRowDefinition(
      {@required this.label,
      @required this.children,
      @required this.storageKey});
}

class SelectionRows extends StatelessWidget {
  final Iterable<SelectionrRowDefinition> rowDefs;

  SelectionRows({@required this.rowDefs});

  @override
  Widget build(BuildContext context) {
    final uiTextColor =
        context.select<ColorState, TinyColor>((colors) => colors.uiTextColor);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
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
                        children: reverseIf(condition: isLandscape, list: [
                          Padding(
                              padding: EdgeInsets.only(right: padding / 2),
                              child: Center(
                                  child: RotatedBox(
                                      quarterTurns: isLandscape ? 1 : 3,
                                      child:
                                          Text(def.label, style: textStyle)))),
                          Expanded(
                              child: ListView.builder(
                                  key: PageStorageKey(def.storageKey),
                                  scrollDirection: Axis.horizontal,
                                  reverse: isLandscape,
                                  itemExtent: thumbnailSize + 10.0,
                                  itemCount: def.children.length,
                                  itemBuilder: (context, index) {
                                    var child = def.children[index];

                                    return isLandscape
                                        ? RotatedBox(
                                            quarterTurns: 1, child: child)
                                        : child;
                                  }))
                        ]))))
        ]));
  }
}
