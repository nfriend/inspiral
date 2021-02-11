import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

/// A widget that provides a theme based on the currently selected
/// pen and background colors
class DynamicTheme extends StatelessWidget {
  DynamicTheme({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.watch<ColorState>();

    TextTheme textTheme = colors.uiBackgroundColor.isDark()
        ? Typography.whiteHelsinki
        : Typography.blackHelsinki;

    TextButtonThemeData textButtonTheme = TextButtonThemeData(
        style: ButtonStyle(
            shape:
                MaterialStateProperty.resolveWith((states) => StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => colors.uiBackgroundColor.color),
            foregroundColor: MaterialStateProperty.resolveWith(
                (states) => colors.uiTextColor.color),
            overlayColor: MaterialStateProperty.resolveWith(
                (states) => colors.splashColor.color)));

    return Theme(
        data: ThemeData(
            accentColor: colors.accentColor.color,
            splashColor: colors.splashColor.color,
            primaryColor: colors.primaryColor.color,
            highlightColor: colors.highlightColor.color,
            textButtonTheme: textButtonTheme,
            primaryTextTheme: textTheme),
        child: child);
  }
}
