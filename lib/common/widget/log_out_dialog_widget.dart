import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../assets/assets.gen.dart';

class LogOutDialogWidget {
  static Future<void> onShow() async {
    Get.dialog(
      barrierColor: AppColor.black.withOpacity(0.9),
      Dialog(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        child: Container(
          height: 385,
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
                  Assets.images.loginOut.image(width: 90),
                  10.height,
                  Text(
                    EnumLocal.txtLogOut.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 24),
                  ),
                  10.height,
                  Text(
                    textAlign: TextAlign.center,
                    EnumLocal.txtLogOutText.name.tr,
                    style: AppFontStyle.styleW400(AppColor.grayText, 12),
                  ),
                  20.height,
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Database.onLogOut();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: HexColor('#F5F5F5'),
                      ),
                      height: 52,
                      width: Get.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              EnumLocal.txtLogOut.name.tr,
                              style: AppFontStyle.styleW600(HexColor('#86868F'), 15),
                            ),
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
                        color: AppColor.secondary.withValues(alpha: 0.08),
                      ),
                      height: 52,
                      width: Get.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              EnumLocal.txtCancel.name.tr,
                              style: AppFontStyle.styleW600(HexColor('#00E4A6'), 15),
                            ),
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
