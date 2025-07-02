import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/recharge_coin_page/api/create_coin_plan_history_api.dart';
import 'package:tingle/page/recharge_coin_page/api/fetch_coin_plan_api.dart';
import 'package:tingle/page/recharge_coin_page/model/create_coin_plan_history_model.dart';
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/payment/flutter_wave/flutter_wave_services.dart';
import 'package:tingle/payment/in_app_purchase/iap_callback.dart';
import 'package:tingle/payment/in_app_purchase/in_app_purchase_helper.dart';
import 'package:tingle/payment/razor_pay/razor_pay_view.dart';
import 'package:tingle/payment/stripe/stripe_service.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/net_logger.dart';
import 'package:tingle/utils/utils.dart';

class RechargeCoinController extends GetxController implements IAPCallback {
  bool isLoading = false;
  List<Data> coinPlans = [];

  FetchCoinPlanModel? fetchCoinPlanModel;

  int? selectedPaymentIndex;
  int? selectedProductIndex;
  bool isAllowAgreement = false;
  BuildContext? currentContext;

  CreateCoinPlanHistoryModel? createCoinPlanHistoryModel;

  Map<String, PurchaseDetails>? purchases;

  @override
  void onInit() {
    init();

    InAppPurchaseHelper().getAlreadyPurchaseItems(this);
    purchases = InAppPurchaseHelper().getPurchases();
    InAppPurchaseHelper().clearTransactions();
    super.onInit();
  }

  Future<void> init() async {
    onGetCoinPlan();
    FetchUserCoin.coin;
    FetchUserCoin.init();
  }

  void onChangePayment(int value) {
    selectedPaymentIndex = value;
    update([AppConstant.onChangePayment]);
  }

  void onToggleAgreement() {
    isAllowAgreement = !isAllowAgreement;
    update([AppConstant.onToggleAgreement]);
  }

  Future<void> onGetCoinPlan() async {
    isLoading = true;
    update([AppConstant.onGetCoinPlan]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchCoinPlanModel = await FetchCoinPlanApi.callApi(token: token, uid: uid);
    coinPlans = fetchCoinPlanModel?.data ?? [];

    isLoading = false;
    update([AppConstant.onGetCoinPlan]);
  }

  void onClickPayNow({required int index, required BuildContext context}) async {
    switch (selectedPaymentIndex) {
      case 0:
        onClickRazorPay(index: index);
        break;
      case 1:
        onClickStripePay(index: index);
        break;
      case 2:
        onClickInAppPurchase(index: index);
        break;
      case 3:
        onClickFlutterWave(index: index, context: context);
      default:
        Utils.showToast(text: EnumLocal.txtPleaseSelectPaymentGateway.name.tr);
    }
  }

  void onChoiceProduct({required int index, required BuildContext context}) async {
    selectedProductIndex = index;
    currentContext = context;
    update([AppConstant.onGetCoinPlan]);
  }

  void onClickStripePay({required int index}) async {
    try {
      Utils.showLog("Stripe Payment Working...");
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      await StripeService().init(isTest: true);
      await 1.seconds.delay();
      StripeService().stripePay(
          amount: ((coinPlans[index].amount ?? 1) * 100).toInt(),
          callback: () async {
            Utils.showLog("Stripe Payment Success Method Called....");

            Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

            final uid = FirebaseUid.onGet() ?? "";
            final token = await FirebaseAccessToken.onGet() ?? "";

            createCoinPlanHistoryModel = await CreateCoinPlanHistoryApi.callApi(
              token: token,
              uid: uid,
              coinPlanId: coinPlans[index].id ?? "",
              paymentGateway: "Stripe",
            );

            Get.back(); // Stop Loading...

            if (createCoinPlanHistoryModel?.status == true) {
              Utils.showToast(text: EnumLocal.txtCoinRechargeSuccess.name.tr);
            } else {
              Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
            }
          });
      Get.back(); // Stop Loading...
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Stripe Payment Failed !! => $e");
    }
  }

  void onClickRazorPay({required int index}) async {
    Utils.showLog("Razorpay Payment Working....");

    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      RazorPayService().init(
        razorKey: Utils.razorpayTestKey,
        callback: () async {
          Utils.showLog("Stripe Payment Success Method Called....");

          Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

          final uid = FirebaseUid.onGet() ?? "";
          final token = await FirebaseAccessToken.onGet() ?? "";

          createCoinPlanHistoryModel = await CreateCoinPlanHistoryApi.callApi(
            token: token,
            uid: uid,
            coinPlanId: coinPlans[index].id ?? "",
            paymentGateway: "Stripe",
          );

          Get.back(); // Stop Loading...

          if (createCoinPlanHistoryModel?.status == true) {
            Utils.showToast(text: EnumLocal.txtCoinRechargeSuccess.name.tr);
          } else {
            Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
          }
        },
      );
      await 1.seconds.delay();
      RazorPayService().razorPayCheckout(((coinPlans[index].amount ?? 0) * 100).toInt());
      Get.back(); // Stop Loading...
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("RazorPay Payment Failed => $e");
    }
  }

