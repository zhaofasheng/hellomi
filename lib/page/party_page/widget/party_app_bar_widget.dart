import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/party_page/widget/party_country_tab_bar_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PartyAppBarWidget extends StatelessWidget {
  const PartyAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List tabTitles = [
      EnumLocal.txtParty.name.tr,
      EnumLocal.txtFollow.name.tr,
      EnumLocal.txtGames.name.tr,
    ];
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 55,
      color: AppColor.transparent,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GetBuilder<PartyController>(
              id: AppConstant.onChangeTab,
              builder: (controller) => SizedBox(
                height: 32,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tabTitles.length,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => controller.onChangeTab(index),
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 24,
                                child: Align(
                                  child: Text(
                                    tabTitles[index],
                                    style: controller.selectedTabIndex == index ? AppFontStyle.styleW700(AppColor.white, 18) : AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.6), 15),
                                  ),
                                ),
                              ),
                              2.height,
                              Visibility(
                                visible: controller.selectedTabIndex == index,
                                child: Container(
                                  height: 3,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          10.width,
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.searchPage)?.then(
              (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
            ),
            child: Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColor.transparent,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppAssets.icSearch, width: 30),
            ),
          ),
          5.width,
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.rankingPage)?.then(
              (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
            ),
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                color: AppColor.transparent,
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppAssets.icCup, width: 30),
            ),
          ),
        ],
      ),
    );
  }
}
