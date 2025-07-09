import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';

class LiveAgreeController extends GetxController {
  WebViewController? webViewController;
  @override
  void onInit() {
    onInitializeWebView();
    super.onInit();
  }

  void onInitializeWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.white)
      ..loadRequest(Uri.parse(Utils.privacyPolicyLink));
    update([AppConstant.onInitializeWebView]);
  }
}
