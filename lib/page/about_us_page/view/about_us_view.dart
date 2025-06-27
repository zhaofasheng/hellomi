import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/about_us_page/controller/about_us_controller.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 200);
    return Scaffold(
      appBar: SimpleAppBarWidget.onShow(context: context, title: EnumLocal.txtAboutUs.name.tr),
      body: Utils.privacyPolicyLink.trim().isEmpty
          ? NoDataFoundWidget()
          : GetBuilder<AboutUsController>(
              id: AppConstant.onInitializeWebView,
              builder: (controller) => controller.webViewController != null ? WebViewWidget(controller: controller.webViewController!) : const LoadingWidget(),
            ),
    );
  }
}
