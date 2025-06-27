import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class CustomRangePicker {
  static Future<DateTimeRange?> onShow({required BuildContext context, DateTimeRange? dateTimeRange}) async {
    return await showRangePickerDialog(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      context: context,
      slidersColor: AppColor.black,
      maxDate: DateTime.now(),
      initialDate: dateTimeRange?.start,
      minDate: DateTime(1900, 1, 1),
      selectedRange: dateTimeRange,
      currentDate: DateTime.now(),
      barrierColor: AppColor.black.withValues(alpha: 0.8),
      enabledCellsTextStyle: AppFontStyle.styleW500(AppColor.black, 14),
      disabledCellsTextStyle: AppFontStyle.styleW500(AppColor.grayText, 13),
      singleSelectedCellTextStyle: AppFontStyle.styleW500(AppColor.white, 14),
      currentDateTextStyle: AppFontStyle.styleW500(AppColor.primary, 14),
      selectedCellsTextStyle: AppFontStyle.styleW500(AppColor.primary, 14),
      singleSelectedCellDecoration: BoxDecoration(
        color: AppColor.primary,
        shape: BoxShape.circle,
        gradient: AppColor.primaryGradient,
      ),
      currentDateDecoration: BoxDecoration(
        color: AppColor.primary.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      daysOfTheWeekTextStyle: AppFontStyle.styleW500(AppColor.black, 11),
      leadingDateTextStyle: AppFontStyle.styleW500(AppColor.black, 16),
      centerLeadingDate: true,
    );
  }
}
