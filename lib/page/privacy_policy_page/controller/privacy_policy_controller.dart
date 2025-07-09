import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/enums.dart';

class PrivacyPolicyController extends GetxController {
  WebViewController? webViewController;
  late String title;
  late String url;

  @override
  void onInit() {
    // 读取 arguments 参数
    final args = Get.arguments as Map<String, dynamic>?;

    title = args?['title'] ?? EnumLocal.txtPrivacyPolicy.name.tr;
    url = args?['url'] ?? Utils.privacyPolicyLink;

    onInitializeWebView();
    super.onInit();
  }

  void onInitializeWebView() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.white)
      ..loadRequest(Uri.parse(url));
    update([AppConstant.onInitializeWebView]);
  }
}
