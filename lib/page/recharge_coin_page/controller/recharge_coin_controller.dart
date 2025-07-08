import 'dart:async';
import 'dart:developer';
import 'dart:io';
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

import '../../../payment/newPay/new_pay.dart';

class RechargeCoinController extends GetxController{
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
    if (Platform.isIOS){
      onClickInAppPurchase(index: index);
      return;
    }
    switch (selectedPaymentIndex) {
      case 0:
        onClickStripePay(index: index);
        break;
      case 1:
        onClickStripePay(index: index);
        break;
      case 2:
        onClickInAppPurchase(index: index);
        break;
      default:
        Utils.showToast(text: EnumLocal.txtPleaseSelectPaymentGateway.name.tr);
    }
  }

  void onChoiceProduct({required int index, required BuildContext context}) async {
    selectedProductIndex = index;
    currentContext = context;
    update([AppConstant.onGetCoinPlan]);
  }

  void onClickNewPay({required int index}) async {

    try {
      Utils.showLog("Start NewPay Payment...");

      await NewPayService().init();
      // 👉 正式调用支付
      await NewPayService().newPay(coinPlanId:coinPlans[index].id ?? "");

    } catch (e) {
      Utils.showLog("NewPay 调用失败 => $e");
      Utils.showToast(text: "发生异常：$e");
    }
  }

  void onClickStripePay({required int index}) async {

    try {
      Utils.showLog("Stripe Payment Working...");
      Get.dialog(const LoadingWidget(), barrierDismissible: false);

      await StripeService().init(isTest: true);
      await 1.seconds.delay();

      await StripeService().stripePay(
        coinPlanId: coinPlans[index].id ?? "",
        callback: () async {
          Utils.showLog("Stripe Payment Success Method Called....");
          FetchUserCoin.coin;
          FetchUserCoin.init();
        },
      );

      Get.back(); // Stop Loading...
    } catch (e) {
      Get.back();
      Utils.showLog("Stripe Payment Failed !! => $e");
    }
  }


  void onClickInAppPurchase({required int index}) async {
    String productKey = coinPlans[index].productKey ?? "";
    List<String> kProductIds = <String>[productKey];

    InAppPurchaseHelper().init(
      productIds: kProductIds, // 这里可以传多个产品id，初始化时用，但buyProduct只传一个
      onSuccess: () {
        print("支付成功，刷新UI或提示用户");
        FetchUserCoin.coin;
        FetchUserCoin.init();
      },
      onError: () {
        print("支付失败或取消");
        // 这里处理失败或取消逻辑
      },
    );

    // 发起支付，传入单个产品id
    InAppPurchaseHelper().buyProduct(kProductIds[0]);
  }
}
