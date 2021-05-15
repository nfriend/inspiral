import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inspiral/routes.dart';

class HelpListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Help'),
      onTap: () {
        Navigator.pushNamed(context, InspiralRoutes.help);
      },
    );
  }
}
