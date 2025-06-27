import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OnBoardingScreenOneWidget extends StatelessWidget {
  const OnBoardingScreenOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            AppAssets.imgOnBoarding_1,
            height: Get.height,
            width: Get.width,
            filterQuality: FilterQuality.low,
          ),
        ),
        Text(
          EnumLocal.txtYourJourneyToRomanceBeginsHere.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW900(AppColor.black, 28),
        ),
        15.height,
        Text(
          EnumLocal.txtTakeTheFirstStepToward.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW500(AppColor.black, 12),
        ),
      ],
    );
  }
}
