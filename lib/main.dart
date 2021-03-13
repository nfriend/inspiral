import 'package:flutter/material.dart';
import 'package:inspiral/inspiral_app.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

void main() {
  // Inform the plugin that this app supports pending purchases on Android.
  // An error will occur on Android if you access the plugin `instance`
  // without this call.
  //
  // On iOS this is a no-op.
  InAppPurchaseConnection.enablePendingPurchases();

  runApp(InspiralApp());
}
