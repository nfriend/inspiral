import 'package:flutter/services.dart';
import 'package:inspiral/models/entitlement.dart';
import 'package:inspiral/state/state.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasesState extends InspiralStateObject {
  static PurchasesState _instance;

  factory PurchasesState.init() {
    return _instance = PurchasesState._internal();
  }

  factory PurchasesState() {
    assert(_instance != null,
        'The PurchasesState.init() factory constructor must be called before using the PurchasesState() constructor.');
    return _instance;
  }

  PurchasesState._internal() : super();

  /// Returns a boolean indicating whether or not
  /// the provided `entitlement` is owned by the user
  Future<bool> isEntitledTo(String/*!*/ entitlement) async {
    if (entitlement == Entitlement.free) {
      return true;
    }

    var purchaserInfo = await Purchases.getPurchaserInfo();
    return purchaserInfo.entitlements.all[entitlement]?.isActive == true;
  }

  /// Prompts the user to purchase the provided package using the OS's native
  /// in-app purchasing functionality.
  /// Returns a `bool` that indicates whether or not the product was purchased.
  Future<bool> purchasePackage(Package packageToBuy) async {
    try {
      await Purchases.purchasePackage(packageToBuy);
      notifyListeners();
      return true;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        return false;
      }

      rethrow;
    }
  }

  /// Gets the current offering
  Future<Offering/*!*/> getCurrentOffering() async {
    var offerings = await Purchases.getOfferings();
    if (offerings.current == null ||
        offerings.current.availablePackages.isEmpty) {
      throw 'Offering returned no packages';
    }

    return offerings.current;
  }

  /// Restores purchases in the case when the app is reinstalled.
  Future<void> restorePurchases() async {
    await Purchases.restoreTransactions();
    notifyListeners();
  }
}
