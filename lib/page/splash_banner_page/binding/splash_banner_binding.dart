import 'package:get/get.dart';
import 'package:tingle/page/splash_banner_page/controller/splash_banner_controller.dart';
import 'package:tingle/page/splash_screen_page/controller/splash_screen_controller.dart';

class SplashBannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashBannerController>(() => SplashBannerController());
  }
}
