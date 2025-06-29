import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/widget/stream_app_bar_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_country_tab_bar_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class StreamView extends GetView<StreamController> {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    Utils.onChangeExtendBody(false);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          final profileController = Get.find<ProfileController>();
          if (Utils.isDemoApp || profileController.fetchUserProfileModel?.user?.wealthLevel?.permissions?.liveStreaming == true) {
            Get.toNamed(AppRoutes.goLivePage)?.then((value) => Utils.onChangeStatusBar(brightness: Brightness.light));
          } else {
            Utils.showToast(text: EnumLocal.txtTopUpYourBalanceToReachTheNext.name.tr);
          }
        },
        child: SizedBox(
          height: 45,
          width: 45,
          child: Assets.images.mainUpLiveImg.image(width: 45,height: 45),
        ),
      ),
      body: Stack(
        children: [
          const CustomDarkBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const StreamAppBarWidget(),
                5.height,
                StreamCountryTabBarWidget(),
                15.height,
                Expanded(
                  child: PageView.builder(
                    itemCount: controller.pages.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GetBuilder<StreamController>(
                        id: AppConstant.onChangeTab,
                        builder: (controller) => controller.pages[controller.selectedTabIndex],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<StreamController>(
        id: AppConstant.onPagination,
        builder: (controller) => Container(
          color: AppColor.white,
          height: 3,
          child: Visibility(
            visible: controller.isLoadingPagination,
            child: LinearProgressIndicator(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
