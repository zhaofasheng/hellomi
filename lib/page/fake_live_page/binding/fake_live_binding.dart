import 'package:get/get.dart';
import 'package:tingle/page/fake_live_page/controller/fake_live_controller.dart';

class FakeLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FakeLiveController>(() => FakeLiveController());
  }
}
