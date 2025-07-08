import UIKit
import Flutter
import StoreKit
import Firebase
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate {

  private var methodChannel: FlutterMethodChannel?
  private var productsRequest: SKProductsRequest?
  private var pendingProductId: String?
  private var flutterResult: FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    methodChannel = FlutterMethodChannel(name: "com.example.inapp_purchase", binaryMessenger: controller.binaryMessenger)
    
    methodChannel?.setMethodCallHandler { [weak self] (call, result) in
      guard let self = self else { return }
      if call.method == "startPurchase" {
        if let args = call.arguments as? [String: Any],
           let productId = args["productId"] as? String {
          self.startPurchase(productId: productId, flutterResult: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "ProductId required", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    SKPaymentQueue.default().add(self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func startPurchase(productId: String, flutterResult: @escaping FlutterResult) {
    if SKPaymentQueue.canMakePayments() == false {
      flutterResult(["success": false, "error": "In-App Purchases not allowed"])
      return
    }

    self.flutterResult = flutterResult
    self.pendingProductId = productId
    self.productsRequest?.cancel()

    self.productsRequest = SKProductsRequest(productIdentifiers: Set([productId]))
    self.productsRequest?.delegate = self
    self.productsRequest?.start()
  }

  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    guard let product = response.products.first else {
      flutterResult?(["success": false, "error": "Product not found"])
      clearPending()
      return
    }

    let payment = SKPayment(product: product)
    SKPaymentQueue.default().add(payment)
  }

  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch transaction.transactionState {
      case .purchased:
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           let receiptData = try? Data(contentsOf: receiptURL) {
          let base64Receipt = receiptData.base64EncodedString()
          print("[iOS] 交易成功，凭证：\(base64Receipt)")
          flutterResult?(["success": true, "receipt": base64Receipt])
        } else {
          flutterResult?(["success": false, "error": "Receipt not found"])
        }
        SKPaymentQueue.default().finishTransaction(transaction)
        clearPending()

      case .failed:
        print("[iOS] 交易失败：\(transaction.error?.localizedDescription ?? "未知错误")")
        flutterResult?(["success": false, "error": transaction.error?.localizedDescription ?? "Purchase failed"])
        SKPaymentQueue.default().finishTransaction(transaction)
        clearPending()

      case .restored, .deferred, .purchasing:
        break

      @unknown default:
        break
      }
    }
  }

  private func clearPending() {
    flutterResult = nil
    pendingProductId = nil
    productsRequest = nil
  }
}



// import Flutter
// import UIKit
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
