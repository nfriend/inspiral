import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:inspiral/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

void _showMessage(BuildContext context, String message) {
  scaffoldGlobalKey.currentState.showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.fixed));
}

Future<void> saveImage(BuildContext context) async {
  if (!(await Permission.storage.request().isGranted)) {
    _showMessage(context, 'You must grant storage permission to save');

    return;
  }

  _showMessage(context, 'Saving to the gallery...');

  RenderRepaintBoundary canvasBoundary =
      canvasWithBackgroundGlobalKey.currentContext.findRenderObject();
  Image screenshot = await canvasBoundary.toImage();
  ByteData byteData = await screenshot.toByteData(format: ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();

  Directory directory = (await getTemporaryDirectory());
  String filePath = p.join(directory.path, '${Uuid().v4()}.png');

  await File(filePath).writeAsBytes(pngBytes, flush: true);
  await ImageGallerySaver.saveFile(filePath);
  screenshot.dispose();

  _showMessage(context, 'Done!');
}
