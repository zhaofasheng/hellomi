import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PrivacyPolicyAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context, {String? title}) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return PreferredSize(
      preferredSize: Size.fromHeight(topPadding + 50),
      child: Container(
        height: topPadding + 50,
        padding: EdgeInsets.only(top: topPadding),
        alignment: Alignment.center,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.secondary.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 返回按钮
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.transparent,
                ),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  width: 10,
                ),
              ),
            ),
            // 标题
            Expanded(
              child: Text(
                title ?? EnumLocal.txtPrivacyPolicy.name.tr,
                style: AppFontStyle.styleW600(AppColor.black, 16),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 占位符
            const SizedBox(width: 45),
          ],
        ),
      ),
    );
  }
}
