import 'package:flutter/material.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/models/canvas_size.dart';
import 'package:inspiral/state/helpers/get_center_transform.dart';
import 'package:inspiral/state/helpers/guess_ideal_canvas_size.dart';
import 'package:inspiral/state/state.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:vector_math/vector_math_64.dart';

class CanvasStateRehydrationResult {
  final Matrix4 transform;
  final CanvasSizeAndName canvasSizeAndName;

  CanvasStateRehydrationResult(
      {@required this.transform, @required this.canvasSizeAndName});
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
      Schema.state.canvasSize: canvas.canvasSizeAndName.id
    });
  }

  static Future<CanvasStateRehydrationResult> rehydrate(
      Database db, BuildContext context, CanvasState canvas) async {
    Map<String, dynamic> state =
        (await db.query(Schema.state.toString())).first;

    var canvasSizeAndNameId = state[Schema.state.canvasSize] as String;
    CanvasSizeAndName canvasSizeAndName;

    if (canvasSizeAndNameId == null) {
      // Similar to below, if either of these are null, it means we're launching
      // the app for the first time.
      // In this case, we need to select the canvas size that is most
      // appropriate for the current device. The older/slower the device, the
      // smaller canvas we should select.

      canvasSizeAndName = await guessIdealCanvasSize();
    } else {
      canvasSizeAndName =
          CanvasSize.all.firstWhere((csan) => csan.id == canvasSizeAndNameId);
    }

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

      transform = getCenterTransform(
          canvasSize: canvasSizeAndName.size,
          screenSize: MediaQuery.of(context).size,
          initialScale: 0.5);
    } else {
      transform = Matrix4.fromList(elements);
    }

    return CanvasStateRehydrationResult(
        transform: transform, canvasSizeAndName: canvasSizeAndName);
  }
}
