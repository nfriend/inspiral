import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:tinycolor/tinycolor.dart';

class ColorPickerDialog extends StatefulWidget {
  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _selectedColor = Colors.red;

  final ButtonStyle _buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => StadiumBorder()),
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.black));

  @override
  Widget build(BuildContext context) {
    Color nameColor =
        TinyColor(_selectedColor).isDark() && _selectedColor.alpha > 100
            ? Colors.white
            : Colors.black;

    return Dialog(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
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
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
        child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: _selectedColor,
            ),
            child: Center(
                child: Text(
              ColorTools.nameThatColor(_selectedColor),
              style: TextStyle(fontWeight: FontWeight.w500, color: nameColor),
            ))),
      ),
      Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("CANCEL"),
                        style: _buttonStyle))),
            Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text("SELECT"),
                    style: _buttonStyle))
          ])),
    ]));
  }
}
