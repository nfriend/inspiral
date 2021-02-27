import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/state/state.dart';

class SelectionrRowDefinition {
  final String label;
  final List<Widget> children;

  SelectionrRowDefinition({@required this.label, @required this.children});
}

class SelectionRows extends StatefulWidget {
  final Iterable<SelectionrRowDefinition> rowDefs;

  SelectionRows({this.rowDefs});

  @override
  _SelectionRowsState createState() => _SelectionRowsState();
}

class _SelectionRowsState extends State<SelectionRows>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // Required by AutomaticKeepAliveClientMixin
    super.build(context);

    final colors = Provider.of<ColorState>(context);
    final double padding = 2.5;

    TextStyle textStyle =
        TextStyle(color: colors.uiTextColor.color, fontWeight: FontWeight.bold);

    return Padding(
        padding: EdgeInsets.all(padding),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          for (var def in this.widget.rowDefs)
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: padding / 2),
                              child: Center(
                                  child: RotatedBox(
                                      quarterTurns: 3,
                                      child:
                                          Text(def.label, style: textStyle)))),
                          Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemExtent: thumbnailSize + 10.0,
                                  itemCount: def.children.length,
                                  itemBuilder: (context, index) =>
                                      def.children[index]))
                        ])))
        ]));
  }
}
