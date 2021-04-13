import 'package:flutter/material.dart';
import 'package:inspiral/models/entitlement.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

/// Special handling for global Android back button presses
class AndroidBackButtonHandler extends StatelessWidget {
  final Widget child;

  AndroidBackButtonHandler({@required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () => _onWillPop(context), child: child);
  }

  /// Handles the Android back button for the app.
  /// This is handled globally since Flutter doesn't currently have a way
  /// to specify multiple WillPopScopes.
  /// See https://github.com/flutter/flutter/issues/47088.
  Future<bool> _onWillPop(BuildContext context) async {
    final purchases = Provider.of<PurchasesState>(context, listen: false);
    final selectorDrawer =
        Provider.of<SelectorDrawerState>(context, listen: false);
    final colors = Provider.of<ColorState>(context, listen: false);

    // If the pen color delete buttons are shown, hide the delete buttons
    var isEntitledToDeletePenColors =
        await purchases.isEntitledTo(Entitlement.custompencolors);
    if (isEntitledToDeletePenColors && colors.showPenColorDeleteButtons) {
      colors.showPenColorDeleteButtons = false;
      return false;
    }

    // Same as above, but for the canvas color delete buttons
    var isEntitledToDeleteCanvasColors =
        await purchases.isEntitledTo(Entitlement.custombackgroundcolors);
    if (isEntitledToDeleteCanvasColors &&
        colors.showCanvasColorDeleteButtons &&
        colors.availableCanvasColors.length > 1) {
      colors.showCanvasColorDeleteButtons = false;
      return false;
    }

    // If the selector drawer is open, close the drawer
    if (selectorDrawer.isOpen) {
      selectorDrawer.closeDrawer();
      return false;
    }

    // Otherwise, allow the native behavior to continue.
    return true;
  }
}
