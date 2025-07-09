import 'package:get/get.dart';
import '../controller/rechageagree_controller.dart';

class RechageAgreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechageAgreeController>(() => RechageAgreeController());
  }
}
