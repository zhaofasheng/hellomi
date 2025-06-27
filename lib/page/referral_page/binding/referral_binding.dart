import 'package:get/get.dart';
import 'package:tingle/page/referral_page/controller/referral_controller.dart';

class ReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferralController>(() => ReferralController());
  }
}
