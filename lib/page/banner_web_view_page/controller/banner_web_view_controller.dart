import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerWebViewController extends GetxController {
  WebViewController? webViewController;

  String link = "";

  @override
  void onInit() {
    if (Get.arguments != null) {
      link = Get.arguments;
      onInitializeWebView();
    }
    super.onInit();
  }

  void onInitializeWebView() async {
    if (link.trim().isNotEmpty) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(AppColor.white)
        ..loadRequest(Uri.parse(link));

      update([AppConstant.onInitializeWebView]);
    }
  }
}
