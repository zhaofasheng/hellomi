import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custum_frame_image.dart';
import 'package:tingle/page/preview_theme_page/controller/preview_theme_controller.dart';
import 'package:tingle/page/theme_page/controller/theme_controller.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

// class PreviewThemView extends GetView<PreviewThemeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.black,
//       body: GetBuilder<PreviewThemeController>(
//           id: ApiParams.previewUpdate,
//           builder: (controller) => Center(
//                 child: InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: SizedBox(
//                     height: controller.itemType == ApiParams.THEME ? Get.height : Get.width,
//                     width: Get.width,
//                     child: Center(
//                       child: CustomSVGAFrameWidget(
//                         type: controller.type,
//                         itemType: controller.itemType,
//                         height: Get.height,
//                         width: Get.width,
//                         imagePath: controller.imagePath,
//                         framePath: "",
//                         svgapadding: EdgeInsets.all(0),
//                       ),
//                     ),
//                   ),
//                 ),
//               )),
//     );
//   }
// }

class PreviewThemView extends StatelessWidget {
  final int type;
  final String imagePath;
  final String itemType;
  final String framePath;

  const PreviewThemView({
    super.key,
    required this.type,
    required this.imagePath,
    required this.itemType,
    required this.framePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: InkWell(
          onTap: () {
            log("onTap OFF");
            Get.back();
          },
          child: SizedBox(
            height: itemType == ApiParams.THEME ? Get.height : Get.width,
            width: Get.width,
            child: CustomSVGAFrameWidget(
              type: type,
              itemType: itemType.toString(),
              height: Get.height,
              width: Get.width,
              imagePath: imagePath,
              framePath: "",
              svgapadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
