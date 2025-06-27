import 'package:get/get.dart';
import 'package:tingle/page/scan_qr_code_page/controller/scan_qr_code_controller.dart';

class ScanQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrCodeController>(() => ScanQrCodeController());
  }
}
