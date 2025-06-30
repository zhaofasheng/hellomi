import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class CommonShare {
  static Future onShare({
    String? id,
    String? userId,
    String? title,
    String? image,
    String? pageRoutes,
    String? filePath,
    String? referralCode,
  }) async {
    try {
      Utils.showLog("SHARE ITEM ID => $id");

      Get.dialog(LoadingWidget(color: AppColor.primary), barrierDismissible: false); // Start Loading...

      Utils.showLog("Loading 1 $title");

      final link = await BranchIoServices.onCreateBranchIoLink(
        id: id ?? "",
        name: title ?? "",
        image: Api.baseUrl + (image ?? ""),
        userId: userId ?? "",
        pageRoutes: pageRoutes ?? "",
        referralCode: referralCode,
      );

      await Share.share(link ?? "");

      Get.back(); // Stop Loading...

      Utils.showLog("Share Method Called Success...");
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Share Method Called Failed => $e");
    }
  }

  static Future onShareText({required String text}) async {
    try {
      Utils.showLog("SHARE TEXT => $text");

      Get.dialog(LoadingWidget(color: AppColor.primary), barrierDismissible: false); // Start Loading...

      await Share.share(text);

      Get.back(); // Stop Loading...

      Utils.showLog("Share Text Method Called Success...");
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Share Text Method Called Failed => $e");
    }
  }
}
