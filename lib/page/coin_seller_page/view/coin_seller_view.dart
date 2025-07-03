import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/coin_seller_page/controller/coin_seller_controller.dart';
import 'package:tingle/page/coin_seller_page/shimmer/coin_seller_shimmer_widget.dart';
import 'package:tingle/page/coin_seller_page/widget/coin_trading_box_widget.dart';
import 'package:tingle/page/coin_seller_page/widget/transfer_widget.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

import '../../../custom/widget/custom_light_background_widget.dart';
import '../../level_page/widget/level_app_bar_widget.dart';

class CoinSellerView extends GetView<CoinSellerController> {
  const CoinSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinSellerController>(
      id: AppConstant.onGetCoinSellerProfile,
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              const CustomLightBackgroundWidget(),
              Column(
                children: [
                  LevelAppBarWidget(title: EnumLocal.txtCoinTrading.name.tr),
                  Expanded( // ✅ 关键：撑满剩余区域
                    child: controller.isLoading
                        ? const Padding(
                      padding: EdgeInsets.all(15),
                      child: CoinSellerShimmerWidget(),
                    )
                        : RefreshIndicator(
                      onRefresh: () async => controller.init(),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(15),
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CoinTradingBoxWidget(),
                            SizedBox(height: 15),
                            TransferWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Visibility(
            visible: controller.isLoading == false,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: AppButtonUi(
                fontSize: 16,
                gradient: AppColor.primaryGradient,
                title: EnumLocal.txtTransferNow.name.tr,
                callback: () => Utils.isDemoApp
                    ? Utils.showToast(text: "This is Demo App")
                    : controller.onClickTransfer(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
