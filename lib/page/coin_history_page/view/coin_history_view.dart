import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/function/custom_format_date.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_range_picker.dart';
import 'package:tingle/page/coin_history_page/controller/coin_history_controller.dart';
import 'package:tingle/page/coin_history_page/widget/coin_box_widget.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_app_bar_widget.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_item_widget.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_shimmer_ui.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../custom/widget/custom_light_background_widget.dart';
import '../../level_page/widget/level_app_bar_widget.dart';

class CoinHistoryView extends GetView<CoinHistoryController> {
  const CoinHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      body: Stack(
        children: [
          /// 背景图（可只铺顶部区域）
          const CustomLightBackgroundWidget(),

          /// 正文
          Column(
            children: [
              LevelAppBarWidget(title: EnumLocal.txtCoins.name.tr),

              /// 主体内容
              Expanded(
                child: GetBuilder<CoinHistoryController>(
                  id: AppConstant.onGetCoinHistory,
                  builder: (controller) => RefreshIndicator(
                    onRefresh: () => controller.init(),
                    color: AppColor.primary,
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        15.height,
                        CoinBoxWidget(),
                        15.height,

                        /// 日期选择
                        Row(
                          children: [
                            Text(
                              EnumLocal.txtCoinHistory.name.tr,
                              style: AppFontStyle.styleW500(AppColor.black, 14),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                DateTimeRange? dateTimeRange = await CustomRangePicker.onShow(
                                  context: context,
                                  dateTimeRange: controller.dateTimeRange,
                                );
                                if (dateTimeRange != null) {
                                  final startDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.start);
                                  final endDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.end);
                                  final range = "${DateFormat('dd MMM').format(dateTimeRange.start)} - ${DateFormat('dd MMM').format(dateTimeRange.end)}";
                                  controller.onChangeDate(startDate: startDate, endDate: endDate, rangeDate: range);
                                  controller.onGetCoinHistory();
                                }
                              },
                              child: Container(
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    GetBuilder<CoinHistoryController>(
                                      id: AppConstant.onChangeDate,
                                      builder: (c) => Text(
                                        c.rangeDate,
                                        style: AppFontStyle.styleW500(AppColor.darkGrey, 12),
                                      ),
                                    ),
                                    8.width,
                                    Icon(Icons.keyboard_arrow_down_outlined, size: 19),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        15.height,

                        /// 内容列表
                        if (controller.isLoading)
                          CoinHistoryShimmerUi()
                        else if (controller.coinHistory.isEmpty)
                          SizedBox(
                            height: 300,
                            child: NoDataFoundWidget(),
                          )
                        else
                          ...controller.coinHistory.map((item) {
                            return HistoryItemUi(
                              title: historyType(
                                type: item.type ?? 0,
                                isIncome: item.isIncome ?? false,
                                payoutStatus: item.payoutStatus ?? 0,
                              ),
                              date: item.createdAt ?? "",
                              uniqueId: item.uniqueId ?? "",
                              coin: item.coin ?? 0,
                              reason: item.reason ?? "",
                              textColor: textColor(
                                isIncome: item.isIncome ?? false,
                                payoutStatus: item.payoutStatus ?? 0,
                              ),
                              coinSign: coinSign(
                                isIncome: item.isIncome ?? false,
                                payoutStatus: item.payoutStatus ?? 0,
                              ),
                            );
                          }).toList(),

                        30.height,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String coinSign({required int payoutStatus, required bool isIncome}) {
  switch (payoutStatus) {
    case 0:
      {
        return isIncome ? "+" : "-";
      }
    case 1:
      {
        return "";
      }
    case 2:
      {
        return "-";
      }
    case 3:
      {
        return "";
      }

    default:
      {
        return "";
      }
  }
}

Color textColor({required int payoutStatus, required bool isIncome}) {
  switch (payoutStatus) {
    case 0:
      {
        return isIncome ? AppColor.green : AppColor.red;
      }
    case 1:
      {
        return AppColor.orange;
      }
    case 2:
      {
        return AppColor.red;
      }
    case 3:
      {
        return AppColor.black;
      }

    default:
      {
        return AppColor.grayText;
      }
  }
}

String historyType({
  required int type,
  required bool isIncome,
  required int payoutStatus,
}) {
  switch (type) {
    case 1:
      {
        return EnumLocal.txtLoginBonus.name.tr;
      }
    case 2:
      {
        return EnumLocal.txtPurchaseTheme.name.tr;
      }
    case 3:
      {
        return EnumLocal.txtPurchaseAvtarFrame.name.tr;
      }
    case 4:
      {
        return EnumLocal.txtPurchaseRide.name.tr;
      }
    case 5:
      {
        return EnumLocal.txtPrivateVideoCall.name.tr;
      }
    case 6:
      {
        return EnumLocal.txtLiveGift.name.tr;
      }
    case 7:
      {
        return EnumLocal.txtPurchasedCoinPlane.name.tr;
      }
    case 8:
      {
        return payoutStatus == 1
            ? EnumLocal.txtPendingWithdrawal.name.tr
            : payoutStatus == 2
                ? EnumLocal.txtWithdrawal.name.tr
                : EnumLocal.txtDeclineWithdrawal.name.tr;
      }
    case 9:
      {
        return EnumLocal.txtAgencyEarnCommission.name.tr;
      }
    case 10:
      {
        return EnumLocal.txtReferralReward.name.tr;
      }
    case 11:
      {
        return EnumLocal.txtBonusReward.name.tr;
      }
    case 12:
      {
        return EnumLocal.txtTeenPattiGame.name.tr;
      }
    case 13:
      {
        return EnumLocal.txtFerryWheelGame.name.tr;
      }
    case 14:
      {
        return EnumLocal.txtCasinoGame.name.tr;
      }
    case 15:
      {
        return EnumLocal.txtLuckyGiftWin.name.tr;
      }

    default:
      {
        return "";
      }
  }
}
