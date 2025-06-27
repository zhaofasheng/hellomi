import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/agency_page/controller/agency_controller.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AgencyView extends StatelessWidget {
  const AgencyView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      appBar: SimpleAppBarWidget.onShow(
        context: context,
        title: EnumLocal.txtMyAgency.name.tr,
      ),
      body: GetBuilder<AgencyController>(
        id: AppConstant.onInitializeWebView,
        builder: (controller) => controller.webViewController != null ? WebViewWidget(controller: controller.webViewController!) : const LoadingWidget(),
      ),
    );
  }
}
