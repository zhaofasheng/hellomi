import 'package:get/get.dart';
import 'package:tingle/page/host_center_page/controller/host_center_controller.dart';

class HostCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostCenterController>(() => HostCenterController());
  }
}
