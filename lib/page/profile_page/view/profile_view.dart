import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/profile_page/shimmer/profile_shimmer_widget.dart';
import 'package:tingle/page/profile_page/widget/benefit_box_widget.dart';
import 'package:tingle/page/profile_page/widget/coin_and_point_details_widget.dart';
import 'package:tingle/page/profile_page/widget/connection_details_widget.dart';
import 'package:tingle/page/profile_page/widget/general_setting_widget.dart';
import 'package:tingle/page/profile_page/widget/profile_app_bar_widget.dart';
import 'package:tingle/page/profile_page/widget/profile_details_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == AppRoutes.bottomBarPage && controller.bottomBarController.selectedTabIndex == 4) {
      Utils.onChangeStatusBar(brightness: Brightness.dark);
      Utils.onChangeExtendBody(false);
    }
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(isMine: true,),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [

                GetBuilder<ProfileController>(
                  id: AppConstant.onGetProfile,
                  builder: (controller) => (controller.isLoading && !controller.hasInit)
                      ? ProfileShimmerWidget()
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async => await controller.init(),
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: Get.width / 375 * 350-20,// - MediaQuery.of(context).padding.top - kToolbarHeight+8,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          child: Image.asset(
                                            Assets.images.mineBackImg.path,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: Get.width / 375 * 350-20,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            (MediaQuery.of(context).viewPadding.top + 50).height,
                                            const ProfileDetailsWidget(),
                                          ],
                                        ),
                                        Positioned(left: 0,right: 0,bottom: 0,child: const ConnectionDetailsWidget(),),
                                      ],
                                    ),
                                  ),
                                  8.height,
                                  const CoinAndPointDetailsWidget(),
                                  8.height,
                                  const BenefitBoxWidget(),
                                  8.height,
                                  const GeneralSettingWidget(),
                                  15.height,
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const ProfileAppBarWidget(),
        ],
      ),
    );
  }
}
