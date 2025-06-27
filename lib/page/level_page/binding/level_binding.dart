import 'package:get/get.dart';
import 'package:tingle/page/level_page/controller/level_controller.dart';

class LevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LevelController>(() => LevelController());
  }
}
