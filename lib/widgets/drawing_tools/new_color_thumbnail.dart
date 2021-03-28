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

  /// Whether or not to show the opacity slider in the dialog
  final bool showOpacity;

  /// The color that should be initially selected;
  final Color initialColor;

  /// The function to call when a new color is selected
  final Function(Color color) onSelect;

  NewColorThumbnail(
      {@required this.title,
      @required this.entitlement,
      @required this.package,
      @required this.showOpacity,
      @required this.initialColor,
      @required this.onSelect});

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
                                  title: title,
                                  colors: colors,
                                  showOpacity: showOpacity,
                                  initialColor: initialColor,
                                  onSelect: onSelect));
                        }),
                    child: Center(
                        child:
                            Icon(Icons.add, size: 40.0, color: Colors.white)),
                  )))),
      CrownIfNotEntitled(entitlement: entitlement)
    ]);
  }
}