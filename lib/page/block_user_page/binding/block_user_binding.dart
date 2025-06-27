import 'package:get/get.dart';
import 'package:tingle/page/block_user_page/controller/block_user_controller.dart';

class BlockUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockUserController>(() => BlockUserController());
  }
}
