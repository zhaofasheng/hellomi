import 'package:in_app_purchase/in_app_purchase.dart';

class IAPCallback {
  void onLoaded(bool initialized) {}

  void onPending(PurchaseDetails product) {}

  void onSuccessPurchase(bool success) {}

  void onBillingError(dynamic error) {}
}
