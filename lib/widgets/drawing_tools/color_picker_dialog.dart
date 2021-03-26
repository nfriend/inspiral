import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:inspiral/state/color_state.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorPickerDialog extends StatefulWidget {
  /// The title to render at the top of the dialog
  final String title;

  /// The current ColorState object. Provided here explicitly since the
  /// dialog doesn't share the same provider context.
  final ColorState colors;

  ColorPickerDialog({@required this.title, @required this.colors});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.colors.isDark;
    bool isSelectedColorOpaqueish = _selectedColor.alpha > 100;
    bool selectedColorIsDark = TinyColor(_selectedColor).isDark();

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

    final ButtonStyle _cancelButtonStyle = ButtonStyle(
        shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => darkMode ? Colors.white : Colors.black));

    final ButtonStyle _selectButtonStyle = ButtonStyle(
        shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => _selectedColor));

    return Dialog(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )),
          ColorPicker(
            showRecentColors: false,
            enableOpacity: true,
            enableShadesSelection: false,
            borderRadius: 20,
            opacityTrackHeight: 22,
            pickersEnabled: {
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.wheel: true,
            },
            onColorChanged: (Color newColor) => setState(() {
              _selectedColor = newColor;
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  "SELECT ${ColorTools.nameThatColor(_selectedColor).toUpperCase()}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: selectButtonTextColor),
                ),
                style: _selectButtonStyle),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("CANCEL"),
                  style: _cancelButtonStyle)),
        ]));
  }
}
