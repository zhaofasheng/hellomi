import 'package:get/get.dart';
import 'package:tingle/page/host_request_page/controller/host_request_controller.dart';

class HostRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostRequestController>(() => HostRequestController());
  }
}
