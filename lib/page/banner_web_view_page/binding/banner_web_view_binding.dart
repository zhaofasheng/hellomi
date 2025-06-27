import 'package:get/get.dart';
import 'package:tingle/page/about_us_page/controller/about_us_controller.dart';
import 'package:tingle/page/banner_web_view_page/controller/banner_web_view_controller.dart';
import 'package:tingle/page/privacy_policy_page/controller/privacy_policy_controller.dart';

class BannerWebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerWebViewController>(() => BannerWebViewController());
  }
}
