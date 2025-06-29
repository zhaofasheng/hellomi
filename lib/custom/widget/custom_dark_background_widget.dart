import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';

class CustomDarkBackgroundWidget extends StatelessWidget {
  const CustomDarkBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Assets.images.backgroundImg.image(width: Get.width,height: Get.height,fit: BoxFit.cover),
    );

    //   Image.asset(
    //   AppAssets.imgDarkBg,
    //   fit: BoxFit.cover,
    //   height: Get.height,
    //   width: Get.width,
    // );
  }
}
