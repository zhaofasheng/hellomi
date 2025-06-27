import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';

class CustomDarkBackgroundWidget extends StatelessWidget {
  const CustomDarkBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor('#93FADC').withAlpha(100),
            HexColor('#93FADC').withAlpha(76),
            HexColor('#93FADC').withAlpha(62),
            HexColor('#93FADC').withAlpha(49),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
            HexColor('#FFFFFF'),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );

    //   Image.asset(
    //   AppAssets.imgDarkBg,
    //   fit: BoxFit.cover,
    //   height: Get.height,
    //   width: Get.width,
    // );
  }
}
