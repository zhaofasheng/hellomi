import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OnBoardingScreenThreeWidget extends StatelessWidget {
  const OnBoardingScreenThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.imgOnBoarding_3,
              height: Get.width / 1.1,
              width: Get.width / 1.1,
            ),
          ),
        ),
        Text(
          EnumLocal.txtStartYourLoveStoryWithASwipeAndSmile.name.tr,
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW900(AppColor.black, 28),
        ),
        15.height,
        Text(
          "",
          textAlign: TextAlign.center,
          style: AppFontStyle.styleW500(AppColor.black, 12),
        ),
      ],
    );
  }
}
