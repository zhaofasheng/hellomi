import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/page/feed_page/widget/feed_app_bar_widget.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: GetBuilder<FeedController>(
              id: AppConstant.onChangeTab,
              builder: (controller) => PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return controller.pages[controller.selectedTab];
                },
              ),
            ),
          ),
          const FeedAppBarWidget(),
        ],
      ),
    );
  }
}
