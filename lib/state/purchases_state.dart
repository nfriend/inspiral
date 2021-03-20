import 'package:flutter/material.dart';
import 'package:inspiral/models/entitlement.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesState extends ChangeNotifier {
  static PurchasesState _instance;

  factory PurchasesState.init() {
    return _instance = PurchasesState._internal();
  }

  factory PurchasesState() {
    assert(_instance != null,
        'The PurchasesState.init() factory constructor must be called before using the PurchasesState() constructor.');
    return _instance;
  }

  PurchasesState._internal();

  /// Returns a boolean indicating whether or not
  /// the provided `entitlement` is owned by the user
  Future<bool> isEntitledTo(String entitlement) async {
    if (entitlement == Entitlement.free) {
      return true;
    }

    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    return purchaserInfo.entitlements.all[entitlement]?.isActive == true;
  }
}
