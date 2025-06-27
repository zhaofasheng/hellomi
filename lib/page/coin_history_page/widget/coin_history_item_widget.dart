import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_date.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class HistoryItemUi extends StatelessWidget {
  const HistoryItemUi({
    super.key,
    required this.title,
    required this.date,
    required this.uniqueId,
    required this.reason,
    required this.coin,
    required this.textColor,
    required this.coinSign,
  });

  final String title;
  final String date;
  final String uniqueId;
  final String reason;
  final int coin;
  final String coinSign;
  final Color textColor;

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
            child: Center(child: Image.asset(AppAssets.icMyCoin, width: 32)),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppFontStyle.styleW700(textColor, 13),
                ),
                Text(
                  CustomFormatDate.onConvert(date),
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
              color: textColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "$coinSign ${CustomFormatNumber.onConvert(coin)}",
                style: AppFontStyle.styleW700(textColor, 15),
              ),
            ),
          ),
          10.width,
        ],
      ),
    );
  }
}
