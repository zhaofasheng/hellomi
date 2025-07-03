import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/page/withdraw_page/controller/withdraw_controller.dart';
import 'package:tingle/page/withdraw_page/shimmer/withdraw_shimmer_widget.dart';
import 'package:tingle/page/withdraw_page/widget/coin_withdraw_list_widget.dart';
import 'package:tingle/page/withdraw_page/widget/withdraw_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';
import '../../../custom/widget/custom_light_background_widget.dart';
import '../../level_page/widget/level_app_bar_widget.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            const CustomLightBackgroundWidget(),
            Positioned.fill(
              child: Column(
                children: [
                  LevelAppBarWidget(title: EnumLocal.txtWithdraw.name.tr),
                  Expanded(
                    child: GetBuilder<WithdrawController>(
                      id: ApiParams.onGetWithdrawMethods,
                      builder: (controller) => controller.isLoading
                          ? WithdrawShimmerUi()
                          : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            15.height,
                            SizedBox(
                              height: 160,
                              width: Get.width,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Assets.images.jinbiBack.image(
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    child: SizedBox(
                                      height: 160,
                                      width: Get.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.white.withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                                              child: Text(
                                                EnumLocal.txtWithdrawAbleCoins.name.tr,
                                                style: AppFontStyle.styleW600(AppColor.white, 12),
                                              ),
                                            ),
                                          ),
                                          10.height,
                                          Row(
                                            children: [
                                              Assets.images.tuijianGold.image(width: 40),
                                              10.width,
                                              Text(
                                                CustomFormatNumber.onConvert(controller.profileController.fetchUserProfileModel?.user?.receivedCoins ?? 0),
                                                style: AppFontStyle.styleW900(AppColor.white, 32),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () => Get.to(() => CoinWithdrawListWidget()),
                                                child: Container(
                                                  height: 35,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.white,
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Assets.images.ybjioayiHistory.image(width: 20),
                                                      4.width,
                                                      Text(
                                                        EnumLocal.txtHistory.name.tr,
                                                        style: AppFontStyle.styleW500(HexColor('#FF5D03'), 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          5.height,
                                          Divider(color: AppColor.white.withValues(alpha: 0.5)),
                                          3.height,
                                          SizedBox(
                                            height: 30,
                                            width: double.infinity,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppAssets.icLeftHand,
                                                  width: 25,
                                                  height: 25,
                                                  color: AppColor.white,
                                                ),
                                                8.width,
                                                Text(
                                                  "${Database.fetchAdminSetting()?.data?.minCoinsToCashOut ?? 0} ${EnumLocal.txtCoin.name.tr}",
                                                  style: AppFontStyle.styleW700(AppColor.white, 14),
                                                ),
                                                3.width,
                                                Assets.images.tuijianGold.image(width: 20),
                                                8.width,
                                                Text(
                                                  "=  ${Database.fetchAdminSetting()?.data?.currency?.symbol ?? ""} ${Utils.withdrawAmount}",
                                                  style: AppFontStyle.styleW700(AppColor.white, 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            15.height,
                            EnterCoinFieldUi(),
                            10.height,
                            Text(
                              EnumLocal.txtSelectPaymentGateway.name.tr,
                              style: AppFontStyle.styleW500(AppColor.black, 14),
                            ),
                            5.height,
                            GetBuilder<WithdrawController>(
                              id: ApiParams.onSwitchWithdrawMethod,
                              builder: (controller) => GestureDetector(
                                onTap: controller.onSwitchWithdrawMethod,
                                child: Container(
                                  height: 54,
                                  width: Get.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: controller.selectedPaymentMethod == null
                                      ? Row(
                                    children: [
                                      5.width,
                                      Text(
                                        EnumLocal.txtSelectPaymentGateway.name.tr,
                                        style: AppFontStyle.styleW500(HexColor('#86868F'), 14),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_drop_down, size: 20),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        child: Center(
                                          child: PreviewPostImageWidget(
                                            image: controller.withdrawMethods[controller.selectedPaymentMethod ?? 0].image ?? "",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      15.width,
                                      Text(
                                        controller.withdrawMethods[controller.selectedPaymentMethod ?? 0].name ?? "",
                                        style: AppFontStyle.styleW700(AppColor.black, 15),
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<WithdrawController>(
                              id: ApiParams.onChangePaymentMethod,
                              builder: (controller) => AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: controller.isShowPaymentMethod
                                    ? Column(
                                  children: [
                                    15.height,
                                    for (int index = 0; index < controller.withdrawMethods.length; index++)
                                      GestureDetector(
                                        onTap: () => controller.onChangePaymentMethod(index),
                                        child: Container(
                                          height: 54,
                                          width: Get.width,
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          margin: const EdgeInsets.only(bottom: 15),
                                          decoration: BoxDecoration(
                                            color: AppColor.colorBorder.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(14),
                                            border: Border.all(color: AppColor.colorBorder.withValues(alpha: 0.6)),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 35,
                                                child: Center(
                                                  child: PreviewPostImageWidget(
                                                    image: controller.withdrawMethods[index].image ?? "",
                                                  ),
                                                ),
                                              ),
                                              15.width,
                                              Text(
                                                controller.withdrawMethods[index].name ?? "",
                                                style: AppFontStyle.styleW700(AppColor.black, 15),
                                              ),
                                              Spacer(),
                                              RadioItem(isSelected: controller.selectedPaymentMethod == index),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                                    : const SizedBox(),
                              ),
                            ),
                            15.height,
                            GetBuilder<WithdrawController>(
                              id: ApiParams.onChangePaymentMethod,
                              builder: (controller) => controller.selectedPaymentMethod == null
                                  ? const Offstage()
                                  : Column(
                                children: [
                                  for (int i = 0;
                                  i < controller.withdrawMethods[controller.selectedPaymentMethod ?? 0].details!.length;
                                  i++)
                                    WithdrawDetailsItemUi(
                                      title: controller.withdrawMethods[controller.selectedPaymentMethod ?? 0].details?[i] ?? "",
                                      controller: controller.withdrawPaymentDetails[i],
                                    ),
                                ],
                              ),
                            ),
                            30.height,
                          ],
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
      bottomNavigationBar: SafeArea(
        child: GetBuilder<WithdrawController>(
          id: ApiParams.onGetWithdrawMethods,
          builder: (controller) => Visibility(
            visible: controller.isLoading == false,
            child: AppButtonUi(
              height: 60,
              color: AppColor.primary,
              title: EnumLocal.txtWithdraw.name.tr,
              margin: const EdgeInsets.all(15),
              gradient: AppColor.primaryGradient,
              iconSize: 24,
              fontSize: 17,
              callback: controller.onClickWithdraw,
            ),
          ),
        ),
      ),
    );
  }
}
