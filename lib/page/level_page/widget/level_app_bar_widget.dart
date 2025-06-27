import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LevelAppBarWidget extends StatelessWidget {
  const LevelAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 60,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      alignment: Alignment.center,
      width: Get.width,
      color: AppColor.transparent,
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
                color: AppColor.white,
                width: 10,
              ),
            ),
          ),
          Text(
            "Level",
            style: AppFontStyle.styleW700(AppColor.white, 18),
          ),
          45.width,
        ],
      ),
    );
  }
}
