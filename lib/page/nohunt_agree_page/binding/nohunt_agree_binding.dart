import 'package:get/get.dart';
import '../controller/nohunt_agree_controller.dart';

class NoHuntAgreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoHuntAgreeController>(() => NoHuntAgreeController());
  }
}
