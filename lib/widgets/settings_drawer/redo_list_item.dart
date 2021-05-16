import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class RedoListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final undoRedo = Provider.of<UndoRedoState>(context, listen: false);
    final redoAvailable = context
        .select<UndoRedoState, bool>((undoRedo) => undoRedo.redoAvailable);
    final isRedoing =
        context.select<UndoRedoState, bool>((undoRedo) => undoRedo.isRedoing);
    final disabledTextColor = context
        .select<ColorState, TinyColor>((colors) => colors.disabledTextColor);

    TextStyle textStyle;
    Color iconColor;
    if (!redoAvailable) {
      var disabledColor = disabledTextColor.color;
      textStyle = TextStyle(fontStyle: FontStyle.italic, color: disabledColor);
      iconColor = disabledColor;
    }

    return ListTile(
        title: Row(children: [
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                isRedoing ? Icons.hourglass_bottom : Icons.redo,
                color: iconColor,
              )),
          Text(
            'Redo',
            style: textStyle,
          )
        ]),
        onTap: redoAvailable
            ? () async {
                Navigator.of(context).pop();
                await undoRedo.triggerRedo();
              }
            : null);
  }
}
