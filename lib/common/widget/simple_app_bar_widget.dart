import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SimpleAppBarWidget {
  static PreferredSizeWidget onShow({
    required BuildContext context,
    required String title,
    String? icon,
    Callback? callBack,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 50),
      child: Container(
        height: MediaQuery.of(context).viewPadding.top + 50,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(color: AppColor.secondary.withValues(alpha: 0.15), spreadRadius: 2, blurRadius: 2),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  width: 10,
                ),
              ),
            ),
            Text(
              title,
              style: AppFontStyle.styleW700(AppColor.black, 16),
            ),
            GestureDetector(
              onTap: callBack,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 4),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                child: icon != null
                    ? Image.asset(
                        icon,
                        width: 22,
                        color: AppColor.black,
                      )
                    : Offstage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
