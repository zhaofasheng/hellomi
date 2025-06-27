import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';

class ScanQrCodeController extends GetxController {
  MobileScannerController mobileScannerController = MobileScannerController();

  @override
  void onClose() {
    mobileScannerController.dispose();
    super.onClose();
  }

  void onDetect({required BuildContext context, required BarcodeCapture barcodes}) async {
    final userId = barcodes.barcodes.first.rawValue;

    if (userId != "") {
      try {
        final object = userId ?? "";

        List<String> objectParts = object.split(",");

        if (bool.parse(objectParts[1]) == false && objectParts[0] != "" && objectParts.length == 2) {
          Utils.showLog("Scan Qr User Id => ${objectParts[0]}");

          if (objectParts[0] != Database.loginUserId) {
            if (OtherUserProfileBottomSheet.isOpenBottomSheet) return;

            if (!OtherUserProfileBottomSheet.isOpenBottomSheet) {
              Vibration.vibrate(duration: 100, amplitude: 300);
              OtherUserProfileBottomSheet.show(context: context, userID: objectParts[0]);
            }
          } else {
            Get.toNamed(AppRoutes.previewUserProfilePage, arguments: Database.loginUserId);
          }
        }
      } catch (e) {
        Utils.showLog("Scan Qr Code Is Wrong => $e");
      }
    }
  }
}
