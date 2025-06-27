import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class ConnectionAppBarWidget {
  static PreferredSizeWidget onShow(BuildContext context, {String? title, int? count}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 82),
      child: GetBuilder<ConnectionController>(
          id: AppConstant.onTabBarTap,
          builder: (controller) {
            return Container(
              width: Get.width,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          height: 45,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                          child: Image.asset(AppAssets.icArrowLeft, width: 10),
                        ),
                      ),
                      Text(
                        controller.selectedCount.value == 0 ? controller.mainTitle.value : "${controller.mainTitle.value}(${controller.selectedCount})",
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.onSearchData();
                          Get.toNamed(AppRoutes.searchConnectionPage);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppAssets.icSearch,
                            width: 25,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GetBuilder<ConnectionController>(
                      id: AppConstant.onTabBarTap,
                      builder: (controller) => Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: AppColor.colorBorder.withValues(alpha: 0.4),
                            ),
                            child: TabBar(
                              padding: EdgeInsets.zero,
                              isScrollable: true,
                              controller: controller.tabController,
                              indicator: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              unselectedLabelColor: AppColor.secondary,
                              labelColor: AppColor.white,
                              dividerColor: Colors.transparent,
                              labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              indicatorPadding: EdgeInsets.symmetric(vertical: 7),
                              labelStyle: AppFontStyle.styleW600(AppColor.white, 13),
                              unselectedLabelStyle: AppFontStyle.styleW500(AppColor.white, 13),
                              onTap: (value) {
                                // controller.onTabChange(value);
                              },
                              tabAlignment: TabAlignment.start,
                              tabs: [
                                Tab(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      EnumLocal.txtFriends.name.tr,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      EnumLocal.txtFollow.name.tr,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      EnumLocal.txtFollowers.name.tr,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      EnumLocal.txtVisitors.name.tr,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                ],
              ),
            );
          }),
    );
  }
}
