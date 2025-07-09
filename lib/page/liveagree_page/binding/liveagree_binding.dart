import 'package:get/get.dart';
import '../controller/liveagree_controller.dart';

class LiveAgreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveAgreeController>(() => LiveAgreeController());
  }
}
