import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OnBoardingScreenTwoWidget extends StatelessWidget {
  const OnBoardingScreenTwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            AppAssets.imgOnBoarding_2,
            height: Get.height,
            width: Get.width,
          ),
        ),
        Text(
          EnumLocal.txtUnlockTheDoorToYourHeartsDesire.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW900(AppColor.black, 28),
        ),
        15.height,
        Text(
          EnumLocal.txtDiscoverMeaningfulConnectionsTailored.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW500(AppColor.black, 12),
        ),
      ],
    );
  }
}
