import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hides the system UI overlays.
void hideSystemUIOverlays() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
