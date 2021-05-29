import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:inspiral/util/replace_problematic_color_names.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorPickerDialog extends StatefulWidget {
  /// The title to render at the top of the dialog
  final String title;

  /// The current ColorState object. Provided here explicitly since the
  /// dialog doesn't share the same provider context.
  final ColorState colors;

  /// Whether or not to show the opacity slider
  final bool showOpacity;

  /// The color that should be initially selected;
  final Color initialColor;

  /// The function to call when the color wheel inside the dialog is moved.
  /// Note: This is different than `onSelect`, which is called when the user
  /// actually _confirms_ the new color.
  final Function(Color color) onColorMove;

  /// The function to call when a new color is selected
  final Function(Color color) onSelect;

  ColorPickerDialog(
      {@required this.title,
      @required this.colors,
      @required this.showOpacity,
      @required this.initialColor,
      @required this.onColorMove,
      @required this.onSelect});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color/*!*/ _selectedColor;

  @override
  void initState() {
    super.initState();

    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = widget.colors.isDark;
    var isSelectedColorOpaqueish = _selectedColor.alpha > 100;
    var selectedColorIsDark = TinyColor(_selectedColor).isDark();

    // Ensure the text of the colored button is always legible
    Color selectButtonTextColor;
    if (darkMode) {
      selectButtonTextColor = !selectedColorIsDark && isSelectedColorOpaqueish
          ? Colors.black
          : Colors.white;
    } else {
      selectButtonTextColor = selectedColorIsDark && isSelectedColorOpaqueish
          ? Colors.white
          : Colors.black;
    }

    final _cancelButtonStyle = ButtonStyle(
        shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => darkMode ? Colors.white : Colors.black));

    final _selectButtonStyle = ButtonStyle(
        shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => _selectedColor));

    final colorName =
        replaceProblematicColorNames(ColorTools.nameThatColor(_selectedColor))
            .toUpperCase();

    return Dialog(
        child: SingleChildScrollView(
            child: SizedBox(
                width: 300.0,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          )),
                      ColorPicker(
                          color: _selectedColor,
                          showRecentColors: false,
                          enableOpacity: widget.showOpacity,
                          enableShadesSelection: false,
                          borderRadius: 20,
                          opacityTrackHeight: 22,
                          pickersEnabled: {
                            ColorPickerType.primary: false,
                            ColorPickerType.accent: false,
                            ColorPickerType.wheel: true,
                          },
                          onColorChanged: (Color newColor) {
                            setState(() {
                              _selectedColor = newColor;
                            });
                            widget.onColorMove(newColor);
                          }),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: OutlinedButton(
                            onPressed: () {
                              widget.onSelect(_selectedColor);
                              Navigator.of(context).pop();
                            },
                            style: _selectButtonStyle,
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'SELECT $colorName',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: selectButtonTextColor),
                                )),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 20.0),
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: _cancelButtonStyle,
                            child: Text('CANCEL'),
                          )),
                    ]))));
  }
}
