import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorPickerDialog extends StatefulWidget {
  final String title;

  ColorPickerDialog({@required this.title});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _selectedColor = Colors.red;

  final ButtonStyle _cancelButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.black));

  @override
  Widget build(BuildContext context) {
    Color nameColor =
        TinyColor(_selectedColor).isDark() && _selectedColor.alpha > 100
            ? Colors.white
            : Colors.black;

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
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: nameColor),
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
