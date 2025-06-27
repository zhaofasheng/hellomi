import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/about_us_page/controller/about_us_controller.dart';
import 'package:tingle/page/banner_web_view_page/controller/banner_web_view_controller.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerWebViewView extends StatelessWidget {
  const BannerWebViewView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 200);
    return Scaffold(
      body: GetBuilder<BannerWebViewController>(
        id: AppConstant.onInitializeWebView,
        builder: (controller) => controller.link.trim().isEmpty
            ? NoDataFoundWidget()
            : controller.webViewController != null
                ? WebViewWidget(controller: controller.webViewController!)
                : const LoadingWidget(),
      ),
    );
  }
}
