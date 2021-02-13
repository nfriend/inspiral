import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/settings_state.dart';
import 'package:inspiral/state/state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

/// Shows a SnackBar message
void _showSnackBarMessage(String message) {
  scaffoldGlobalKey.currentState.showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.fixed));
}

/// Shares the current drawing using the OS's "share" feature
Future<void> shareImage(BuildContext context) async {
  var progress = Provider.of<ProgressState>(context, listen: false);
  progress.showModalProgress(message: 'Sharing...');

  String filePath = await _saveToTempFile(context);
  await Share.shareFiles([filePath]);

  progress.hideModalPropress();
}

/// Saves the current drawing as an image in the OS's image gallery
Future<void> saveImage(BuildContext context) async {
  if (!(await Permission.storage.request().isGranted)) {
    _showSnackBarMessage('You must grant storage permission to save');
    return;
  }

  var progress = Provider.of<ProgressState>(context, listen: false);
  progress.showModalProgress(message: 'Saving to the gallery...');

  String filePath = await _saveToTempFile(context);
  await ImageGallerySaver.saveFile(filePath);

  progress.hideModalPropress();
}

/// Saves the canvas as an image in a temporary location,
/// and returns the file path
Future<String> _saveToTempFile(BuildContext context) async {
  var settings = Provider.of<SettingsState>(context, listen: false);

  GlobalKey canvasKey = settings.includeBackgroundWhenSaving
      ? canvasWithBackgroundGlobalKey
      : canvasWithoutBackgroundGlobalKey;

  RenderRepaintBoundary canvasBoundary =
      canvasKey.currentContext.findRenderObject();
  Image screenshot = await canvasBoundary.toImage();
  ByteData byteData = await screenshot.toByteData(format: ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();

  Directory directory = (await getTemporaryDirectory());
  String filePath = p.join(directory.path, '${Uuid().v4()}.png');

  await File(filePath).writeAsBytes(pngBytes, flush: true);
  screenshot.dispose();

  return filePath;
}
