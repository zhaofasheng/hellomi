import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayGameBottomSheetWidget {
  static RxBool isLoading = true.obs;

  static WebViewController? webViewController;

  static void onInitializeWebView({required String link}) async {
    try {
      isLoading.value = true;

      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(AppColor.white)
        ..loadRequest(Uri.parse(link)).then(
          (value) => isLoading.value = false,
        );
      Utils.showLog("Web View Load Success => $link");
    } catch (e) {
      Utils.showLog("Web View Load Failed => $e");
    }
  }

  static Future<void> onShow({
    required String name,
    required double height,
    required String link,
  }) async {
    onInitializeWebView(link: link);
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: height,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        name,
                        style: AppFontStyle.styleW700(AppColor.greyBlue, 17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 28,
                      width: 28,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => Stack(
                  fit: StackFit.expand,
                  children: [
                    LoadingWidget(),
                    isLoading.value == false && webViewController != null ? WebViewWidget(controller: webViewController!) : Offstage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() async {
      await 500.milliseconds.delay();
      isLoading.value = true;
      webViewController = null;
    });
  }
}
