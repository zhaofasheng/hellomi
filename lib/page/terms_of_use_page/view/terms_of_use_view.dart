import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/terms_of_use_page/controller/terms_of_use_controller.dart';
import 'package:tingle/page/terms_of_use_page/widget/terms_of_use_app_bar_widget.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60), child: TermsOfUseAppBarWidget.onShow(context)),
      body: Utils.termsOfUseLink.trim().isEmpty
          ? NoDataFoundWidget()
          : GetBuilder<TermsOfUseController>(
              id: AppConstant.onInitializeWebView,
              builder: (controller) => controller.webViewController != null ? WebViewWidget(controller: controller.webViewController!) : const LoadingWidget(),
            ),
    );
  }
}
