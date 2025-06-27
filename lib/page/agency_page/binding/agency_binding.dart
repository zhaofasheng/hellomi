import 'package:get/get.dart';
import 'package:tingle/page/agency_page/controller/agency_controller.dart';

class AgencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgencyController>(() => AgencyController());
  }
}
