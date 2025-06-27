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

class CoinSellerView extends GetView<CoinSellerController> {
  const CoinSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinSellerController>(
      id: AppConstant.onGetCoinSellerProfile,
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: SimpleAppBarWidget.onShow(context: context, title: EnumLocal.txtCoinTrading.name.tr),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: controller.isLoading
              ? CoinSellerShimmerWidget()
              : RefreshIndicator(
                  onRefresh: () async => controller.init(),
                  child: LayoutBuilder(
                    builder: (context, box) => SingleChildScrollView(
                      child: SizedBox(
                        height: box.maxHeight + 1,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CoinTradingBoxWidget(),
                              TransferWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Visibility(
          visible: controller.isLoading == false,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: AppButtonUi(
              fontSize: 16,
              gradient: AppColor.primaryGradient,
              title: EnumLocal.txtTransferNow.name.tr,
              callback: () => Utils.isDemoApp ? Utils.showToast(text: "This is Demo App") : controller.onClickTransfer(),
            ),
          ),
        ),
      ),
    );
  }
}
