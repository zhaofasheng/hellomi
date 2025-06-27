import 'package:get/get.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HostCenterController extends GetxController {
  WebViewController? webViewController;

  String agencyId = "";

  String hostCenterLink = "";

  @override
  void onInit() {
    if (Get.arguments != null) agencyId = Get.arguments;

    Utils.showLog("Host Center Id => $agencyId");

    hostCenterLink = Api.hostCenterLink + agencyId;

    Utils.showLog("Host Center Link => $hostCenterLink");

    onInitializeWebView();
    super.onInit();
  }

  void onInitializeWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.white)
      ..loadRequest(Uri.parse(hostCenterLink));

    update([AppConstant.onInitializeWebView]);
  }
}
