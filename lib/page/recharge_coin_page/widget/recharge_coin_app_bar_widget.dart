import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RechargeCoinAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 60),
      child: Container(
        height: MediaQuery.of(context).viewPadding.top + 60,
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(color: AppColor.white, boxShadow: [
          BoxShadow(color: AppColor.secondary.withValues(alpha: 0.15), spreadRadius: 2, blurRadius: 2),
        ]),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 110,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
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
                ),
              ),
              Text(
                EnumLocal.txtTopUpCoins.name.tr,
                style: AppFontStyle.styleW700(AppColor.black, 18),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.withdrawPage),
                child: Container(
                  height: 35,
                  width: 110,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withValues(alpha: 0.3),
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.icWithdraw,
                        height: 17,
                        width: 17,
                      ),
                      5.width,
                      Text(
                        EnumLocal.txtWithdraw.name.tr,
                        style: AppFontStyle.styleW700(AppColor.white, 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
