import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:image_cropper/image_cropper.dart';
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
import 'package:open_file/open_file.dart';

/// Shows a SnackBar message
void _showSnackBarMessage(String message) {
  scaffoldMessengerGlobalKey.currentState.showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.fixed));
}

/// Shares the current drawing using the OS's "share" feature
Future<void> shareImage(BuildContext context) async {
  var progress = Provider.of<ProgressState>(context, listen: false);
  progress.showModalProgress(message: 'Sharing...');

  var filePath = await _cropAndSaveToTempFile(context);

  if (filePath != null) {
    await Share.shareFiles([filePath]);
  }

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

  var filePath = await _cropAndSaveToTempFile(context);

  if (filePath != null) {
    await ImageGallerySaver.saveFile(filePath);

    await OpenFile.open(filePath, type: 'image/png', uti: 'public.png');
  }

  progress.hideModalPropress();
}

/// Saves the canvas as an image in a temporary location,
/// and returns the file path, or returns `null` if the
/// user cancels the crop operation.
Future<String> _cropAndSaveToTempFile(BuildContext context) async {
  var ink = Provider.of<InkState>(context, listen: false);
  var settings = Provider.of<SettingsState>(context, listen: false);

  // Make sure all the lines have been baked into the background tiles
  await ink.pendingCanvasManipulation;
  await ink.bakeImage();

  var canvasKey = settings.includeBackgroundWhenSaving
      ? canvasWithBackgroundGlobalKey
      : canvasWithoutBackgroundGlobalKey;

  var canvasBoundary =
      canvasKey.currentContext.findRenderObject() as RenderRepaintBoundary;
  var screenshot = await canvasBoundary.toImage();
  var byteData = await screenshot.toByteData(format: ImageByteFormat.png);
  var pngBytes = byteData.buffer.asUint8List();

  var directory = (await getTemporaryDirectory());
  var fullImageFilePath = p.join(directory.path, '${Uuid().v4()}.png');

  await File(fullImageFilePath).writeAsBytes(pngBytes, flush: true);
  screenshot.dispose();

  var croppedImage = await ImageCropper.cropImage(
      sourcePath: fullImageFilePath,
      androidUiSettings: AndroidUiSettings(toolbarTitle: 'Crop/rotate image'));

  return croppedImage?.path;
}
