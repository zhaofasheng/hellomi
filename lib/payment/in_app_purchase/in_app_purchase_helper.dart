import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/api_service.dart';
import '../../common/widget/loading_widget.dart';
import '../../firebase/authentication/firebase_uid.dart';
import '../../utils/api.dart';

import 'dart:async';
import 'dart:convert';



typedef Callback = void Function();

class InAppPurchaseHelper {
  static final InAppPurchaseHelper _instance = InAppPurchaseHelper._internal();
  factory InAppPurchaseHelper() => _instance;
  InAppPurchaseHelper._internal();

  static const MethodChannel _channel = MethodChannel('com.example.inapp_purchase');

  Callback? _onSuccess;
  Callback? _onError;
  List<String> _productIds = [];

  /// 初始化购买参数
  void init({
    required List<String> productIds,
    required Callback onSuccess,
    required Callback onError,
  }) {
    _productIds = productIds;
    _onSuccess = onSuccess;
    _onError = onError;
  }

  /// 调用原生支付，传入产品id
  Future<void> buyProduct(String productId) async {
    try {
      // 👉 显示 loading 弹窗
      Get.dialog(const LoadingWidget(), barrierDismissible: false);

      final Map result = await _channel.invokeMethod('startPurchase', {"productId": productId});
      bool success = result['success'] ?? false;
      String receipt = result['receipt'] ?? "";
      print("[Flutter] 支付返回 success=$success, receipt length=${receipt.length}");
      // 👉 支付弹窗已经拉起，关闭 loading
      Get.back(); // 关闭 loading 弹窗

      if (success && receipt.isNotEmpty) {
        await _cacheReceipt(receipt);
        await _verifyReceipt(receipt);
      } else {
        _onError?.call();
        // 👉 异常时也要关闭 loading
        Get.back();
      }
    } on PlatformException catch (e) {
      print("[Flutter] 支付异常: ${e.message}");
      _onError?.call();
      // 👉 异常时也要关闭 loading
      Get.back();
    }
  }

  /// 缓存凭证
  Future<void> _cacheReceipt(String receipt) async {
    final prefs = await SharedPreferences.getInstance();
    final uid =  FirebaseUid.onGet() ?? "";
    if(uid.isNotEmpty){
      await prefs.setString("iap_receipt_$uid", receipt);
    }
  }

  /// 启动时尝试验证缓存凭证
  Future<void> tryValidateCachedReceipt() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseUid.onGet() ?? "";
    final receipt = prefs.getString("iap_receipt_$uid");
    if (receipt != null && receipt.isNotEmpty && uid.isNotEmpty) {
      print("[Flutter] 发现缓存凭证，开始验证");
      await _verifyReceipt(receipt);
    }
  }

  /// 发送凭证到服务器验证
  Future<void> _verifyReceipt(String base64Receipt) async {
    try {
      // 👉 显示 loading 弹窗
      Get.dialog(const LoadingWidget(), barrierDismissible: false);
      print("[IAP] 请求服务器验证凭证，长度: ${base64Receipt.length}");
      final uid = FirebaseUid.onGet() ?? "";
      final data = {
        "receipt": base64Receipt,
        "xUserUid": uid,
      };
      final response = await ApiService().post(Api.applyPayAuth, data: data);
      print("[IAP] 服务器响应: ${response?.data}");

      if (response?.data != null && _verifySuccessFromResponse(response?.data)) {
        print("[IAP] 验证成功 ✅");
        _onSuccess?.call();
        await _clearCachedReceipt();
        Get.back();
      } else {
        print("[IAP] 验证失败 ❌");
        _onError?.call();
        Get.back();
      }
    } catch (e) {
      print("[Flutter] 验证异常: $e");
      _onError?.call();
      Get.back();
    }
  }

  Future<void> _clearCachedReceipt() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseUid.onGet() ?? "";
    await prefs.remove("iap_receipt_$uid");
  }

  /// 本地沙盒验证 (可选调试用)
  Future<bool> verifyReceiptWithAppleSandbox(String base64Receipt) async {
    const url = 'https://sandbox.itunes.apple.com/verifyReceipt';

    final Map<String, dynamic> requestBody = {
      "receipt-data": base64Receipt,
      "exclude-old-transactions": true,
    };

    try {
      print("[Flutter][DIO] 调用苹果沙盒验证接口");
      final response = await Dio().post(
        url,
        data: requestBody,
        options: Options(
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.json,
        ),
      );

      final jsonResponse = response.data;
      print("[Flutter][DIO] 苹果返回: $jsonResponse");

      final int status = jsonResponse['status'] ?? -1;
      if (status == 0) {
        print("[Flutter][DIO] 收据验证成功 ✅");
        return true;
      } else {
        print("[Flutter][DIO] 收据验证失败，状态码: $status ❌");
        return false;
      }
    } catch (e) {
      print("[Flutter][DIO] 沙盒验证异常: $e");
      return false;
    }
  }

  bool _verifySuccessFromResponse(dynamic response) {
    if (response is Map) {
      final status = response["status"] == true;
      final message = response["message"]?.toString().toUpperCase() == "SUCCESS";

      return status && message;
    }
    return false;
  }
}
