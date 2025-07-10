import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/shimmer/coin_recharge_widget_shimmer.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/recharge_coin_page/api/create_coin_plan_history_api.dart';
import 'package:tingle/page/recharge_coin_page/api/fetch_coin_plan_api.dart';
import 'package:tingle/page/recharge_coin_page/model/create_coin_plan_history_model.dart';
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/payment/flutter_wave/flutter_wave_services.dart';
import 'package:tingle/payment/in_app_purchase/in_app_purchase_helper.dart' hide Callback;
import 'package:tingle/payment/razor_pay/razor_pay_view.dart';
import 'package:tingle/payment/stripe/stripe_service.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../assets/assets.gen.dart';
import '../../page/preview_created_reels_page/widget/preview_created_reels_widget.dart';

class CoinPurchaseBottomSheet {
  static RxInt selectedPaymentIndex = 0.obs;

  static RxBool isLoading = true.obs;
  static RxList<Data> coinPlans = <Data>[].obs;
  static CreateCoinPlanHistoryModel? createCoinPlanHistoryModel;
  static BuildContext? currentContext;
  static RxInt selectedProductIndex = 9.obs;
  static Map<String, PurchaseDetails>? purchases;

  static Future<void> fetchCoinPlans() async {
    isLoading.value = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    final model = await FetchCoinPlanApi.callApi(token: token, uid: uid);

    coinPlans.value = model?.data ?? [];
    isLoading.value = false;
  }

  static void onChangePayment(int value) {
    selectedPaymentIndex.value = value;
  }

  static Future<void> show({required BuildContext context}) async {
    fetchCoinPlans();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: Get.height,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SizedBox(
        height: Get.height / 1.2,
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: 65,
              width: Get.width,
              color: AppColor.secondary.withValues(alpha: 0.1),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(AppAssets.icCoinStar),
                                height: 18,
                                width: 18,
                              ),
                              5.width,
                              Obx(
                                () => Text(
                                  CustomFormatNumber.onConvert(FetchUserCoin.coin.value),
                                  style: AppFontStyle.styleW700(AppColor.orange, 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        10.height,
                        Text(
                          EnumLocal.txtTopUpCoins.name.tr,
                          style: AppFontStyle.styleW700(AppColor.black, 17),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Image.asset(
                                width: 30,
                                AppAssets.icClose,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            15.height,
            Expanded(
              child: Obx(
                () => isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CoinRechargeCoinShimmerWidget(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                EnumLocal.txtPurchaseCoins.name.tr,
                                style: AppFontStyle.styleW700(AppColor.black, 16),
                              ),
                            ),
                            5.height,
                            purchaseCoinWidget(),
                            15.height,
                            if (Platform.isAndroid)paymentGetWayWidget(),
                            const SizedBox(height: 15),
                            SafeArea(child: Visibility(
                              visible: true,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: AppButtonUi(
                                  fontSize: 16,
                                  gradient: AppColor.primaryGradient,
                                  title: EnumLocal.txtPayNow.name.tr,
                                  callback: (){
                                    if(currentContext != null){
                                      onClickPayNow(index: selectedProductIndex.value ?? 0, context:currentContext!);
                                    }

                                  },
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget paymentGetWayWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                EnumLocal.txtSelectPaymentGateway.name.tr,
                style: AppFontStyle.styleW700(AppColor.black, 16),
              ),
            ),
            15.height,

            _ListItemWidget(
              icon: Assets.images.payStripe.image(width: 32,height: 32),
              title: 'stripe',
              isSelected: selectedPaymentIndex.value == 1,
              onTap: () => onChangePayment(1),
              visible: Utils.isShowStripePaymentMethod,
            ),
            15.height,
          ],
        ),
    );
  }

  static Widget purchaseCoinWidget() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        itemCount: coinPlans.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 100,
        ),
        itemBuilder: (BuildContext context, int index) {
          final indexData = coinPlans[index];
          return ItemWidget(
            callback: () => onChoiceProduct(index: index, context: context),
            amount: (indexData.amount ?? 0).toDouble(),
            coin: (indexData.coin ?? 0).toInt(),
            isPopular: indexData.isPopular ?? false,
            index: index,
          );
        },
      ),
    ));
  }

  static onChoiceProduct({required int index, required BuildContext context}) async {
    selectedProductIndex.value = index;
    currentContext = context;
  }
  
  static void onClickPayNow({required int index, required BuildContext context}) async {
    if (Platform.isIOS){
      onClickInAppPurchase(index: index);
      return;
    }
    switch (selectedPaymentIndex.value) {
      case 1:
        onClickStripePay(index: index);
        break;
      case 3:
        onClickInAppPurchase(index: index);
      default:
        Utils.showToast(text: EnumLocal.txtPleaseSelectPaymentGateway.name.tr);
    }
  }

  static void onClickStripePay({required int index}) async {
    try {
      Utils.showLog("Stripe Payment Working...");
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      await StripeService().init(isTest: true);
      await 1.seconds.delay();
      StripeService().stripePay(
          coinPlanId: coinPlans[index].id ?? '',
          callback: () async {

          });
      Get.back(); // Stop Loading...
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Stripe Payment Failed !! => $e");
    }
  }
  

  static void onClickInAppPurchase({required int index}) async {
    String productKey = coinPlans[index].productKey ?? "";
    List<String> kProductIds = <String>[productKey];

    InAppPurchaseHelper().init(
      productIds: kProductIds, // 这里可以传多个产品id，初始化时用，但buyProduct只传一个
      onSuccess: () {

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

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.coin,
    required this.amount,
    required this.isPopular,
    required this.index,      // 新增 index
    required this.callback,
  });

  final int coin;
  final double amount;
  final bool isPopular;
  final int index;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = CoinPurchaseBottomSheet.selectedProductIndex.value == index;
      final bgColor = isSelected ? HexColor('#09E6AA') : HexColor('#F8F8F8');
      final textColor = isSelected ? AppColor.white : AppColor.black;
      final subTextColor = isSelected ? AppColor.white : HexColor('#A8A8AC');

      return SizedBox(
        child: Stack(
          children: [
            GestureDetector(
              onTap: callback,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    25.height,
                    Text(
                      "$coin ${EnumLocal.txtCoin.name.tr}",
                      style: AppFontStyle.styleW800(textColor, 16),
                    ),
                    8.height,
                    Text(
                      "${Utils.currencySymbol} ${amount.toStringAsFixed(2)}",
                      style: AppFontStyle.styleW500(subTextColor, 12),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isPopular,
              child: Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                    color: HexColor('#09E6AA'),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: Text(
                        EnumLocal.txtMostPopularPlan.name.tr,
                        style: AppFontStyle.styleW700(AppColor.white, 8),
                        overflow: TextOverflow.visible,
                        softWrap: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.icon,
    required this.boxWidth,
    required this.iconSize,
    required this.isSelected,
    required this.callback,
    this.margin,
    required this.visible,
  });

  final String icon;
  final double boxWidth;
  final double iconSize;
  final bool isSelected;
  final EdgeInsetsGeometry? margin;
  final Callback callback;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 40,
          width: boxWidth,
          alignment: Alignment.center,
          margin: margin,
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColor.orange : AppColor.transparent),
          ),
          child: Image.asset(icon, width: iconSize),
        ),
      ),
    );
  }
}

