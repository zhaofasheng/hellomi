import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/page/recharge_coin_page/shimmer/recharge_coin_shimmer_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/agreement_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/coin_box_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/payment_gateway_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/purchase_coin_widget.dart';
import 'package:tingle/page/recharge_coin_page/widget/recharge_coin_app_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

import '../../../custom/widget/custom_light_background_widget.dart';
import '../../level_page/widget/level_app_bar_widget.dart';
import '../../preview_created_reels_page/widget/preview_created_reels_widget.dart';

class RechargeCoinView extends GetView<RechargeCoinController> {
  const RechargeCoinView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(top: false,child: Stack(
        children: [
          /// 背景图（可只铺顶部区域）
          const CustomLightBackgroundWidget(),
          /// 正文内容
          Column(
            children: [
              /// 自定义 AppBar
              LevelAppBarWidget(title: EnumLocal.txtTopUpCoins.name.tr),

              /// 页面主体内容
              Expanded(
                child: GetBuilder<RechargeCoinController>(
                  id: AppConstant.onGetCoinPlan,
                  builder: (controller) {
                    if (controller.isLoading) {
                      return RechargeCoinShimmerWidget();
                    }

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          15.height,
                          CoinBoxWidget(),
                          15.height,
                          PurchaseCoinWidget(),
                          15.height,
                          PaymentGatewayWidget(),

                          30.height,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      )),
      bottomNavigationBar: SafeArea(child: Visibility(
        visible: true,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: AppButtonUi(
            fontSize: 16,
            gradient: AppColor.primaryGradient,
            title: EnumLocal.txtPayNow.name.tr,
            callback: (){
              if(controller.currentContext != null){
                controller.onClickPayNow(index: controller.selectedProductIndex ?? 0, context: controller.currentContext!);
              }

            },
          ),
        ),
      )),
    );
  }
}