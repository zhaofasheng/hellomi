import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/function/custom_format_date.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/function/custom_range_picker.dart';
import 'package:tingle/page/coin_history_page/widget/coin_history_shimmer_ui.dart';
import 'package:tingle/page/withdraw_page/controller/withdraw_controller.dart';
import 'package:tingle/page/withdraw_page/widget/coin_withdraw_list_appbar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinWithdrawListWidget extends StatelessWidget {
  const CoinWithdrawListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoinWithdrawListAppbarWidget.onShow(context),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    EnumLocal.txtWithdrawHistory.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 16),
                  ),
                  Spacer(),
                  GetBuilder<WithdrawController>(
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
                          Utils.showLog("Selected Date Range => $startDate $endDate");

                          controller.onChangeDate(startDate: startDate, endDate: endDate, rangeDate: range);

                          controller.onGetCoinWithdrawHistory();
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
                            GetBuilder<WithdrawController>(
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
                  return GetBuilder<WithdrawController>(
                    id: AppConstant.onGetCoinHistory,
                    builder: (controller) => controller.isWithdrawLoading
                        ? CoinHistoryShimmerUi()
                        : controller.payoutRequests.isEmpty
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
                                          itemCount: controller.payoutRequests.length,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final historyIndex = controller.payoutRequests[index];
                                            return WithdrawHistoryItemUi(
                                              status: historyIndex.status ?? 0,
                                              title: historyIndex.paymentGateway ?? "",
                                              date: historyIndex.requestDate ?? "",
                                              uniqueId: historyIndex.uniqueId ?? "",
                                              coin: (historyIndex.coin ?? 0),
                                              reason: historyIndex.reason ?? "",
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
      ),
    );
  }
}

class WithdrawHistoryItemUi extends StatelessWidget {
  const WithdrawHistoryItemUi({
    super.key,
    required this.status,
    required this.title,
    required this.date,
    required this.uniqueId,
    required this.coin,
    required this.reason,
  });

  final String title;
  final String date;
  final String uniqueId;
  final int coin;
  final String reason;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.colorBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          10.width,
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColor.colorBorder.withValues(alpha: 0.6),
              ),
            ),
            child: Center(
              child: Image.asset(AppAssets.icMyCoin, width: 32),
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppFontStyle.styleW700(status == 1 ? AppColor.orange : AppColor.red, 13),
                ),
                Text(
                  CustomFormatDate.onDateConvert(date),
                  style: AppFontStyle.styleW500(AppColor.grayText, 10),
                ),
                2.height,
                Text(
                  "${EnumLocal.txtID.name.tr} $uniqueId",
                  style: AppFontStyle.styleW500(AppColor.grayText, 10),
                ),
                Visibility(
                  visible: reason != "",
                  child: SizedBox(
                    width: Get.width / 2,
                    child: Text(
                      "${EnumLocal.txtReason.name.tr} : $reason",
                      maxLines: 1,
                      style: AppFontStyle.styleW500(AppColor.grayText, 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.width,
          Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColor.red.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "${"-"} ${CustomFormatNumber.onConvert(coin)}",
                style: AppFontStyle.styleW700(status == 1 ? AppColor.orange : AppColor.red, 15),
              ),
            ),
          ),
          10.width,
        ],
      ),
    );
  }
}
