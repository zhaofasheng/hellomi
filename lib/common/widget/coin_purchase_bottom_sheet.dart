import 'package:flutter/material.dart';
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
import 'package:tingle/payment/in_app_purchase/in_app_purchase_helper.dart';
import 'package:tingle/payment/razor_pay/razor_pay_view.dart';
import 'package:tingle/payment/stripe/stripe_service.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinPurchaseBottomSheet {
  static RxInt selectedPaymentIndex = 0.obs;

  static RxBool isLoading = true.obs;
  static RxList<Data> coinPlans = <Data>[].obs;
  static CreateCoinPlanHistoryModel? createCoinPlanHistoryModel;

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
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.secondary,
                            ),
                            child: Center(
                              child: Image.asset(
                                width: 18,
                                AppAssets.icClose,
                                color: AppColor.white,
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
                            paymentGetWayWidget(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                EnumLocal.txtPurchaseCoins.name.tr,
                                style: AppFontStyle.styleW700(AppColor.black, 16),
                              ),
                            ),
                            15.height,
                            purchaseCoinWidget(),
                            const SizedBox(height: 15),
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
    return SizedBox(
      height: 100,
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
          (Utils.isShowStripePaymentMethod || Utils.isShowRazorPayPaymentMethod || Utils.isShowInAppPurchasePaymentMethod || Utils.isShowFlutterWavePaymentMethod)
              ? SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _ItemWidget(
                        icon: AppAssets.icStripeLogo,
                        iconSize: 40,
                        boxWidth: 80,
                        isSelected: selectedPaymentIndex.value == 0,
                        callback: () => onChangePayment(0),
                        visible: Utils.isShowStripePaymentMethod,
                      ),
                      _ItemWidget(
                        icon: AppAssets.icRazorpayLogo,
                        iconSize: 75,
                        boxWidth: 110,
                        margin: EdgeInsets.only(left: 15),
                        isSelected: selectedPaymentIndex.value == 1,
                        callback: () => onChangePayment(1),
                        visible: Utils.isShowStripePaymentMethod,
                      ),
                      _ItemWidget(
                        icon: AppAssets.icFlutterWaveLogo,
                        iconSize: 120,
                        boxWidth: 140,
                        margin: EdgeInsets.only(left: 15),
                        isSelected: selectedPaymentIndex.value == 2,
                        callback: () => onChangePayment(2),
                        visible: Utils.isShowFlutterWavePaymentMethod,
                      ),
                      _ItemWidget(
                        icon: AppAssets.icInAppPurchaseLogo,
                        iconSize: 120,
                        boxWidth: 140,
                        margin: EdgeInsets.only(left: 15),
                        isSelected: selectedPaymentIndex.value == 3,
                        callback: () => onChangePayment(3),
                        visible: Utils.isShowInAppPurchasePaymentMethod,
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 50,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.colorBorder.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    EnumLocal.txtPaymentGatewayNotAvailable.name.tr,
                    style: AppFontStyle.styleW600(AppColor.grayText, 13),
                  ),
                ),
          15.height,
        ],
      ),
    );
  }

  static Widget purchaseCoinWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        itemCount: coinPlans.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          mainAxisExtent: 200,
        ),
        itemBuilder: (BuildContext context, int index) {
          final indexData = coinPlans[index];

          return ItemWidget(
            callback: () => onClickPayNow(index: index, context: context),
            amount: (indexData.amount ?? 0).toDouble(),
            coin: (indexData.coin ?? 0).toInt(),
            isPopular: indexData.isPopular ?? false,
          );
        },
      ),
    );
  }

  static void onClickPayNow({required int index, required BuildContext context}) async {
    switch (selectedPaymentIndex.value) {
      case 0:
        onClickStripePay(index: index);
        break;
      case 1:
        onClickRazorPay(index: index);
        break;
      case 2:
        onClickFlutterWave(index: index, context: context);
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
              Get.back(); // Close Bottom Sheet...
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

  static void onClickRazorPay({required int index}) async {
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
            Get.back(); // Close Bottom Sheet...
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

  static void onClickFlutterWave({required int index, required BuildContext context}) async {
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
            Get.back(); // Close Bottom Sheet...
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

  static void onClickInAppPurchase({required int index}) async {
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
          Get.back(); // Close Bottom Sheet...
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

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.coin,
    required this.amount,
    required this.isPopular,
    required this.callback,
  });

  final int coin;
  final double amount;
  final bool isPopular;
  final Callback callback;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.orange, width: 1),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                12.height,
                Center(
                  child: Image.asset(AppAssets.icMyCoin, width: 58),
                ),
                10.height,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.orange.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${CustomFormatNumber.onConvert(coin)} Coin",
                    style: AppFontStyle.styleW700(AppColor.orange.withValues(alpha: 0.6), 11),
                  ),
                ),
                8.height,
                Text(
                  "${Utils.currencySymbol} ${CustomFormatNumber.onConvert(amount.toInt())}",
                  style: AppFontStyle.styleW900(AppColor.orange, 20),
                ),
                8.height,
                GestureDetector(
                  onTap: callback,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: AppColor.orangeYellowGradient,
                    ),
                    height: 42,
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            EnumLocal.txtPayNow.name.tr,
                            style: AppFontStyle.styleW700(AppColor.white, 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isPopular,
            child: Positioned(
              top: 20,
              right: -22,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  height: 18,
                  width: 100,
                  decoration: BoxDecoration(gradient: AppColor.orangeYellowGradient),
                  child: Center(
                    child: Text(
                      EnumLocal.txtMostPopularPlan.name.tr,
                      style: AppFontStyle.styleW700(AppColor.white, 8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
          child: Row(
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

// Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       child: Text(
//         EnumLocal.txtSelectPaymentGateway.name.tr,
//         style: AppFontStyle.styleW700(AppColor.black, 16),
//       ),
//     ),
//     15.height,
//     SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           15.width,
//           _ItemWidget(
//             icon: AppAssets.icStripeLogo,
//             iconSize: 40,
//             boxWidth: 80,
//             isSelected: true,
//             // controller.selectedPaymentIndex == 0,
//             callback: () {
//               handlePayNow(0);
//             },
//             // controller.onChangePayment(0),
//             visible: Utils.isShowStripePaymentMethod,
//           ),
//           _ItemWidget(
//             icon: AppAssets.icRazorpayLogo,
//             iconSize: 75,
//             boxWidth: 110,
//             margin: EdgeInsets.only(left: 15),
//             isSelected: true,
//             callback: () {},
//             // isSelected: controller.selectedPaymentIndex == 1,
//             // callback: () => controller.onChangePayment(1),
//             visible: Utils.isShowStripePaymentMethod,
//           ),
//           _ItemWidget(
//             icon: AppAssets.icFlutterWaveLogo,
//             iconSize: 120,
//             boxWidth: 140,
//             margin: EdgeInsets.only(left: 15),
//             isSelected: true,
//
//             callback: () {},
//             // isSelected: controller.selectedPaymentIndex == 2,
//             // callback: () => controller.onChangePayment(2),
//             visible: Utils.isShowStripePaymentMethod,
//           ),
//           15.width,
//         ],
//       ),
//     ),
//     15.height,
//   ],
// );
