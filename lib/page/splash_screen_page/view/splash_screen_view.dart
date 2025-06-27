import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/custom/widget/custom_preload_images.dart';
import 'package:tingle/page/splash_screen_page/controller/splash_screen_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.showLog("App Start... Splash Screen");
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    Get.find<SplashScreenController>();
    controller.onPrecacheAllImage(context);

    return Scaffold(
      body: Assets.images.splashScreen.image(width: Get.width,height: Get.height,fit: BoxFit.cover),
    );
  }
}
