import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ConfirmWithdrawDialogUi {
  static Future<void> onShow(Callback callback) async {
    Get.dialog(
      barrierColor: AppColor.black.withOpacity(0.9),
      Dialog(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        child: Container(
          height: 400,
          width: 310,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.height,
                  Image.asset(
                    AppAssets.icWithdraw,
                    width: 90,
                    color: AppColor.red,
                  ),
                  10.height,
                  Text(
                    EnumLocal.txtWithdraw.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 24),
                  ),
                  10.height,
                  Text(
                    textAlign: TextAlign.center,
                    EnumLocal.txtConfirmWithdrawDialogText.name.tr,
                    style: AppFontStyle.styleW400(AppColor.grayText, 12),
                  ),
                  20.height,
                  GestureDetector(
                    onTap: callback,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.red,
                      ),
                      height: 52,
                      width: Get.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(EnumLocal.txtWithdraw.name.tr, style: AppFontStyle.styleW700(AppColor.white, 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.height,
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.secondary,
                      ),
                      height: 52,
                      width: Get.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(EnumLocal.txtCancel.name.tr, style: AppFontStyle.styleW700(AppColor.white, 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
