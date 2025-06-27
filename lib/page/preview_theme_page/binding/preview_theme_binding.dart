import 'package:get/get.dart';
import 'package:tingle/page/preview_theme_page/controller/preview_theme_controller.dart';
import 'package:tingle/page/preview_upload_video_page/controller/preview_upload_video_controller.dart';

class PreviewThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewThemeController>(() => PreviewThemeController());
  }
}
