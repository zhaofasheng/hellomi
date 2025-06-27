import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLightBackgroundWidget extends StatelessWidget {
  const CustomLightBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF787DFF).withValues(alpha: 0.5),
              Color(0xFFA2AAFF).withValues(alpha: 0.5),
              Color(0xFFF0EFFF).withValues(alpha: 0.5),
              Color(0xFFF0EFFF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );

    //   Image.asset(
    //   AppAssets.imgLightBg,
    //   fit: BoxFit.cover,
    //   height: Get.height,
    //   width: Get.width,
    // );
  }
}
