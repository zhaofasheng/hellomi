import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_shimmer_ui.dart';
import 'package:tingle/page/coin_seller_page/controller/coin_seller_controller.dart';
import 'package:tingle/page/coin_seller_page/model/fetch_coin_seller_history_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinSellerHistoryWidget extends StatelessWidget {
  const CoinSellerHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: SimpleAppBarWidget.onShow(context: context, title: EnumLocal.txtCoinTradingHistory.name.tr),
      body: GetBuilder<CoinSellerController>(
        id: ApiParams.onGetCoinSellerHistory,
        builder: (controller) {
          return controller.isHistoryLoading
              ? CoinHistoryShimmerUi()
              : controller.coinSellerHistory.isEmpty
                  ? RefreshIndicator(
                      color: AppColor.primary,
                      onRefresh: () => controller.onRefreshHistory(),
                      child: LayoutBuilder(builder: (context, box) {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: box.maxHeight + 1,
                            child: NoDataFoundWidget(),
                          ),
                        );
                      }),
                    )
                  : RefreshIndicator(
                      color: AppColor.primary,
                      onRefresh: () => controller.onRefreshHistory(),
                      child: LayoutBuilder(builder: (context, box) {
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: box.maxHeight + 1,
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.coinSellerHistory.length,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(12),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final userData = controller.coinSellerHistory[index];
                                  return CoinSellerItemWidget(history: userData);
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                    );
        },
      ),
    );
  }
}

class CoinSellerItemWidget extends StatelessWidget {
  const CoinSellerItemWidget({super.key, this.history});

  final History? history;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.colorBorder.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: history?.userId == null ? Image.asset(AppAssets.icLogo) : PreviewProfileImageWidget(image: history?.userId?.image ?? '', isBanned: history?.userId?.isProfilePicBanned),
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history?.userId == null
                    ? history?.isIncome ?? false
                        ? EnumLocal.txtAddedByAdmin.name.tr
                        : EnumLocal.txtDeductedByAdmin.name.tr
                    : history?.userId?.name ?? '',
                style: AppFontStyle.styleW700(AppColor.black, 13),
              ),
              2.height,
              history?.userId == null
                  ? Text(
                      history?.date ?? '',
                      style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 10),
                    )
                  : Text(
                      history?.userId?.uniqueId ?? '',
                      style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 10),
                    ),
            ],
          ),
          Spacer(),
          Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: history?.isIncome ?? false ? AppColor.green.withValues(alpha: 0.05) : AppColor.red.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                history?.isIncome ?? false ? "${"+"} ${CustomFormatNumber.onConvert(history?.coin ?? 0)}" : "${"-"} ${CustomFormatNumber.onConvert(history?.coin ?? 0)}",
                style: AppFontStyle.styleW700(history?.isIncome ?? false ? AppColor.green : AppColor.red, 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
