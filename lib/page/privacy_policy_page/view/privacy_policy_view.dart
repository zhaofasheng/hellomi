import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/privacy_policy_page/controller/privacy_policy_controller.dart';
import 'package:tingle/page/privacy_policy_page/widget/privacy_policy_app_bar_widget.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrivacyPolicyAppBarWidget.onShow(context),
      body: Utils.privacyPolicyLink.trim().isEmpty
          ? NoDataFoundWidget()
          : GetBuilder<PrivacyPolicyController>(
              id: AppConstant.onInitializeWebView,
              builder: (controller) => controller.webViewController != null ? WebViewWidget(controller: controller.webViewController!) : const LoadingWidget(),
            ),
    );
  }
}
