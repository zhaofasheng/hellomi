import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MyQrCodeController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();

  Future<String?> onCaptureImage() async {
    try {
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final String filePath = '$directory/$fileName.png';

      final image = await screenshotController.capture();
      if (image != null) {
        final file = File(filePath);
        await file.writeAsBytes(image);

        Utils.showLog("Capture Screen Shorts => $filePath");

        return filePath;
      } else {
        Utils.showLog("Capture Screen Shorts Failed => No image captured");
      }
    } catch (e) {
      Utils.showLog("Capture Screen Shorts Failed => $e");
    }

    return null;
  }

  Future<void> onClickDownload() async {
    Get.dialog(LoadingWidget(), barrierDismissible: false); // Show Loading...
    try {
      final filePath = await onCaptureImage();
      if (filePath != null) {
        await GallerySaver.saveImage(filePath);
        Utils.showToast(text: EnumLocal.txtDownloadSuccess.name.tr);
      }
    } catch (e) {
      Utils.showLog("Download Screen Shorts Failed => $e");
    }
    Get.back(); // Stop Loading...
  }

  Future<void> onClickWhatsapp() async {
    Get.dialog(LoadingWidget(), barrierDismissible: false); // Show Loading...
    try {
      final link = await BranchIoServices.onCreateBranchIoLink(
        id: Database.fetchLoginUserProfile()?.user?.id ?? "",
        name: Database.fetchLoginUserProfile()?.user?.name ?? "",
        userId: Database.fetchLoginUserProfile()?.user?.id ?? "",
        image: Database.fetchLoginUserProfile()?.user?.image ?? "",
        pageRoutes: BranchIoServices.profileKey,
      );

      if (link != null) {
        final Uri url = Uri.parse('https://wa.me/?text=${Database.fetchLoginUserProfile()?.user?.name ?? ""}');
        await launchUrl(url);
      }
    } catch (e) {
      Utils.showLog("Launch Url Failed => $e");
    }
    Get.back(); // Stop Loading...
  }

  Future<void> onClickCopy() async {
    try {
      final link = await BranchIoServices.onCreateBranchIoLink(
        id: Database.fetchLoginUserProfile()?.user?.id ?? "",
        name: Database.fetchLoginUserProfile()?.user?.name ?? "",
        userId: Database.fetchLoginUserProfile()?.user?.id ?? "",
        image: Database.fetchLoginUserProfile()?.user?.image ?? "",
        pageRoutes: BranchIoServices.profileKey,
      );

      if (link != null) {
        Clipboard.setData(ClipboardData(text: Database.fetchLoginUserProfile()?.user?.name ?? ""));
        Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
      }
    } catch (e) {
      Utils.showLog("Copy Text Failed => $e");
    }
  }

  Future<void> onClickShare() async {
    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
    final filePath = await onCaptureImage();

    CommonShare.onShare(
      filePath: filePath,
      id: Database.fetchLoginUserProfile()?.user?.id ?? "",
      title: Database.fetchLoginUserProfile()?.user?.name ?? "",
      userId: Database.fetchLoginUserProfile()?.user?.id ?? "",
      image: Database.fetchLoginUserProfile()?.user?.image ?? "",
      pageRoutes: BranchIoServices.profileKey,
    );

    Get.back(); // Stop Loading...
  }
}
