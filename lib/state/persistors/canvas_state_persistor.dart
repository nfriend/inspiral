import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:inspiral/extensions/extensions.dart';

class CanvasStateRehydrationResult {
  final Matrix4 transform;

  CanvasStateRehydrationResult({@required this.transform});
}

class CanvasStatePersistor {
  static void persist(Batch batch, CanvasState canvas) {
    var elements = canvas.transform.storage;

    batch.update(Schema.state.toString(), {
      Schema.state.canvasTransform_0: elements[0],
      Schema.state.canvasTransform_1: elements[1],
      Schema.state.canvasTransform_2: elements[2],
      Schema.state.canvasTransform_3: elements[3],
      Schema.state.canvasTransform_4: elements[4],
      Schema.state.canvasTransform_5: elements[5],
      Schema.state.canvasTransform_6: elements[6],
      Schema.state.canvasTransform_7: elements[7],
      Schema.state.canvasTransform_8: elements[8],
      Schema.state.canvasTransform_9: elements[9],
      Schema.state.canvasTransform_10: elements[10],
      Schema.state.canvasTransform_11: elements[11],
      Schema.state.canvasTransform_12: elements[12],
      Schema.state.canvasTransform_13: elements[13],
      Schema.state.canvasTransform_14: elements[14],
      Schema.state.canvasTransform_15: elements[15],
    });
  }

  static Future<CanvasStateRehydrationResult> rehydrate(
      Database db, BuildContext context, CanvasState canvas) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    var elements = <double>[
      state[Schema.state.canvasTransform_0] as double,
      state[Schema.state.canvasTransform_1] as double,
      state[Schema.state.canvasTransform_2] as double,
      state[Schema.state.canvasTransform_3] as double,
      state[Schema.state.canvasTransform_4] as double,
      state[Schema.state.canvasTransform_5] as double,
      state[Schema.state.canvasTransform_6] as double,
      state[Schema.state.canvasTransform_7] as double,
      state[Schema.state.canvasTransform_8] as double,
      state[Schema.state.canvasTransform_9] as double,
      state[Schema.state.canvasTransform_10] as double,
      state[Schema.state.canvasTransform_11] as double,
      state[Schema.state.canvasTransform_12] as double,
      state[Schema.state.canvasTransform_13] as double,
      state[Schema.state.canvasTransform_14] as double,
      state[Schema.state.canvasTransform_15] as double,
    ];

    Matrix4 transform;

    if (elements.any((element) => element == null)) {
      // If any of the elements are null, it means we don't have a previously-
      // saved transform. (For example, when opening the app
      // for the very first time.)
      // In this case, use compute a new transform instead that places
      // the camera in the correct starting position.

      // Compute an initial canvas translation that will place the
      // center point of the canvas directly in the center of the screen
      // By default, the canvas's top-left corner is lined up with
      // the screen's top-left corner
      transform = Matrix4.identity();

      // Scale the canvas to the correct zoom level
      final initialZoom = 0.5;
      transform.scale(initialZoom, initialZoom, 0);

      // Move the center of the canvas to the
      // top-left of the screen. Multiplied by 2, because the
      // canvas itself is offset by `canvasCenter` from its parent.
      var originTranslation = -(canvasCenter.toVector3() * 2);
      transform.translate(originTranslation);

      // Then, move the canvas back by half the screen dimensions
      // so that the centor of the canvas is located
      // in the center of the screen
      var centerTranslation =
          (MediaQuery.of(context).size / 2).toVector3() * (1 / initialZoom);
      transform.translate(centerTranslation);
    } else {
      transform = Matrix4.fromList(elements);
    }

    return CanvasStateRehydrationResult(transform: transform);
  }
}
