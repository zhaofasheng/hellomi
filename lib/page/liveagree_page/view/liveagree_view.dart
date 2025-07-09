import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../common/widget/loading_widget.dart';
import '../../../common/widget/no_data_found_widget.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../privacy_policy_page/widget/privacy_policy_app_bar_widget.dart';
import '../controller/liveagree_controller.dart';

class LiveAgreeView extends StatelessWidget {
  const LiveAgreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrivacyPolicyAppBarWidget.onShow(context),
      body: Utils.privacyPolicyLink.trim().isEmpty
          ? NoDataFoundWidget()
          : GetBuilder<LiveAgreeController>(
        id: AppConstant.onInitializeWebView,
        builder: (controller) => controller.webViewController != null ? WebViewWidget(controller: controller.webViewController!) : const LoadingWidget(),
      ),
    );
  }
}
