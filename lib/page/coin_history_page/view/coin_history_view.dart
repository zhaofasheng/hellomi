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

class CoinHistoryView extends GetView<CoinHistoryController> {
  const CoinHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CoinHistoryAppBarWidget.onShow(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            CoinBoxWidget(),
            15.height,
            Row(
              children: [
                Text(
                  EnumLocal.txtCoinHistory.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
                Spacer(),
                GetBuilder<CoinHistoryController>(
                  id: AppConstant.onGetCoinHistory,
                  builder: (controller) => GestureDetector(
                    onTap: () async {
                      DateTimeRange? dateTimeRange = await CustomRangePicker.onShow(context: context, dateTimeRange: controller.dateTimeRange);
                      if (dateTimeRange != null) {
                        controller.dateTimeRange = dateTimeRange;

                        String startDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.start);
                        String endDate = DateFormat('yyyy-MM-dd').format(dateTimeRange.end);

                        final range = "${DateFormat('dd MMM').format(dateTimeRange.start)} - ${DateFormat('dd MMM').format(dateTimeRange.end)}";

                        Utils.showLog("Selected Date Range => $range");

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
                        border: Border.all(color: AppColor.secondary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder<CoinHistoryController>(
                            id: AppConstant.onChangeDate,
                            builder: (controller) => Text(
                              controller.rangeDate,
                              style: AppFontStyle.styleW500(AppColor.darkGrey, 12),
                            ),
                          ),
                          8.width,
                          SizedBox(
                            height: 35,
                            width: 12,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(top: 12.5, child: Icon(Icons.keyboard_arrow_down_outlined, size: 19)),
                                Positioned(top: 3.5, child: Icon(Icons.keyboard_arrow_up_rounded, size: 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            15.height,
            Expanded(
              child: LayoutBuilder(builder: (context, box) {
                return GetBuilder<CoinHistoryController>(
                  id: AppConstant.onGetCoinHistory,
                  builder: (controller) => controller.isLoading
                      ? CoinHistoryShimmerUi()
                      : controller.coinHistory.isEmpty
                          ? RefreshIndicator(
                              onRefresh: () => controller.init(),
                              color: AppColor.primary,
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  height: box.maxHeight + 1,
                                  child: NoDataFoundWidget(),
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () => controller.init(),
                              color: AppColor.primary,
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  height: box.maxHeight + 1,
                                  child: RefreshIndicator(
                                    onRefresh: () => controller.init(),
                                    color: AppColor.primary,
                                    child: SingleChildScrollView(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: controller.coinHistory.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final historyIndex = controller.coinHistory[index];
                                          return HistoryItemUi(
                                            title: historyType(
                                              type: historyIndex.type ?? 0,
                                              isIncome: historyIndex.isIncome ?? false,
                                              payoutStatus: historyIndex.payoutStatus ?? 0,
                                            ),
                                            date: historyIndex.createdAt ?? "",
                                            uniqueId: historyIndex.uniqueId ?? "",
                                            coin: (historyIndex.coin ?? 0),
                                            reason: historyIndex.reason ?? "",
                                            textColor: textColor(
                                              isIncome: historyIndex.isIncome ?? false,
                                              payoutStatus: historyIndex.payoutStatus ?? 0,
                                            ),
                                            coinSign: coinSign(
                                              isIncome: historyIndex.isIncome ?? false,
                                              payoutStatus: historyIndex.payoutStatus ?? 0,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                );
              }),
            )
          ],
        ),
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

// String historyType({required int type, required bool isIncome}) {
//   switch (type) {
//     case 1:
//       {
//         return EnumLocal.txtWelcomeBonusCoin.name.tr;
//       }
//     case 2:
//       {
//         return EnumLocal.txtPurchaseTheme.name.tr;
//       }
//     case 3:
//       {
//         return EnumLocal.txtPurchaseAvtarFrame.name.tr;
//       }
//     case 4:
//       {
//         return EnumLocal.txtPurchaseRide.name.tr;
//       }
//     case 5:
//       {
//         return EnumLocal.txtPrivateVideoCall.name.tr;
//       }
//     case 6:
//       {
//         return isIncome ? "Receive Live Gift" : "Send Live Gift";
//       }
//     case 7:
//       {
//         return EnumLocal.txtCoinPlanPurchase.name.tr;
//       }
//     case 8:
//       {
//         return EnumLocal.txtWithdrawal.name.tr;
//       }
//     case 9:
//       {
//         return EnumLocal.txtAgencyEarnCommission.name.tr;
//       }
//     case 10:
//       {
//         return EnumLocal.txtReferralReward.name.tr;
//       }
//     case 11:
//       {
//         return isIncome ? "Received Coins" : "Share Coins";
//       }
//     case 12:
//       {
//         return EnumLocal.txtTeenPattiGame.name.tr;
//       }
//     case 13:
//       {
//         return EnumLocal.txtFerryWheelGame.name.tr;
//       }
//     case 14:
//       {
//         return EnumLocal.txtCasinoGame.name.tr;
//       }
//
//     default:
//       {
//         return "";
//       }
//   }
// }
