import 'package:get/get.dart';
import 'package:tingle/page/preview_created_reels_page/controller/preview_created_reels_controller.dart';

class PreviewCreatedReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewCreatedReelsController>(() => PreviewCreatedReelsController());
  }
}
