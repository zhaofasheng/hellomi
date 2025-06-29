import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class StreamAppBarWidget extends StatelessWidget {
  const StreamAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List tabTitles = [EnumLocal.txtExplore.name.tr, EnumLocal.txtNew.name.tr, EnumLocal.txtPk.name.tr, EnumLocal.txtFollow.name.tr];
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 55,
      color: AppColor.transparent,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 10, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GetBuilder<StreamController>(
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
                                  alignment: Alignment.center,
                                  child: Text(
                                    tabTitles[index],
                                    style: controller.selectedTabIndex == index ? AppFontStyle.styleW700(HexColor('#242630'), 18) : AppFontStyle.styleW600(HexColor('#242630'), 15),
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
                                    color: HexColor('#242630'),
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
              child: Assets.images.mainSearchImg.image(width: 30,height: 30),
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
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColor.transparent,
                shape: BoxShape.circle,
              ),
              child: Assets.images.mainRecordImg.image(width: 30),
            ),
          ),
        ],
      ),
    );
  }
}