class PaymentGatewayWidget extends StatelessWidget {
  const PaymentGatewayWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            EnumLocal.txtSelectPaymentGateway.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
        ),
        15.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              15.width,
              _ItemWidget(
                icon: AppAssets.icStripeLogo,
                iconSize: 40,
                boxWidth: 80,
                isSelected: true,
                // controller.selectedPaymentIndex == 0,
                callback: () {
                  // handlePayNow(0);
                },
                // controller.onChangePayment(0),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ItemWidget(
                icon: AppAssets.icRazorpayLogo,
                iconSize: 75,
                boxWidth: 110,
                margin: EdgeInsets.only(left: 15),
                isSelected: true,
                callback: () {},
                // isSelected: controller.selectedPaymentIndex == 1,
                // callback: () => controller.onChangePayment(1),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ItemWidget(
                icon: AppAssets.icFlutterWaveLogo,
                iconSize: 120,
                boxWidth: 140,
                margin: EdgeInsets.only(left: 15),
                isSelected: true,

                callback: () {},
                // isSelected: controller.selectedPaymentIndex == 2,
                // callback: () => controller.onChangePayment(2),
                visible: Utils.isShowStripePaymentMethod,
              ),
              15.width,
            ],
          ),
        ),
        15.height,
      ],
    );
  }
}

class _ListItemWidget extends StatelessWidget {
  const _ListItemWidget({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.visible,
  });

  final Widget icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: HexColor('#F8F8F8'),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColor.primary : AppColor.transparent,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              icon,
              12.width,
              Expanded(
                child: Text(
                  title,
                  style: AppFontStyle.styleW500(AppColor.black, 14),
                ),
              ),
              isSelected ? Assets.images.payYes.image(width: 24,height: 24) : Assets.images.payNo.image(width: 24,height: 24),
            ],
          ),
        ),
      ),
    );
  }
}