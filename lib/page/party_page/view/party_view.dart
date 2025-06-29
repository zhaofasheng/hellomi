import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/party_page/widget/party_app_bar_widget.dart';
import 'package:tingle/page/party_page/widget/party_country_tab_bar_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class PartyView extends GetView<PartyController> {
  const PartyView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    Utils.onChangeExtendBody(false);
    return Scaffold(
      floatingActionButton: GetBuilder<PartyController>(
        id: AppConstant.onChangeTab,
        builder: (controller) => Visibility(
          visible: controller.selectedTabIndex != 2,
          child: GestureDetector(
            onTap: () {
              final profileController = Get.find<ProfileController>();
              if (Utils.isDemoApp || profileController.fetchUserProfileModel?.user?.wealthLevel?.permissions?.liveStreaming == true) {
                Get.toNamed(AppRoutes.createAudioRoomPage);
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
                const PartyAppBarWidget(),
                5.height,
                GetBuilder<PartyController>(
                  id: AppConstant.onChangeTab,
                  builder: (controller) => Visibility(
                    visible: controller.selectedTabIndex != 2,
                    child: Column(
                      children: [
                        PartyCountryTabBarWidget(),
                        15.height,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: controller.pages.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GetBuilder<PartyController>(
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
      bottomNavigationBar: GetBuilder<PartyController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
