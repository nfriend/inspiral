import 'package:flutter/material.dart';
import 'package:inspiral/models/gear_definition.dart';
import 'package:inspiral/models/gear_model.dart';
import 'package:inspiral/routes.dart';
import 'package:inspiral/widgets/inspiral_canvas.dart';
import 'package:provider/provider.dart';

class InspiralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => GearModel(
                  initialOffset: Offset(100, 100),
                  initialGearDefinition:
                      GearDefinition(image: 'images/gear_84.png')))
        ],
        child: MaterialApp(
          title: 'Inspiral',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            InspiralRoutes.canvas: (context) {
              return InspiralCanvas();
            }
          },
        ));
  }
}