  void onClickFlutterWave({required int index, required BuildContext context}) async {
    Utils.showLog("Flutter Wave Payment Working....");

    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      await FlutterWaveService.init(
        amount: (coinPlans[index].amount ?? 0).toString(),
        context: context,
        onPaymentComplete: () async {
          Utils.showLog("Flutter Wave Payment Successfully");

          Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

          final uid = FirebaseUid.onGet() ?? "";
          final token = await FirebaseAccessToken.onGet() ?? "";

          createCoinPlanHistoryModel = await CreateCoinPlanHistoryApi.callApi(
            token: token,
            uid: uid,
            coinPlanId: coinPlans[index].id ?? "",
            paymentGateway: "Flutter Wave",
          );
          Get.back(); // Stop Loading...

          if (createCoinPlanHistoryModel?.status == true) {
            Utils.showToast(text: EnumLocal.txtCoinRechargeSuccess.name.tr);
            Get.close(2);
          } else {
            Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
          }
        },
      );

      Get.back(); // Stop Loading...
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Flutter Wave Payment Failed => $e");
    }
  }

  void onClickInAppPurchase({required int index}) async {
    String productKey = "";
    List<String> kProductIds = <String>[productKey];

    await InAppPurchaseHelper().init(
      paymentType: "In App Purchase",
      userId: Database.loginUserId,
      productKey: kProductIds,
      rupee: (coinPlans[index].amount ?? 0).toDouble(),
      callBack: () async {
        Utils.showLog("In App Purchase Payment Successfully");

        Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

        final uid = FirebaseUid.onGet() ?? "";
        final token = await FirebaseAccessToken.onGet() ?? "";

        createCoinPlanHistoryModel = await CreateCoinPlanHistoryApi.callApi(
          token: token,
          uid: uid,
          coinPlanId: coinPlans[index].id ?? "",
          paymentGateway: "Flutter Wave",
        );
        Get.back(); // Stop Loading...

        if (createCoinPlanHistoryModel?.status == true) {
          Utils.showToast(text: EnumLocal.txtCoinRechargeSuccess.name.tr);
          Get.close(2);
        } else {
          Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
        }
      },
    );

    InAppPurchaseHelper().initStoreInfo();

    await Future.delayed(const Duration(seconds: 1));

    ProductDetails? product = InAppPurchaseHelper().getProductDetail(productKey);

    if (product != null) {
      InAppPurchaseHelper().buySubscription(product, purchases!);
    }
  }

  @override
  void onBillingError(error) {}

  @override
  void onLoaded(bool initialized) {}

  @override
  void onPending(PurchaseDetails product) {}

  @override
  void onSuccessPurchase(PurchaseDetails product) {}
}
