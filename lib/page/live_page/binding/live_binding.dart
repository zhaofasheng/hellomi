import 'package:get/get.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';

class LiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveController>(() => LiveController());
  }
}
