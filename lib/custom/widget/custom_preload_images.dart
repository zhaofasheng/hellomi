import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';

class CustomPreloadImages extends StatelessWidget {
  const CustomPreloadImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.imgReferralBg,
          height: 10,
          width: 10,
        ),
        Container(
          height: Get.height,
          width: Get.width,
          color: AppColor.white,
        ),
      ],
    );
  }
}
