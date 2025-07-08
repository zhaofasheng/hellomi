import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:http/http.dart' as http;
import 'package:tingle/payment/stripe/stripe_pay_model.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

import '../../common/api_service.dart';
import '../../utils/api.dart';


class StripeService {
  /// ✅ 单例模式实现
  static final StripeService _instance = StripeService._internal();
  factory StripeService() => _instance;
  StripeService._internal();

  bool isTest = false;

  Future<void> init({required bool isTest}) async {
    Stripe.publishableKey = Utils.stripeTestPublicKey;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test'; // 可保留但不会用到
    await Stripe.instance.applySettings().catchError((e) {
      log("Stripe Apply Settings => $e");
      throw e.toString();
    });
    this.isTest = isTest;
  }

  Future<dynamic> stripePay({
    required String coinPlanId,
    required Callback callback,
  }) async {

    final url = Api.stripPayUri;
    Utils.showLog("Fetch Coin Plan Api Url => $url");

    try {
      // 注意：headers 会自动由 ApiService 拦截器添加
      final response = await ApiService().post(
        url,
        queryParameters:{
          'coinPlanId':coinPlanId,
        },
      );

      if (response?.statusCode == 200) {
        final jsonResponse = response?.data;

        Utils.showLog("Fetch Coin Plan Api Response => ${response?.data}");

        final clientSecret = jsonResponse["data"]["clientSecret"];
        log("Stripe Payment Response => $clientSecret");

        final setupParams = SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: AppColor.primary),
          ),
          // ❌ 不再包含 applePay
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: Utils.countryCode,
            testEnv: isTest,
          ),
          merchantDisplayName: Database.fetchLoginUserProfile()?.user?.name ?? "",
          customerId: Database.loginUserId,
          billingDetails: BillingDetails(
            name: Database.fetchLoginUserProfile()?.user?.name ?? "",
            email: Database.fetchLoginUserProfile()?.user?.email ?? "",
          ),
        );

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: setupParams,
        ).then((_) async {
          await Stripe.instance.presentPaymentSheet().then((_) async {
            log("***** Payment Done *****");
            callback.call();
            Utils.showLog("Stripe Payment Success Method Called....");
            Utils.showLog("Stripe Payment Successfully");
          }).catchError((e) {
            log("Init Payment Sheet Error => $e");
          });
        }).catchError((e) {
          log("Something Went Wrong => $e");
        });
      }else {
        Utils.showLog("Fetch Coin Plan Api StatusCode Error => ${response?.statusCode}");
        return response;
      }
    } catch (error) {
      Utils.showLog("Fetch Coin Plan Api Error => $error");
      return null;
    }
  }
}
