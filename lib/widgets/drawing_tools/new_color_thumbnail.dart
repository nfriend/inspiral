import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/util/if_purchased.dart';
import 'package:inspiral/widgets/drawing_tools/crown_if_not_entitled.dart';
import 'package:provider/provider.dart';
import 'package:inspiral/widgets/drawing_tools/color_picker_dialog.dart';

class NewColorThumbnail extends StatelessWidget {
  /// The title that should be rendered at the top of the color selection dialog
  final String title;

  /// The entitlement associated with this color picker
  final String entitlement;

  /// The package that will purchase the entitlement for this color picker
  final String package;

  NewColorThumbnail(
      {@required this.title,
      @required this.entitlement,
      @required this.package});

  @override
  Widget build(BuildContext context) {
    final ColorState colors = Provider.of<ColorState>(context, listen: false);
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(5.0));

    return Stack(children: [
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadius, gradient: Gradients.jShine),
              child: Material(
                  color: Colors.transparent,
                  borderRadius: borderRadius,
                  child: InkWell(
                    borderRadius: borderRadius,
                    onTap: ifPurchased(
                        context: context,
                        entitlement: entitlement,
                        package: package,
                        callbackIfPurchased: () {
                          showDialog(
                              context: context,
                              builder: (_) => ColorPickerDialog(
                                  title: title, colors: colors));
                        }),
                    child: Center(
                        child:
                            Icon(Icons.add, size: 40.0, color: Colors.white)),
                  )))),
      CrownIfNotEntitled(entitlement: entitlement)
    ]);
  }
}
