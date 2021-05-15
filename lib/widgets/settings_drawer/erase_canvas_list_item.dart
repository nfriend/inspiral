import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/widgets/helpers/show_confirmation_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class EraseCanvasListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = Provider.of<InkState>(context, listen: false);
    final snapPoints = Provider.of<SnapPointState>(context, listen: false);
    final inkIsBaking = context.select<InkState, bool>((ink) => ink.isBaking);
    final isUndoingOrRedoing = context
        .select<UndoRedoState, bool>((undoRedo) => undoRedo.isUndoingOrRedoing);
    var eraseAvailable = !inkIsBaking && !isUndoingOrRedoing;
    final disabledTextColor = context
        .select<ColorState, TinyColor>((colors) => colors.disabledTextColor);

    return ListTile(
        title: eraseAvailable
            ? Text('Erase canvas')
            : Text('One moment...',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: disabledTextColor.color)),
        onTap: eraseAvailable
            ? () {
                showConfirmationDialog(
                    context: context,
                    message: 'Are you sure you want to erase your masterpiece?',
                    confirmButtonText: 'Erase',
                    onConfirm: () {
                      Navigator.of(context).pop();
                      ink.eraseCanvas();
                      snapPoints.eraseAllSnapPoints();
                    });
              }
            : null);
  }
}
