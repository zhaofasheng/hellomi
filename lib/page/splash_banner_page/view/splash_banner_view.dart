import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/widget/custom_preload_images.dart';
import 'package:tingle/page/splash_banner_page/controller/splash_banner_controller.dart';
import 'package:tingle/page/splash_screen_page/controller/splash_screen_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SplashBannerView extends GetView<SplashBannerController> {
  const SplashBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: PreviewPostImageWidget(
              image: controller.bannerImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 10,
            right: 15,
            child: GetBuilder<SplashBannerController>(
              id: AppConstant.onChangeTime,
              builder: (controller) => GestureDetector(
                onTap: () => Get.offAllNamed(AppRoutes.bottomBarPage),
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "${controller.autoSkipCount} ${EnumLocal.txtSkip.name.tr}",
                    style: AppFontStyle.styleW500(AppColor.white, 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
