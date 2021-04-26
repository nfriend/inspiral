import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/settings_state.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/hide_system_ui_overlays.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';

/// Shares the current drawing using the OS's "share" feature
Future<void> shareImage(BuildContext context) async {
  var progress = Provider.of<ProgressState>(context, listen: false);
  progress.showModalProgress(message: 'Sharing...');

  var filePath = await _cropAndSaveToTempFile(context);

  if (filePath != null) {
    await Share.shareFiles([filePath]);
  }

  progress.hideModalPropress();

  hideSystemUIOverlays();
}

/// Saves the current drawing as an image in the OS's image gallery
Future<void> saveImage(BuildContext context) async {
  if (!(await Permission.storage.request().isGranted)) {
    var snackbar = Provider.of<SnackbarState>(context, listen: false);
    snackbar.showSnackbar('You must grant storage permission to save');
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

  hideSystemUIOverlays();
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

  // Even though the tiles have now been baked, they may not have been rendered
  // to the screen yet. Now wait until the current frame is complete.
  var renderCompleter = Completer();
  SchedulerBinding.instance.addPostFrameCallback((_) {
    renderCompleter.complete();
  });
  await renderCompleter.future;

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

  var title = 'Crop/rotate image';
  var croppedImage = await ImageCropper.cropImage(
      sourcePath: fullImageFilePath,
      androidUiSettings: AndroidUiSettings(toolbarTitle: title),
      iosUiSettings: IOSUiSettings(
        title: title,
      ));

  return croppedImage?.path;
}
