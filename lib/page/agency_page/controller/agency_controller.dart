import 'package:get/get.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AgencyController extends GetxController {
  WebViewController? webViewController;

  String agencyId = "";

  String agencyLink = "";

  @override
  void onInit() {
    if (Get.arguments != null) agencyId = Get.arguments;

    Utils.showLog("Agency Id => $agencyId");

    agencyLink = Api.agencyLink + agencyId;

    Utils.showLog("Agency Link => $agencyLink");

    onInitializeWebView();
    super.onInit();
  }

  void onInitializeWebView() async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.white)
      ..loadRequest(Uri.parse(agencyLink));

    update([AppConstant.onInitializeWebView]);
  }
}
