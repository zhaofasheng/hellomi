import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/level_page/controller/level_controller.dart';
import 'package:tingle/page/level_page/model/fetch_level_model.dart';
import 'package:tingle/page/level_page/shimmer/level_shimmer_widget.dart';
import 'package:tingle/page/level_page/widget/level_app_bar_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/setting_page/controller/setting_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class LevelView extends GetView<LevelController> {
  const LevelView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    Utils.onChangeStatusBar(brightness: Brightness.light, delay: 200);

    return GetBuilder<LevelController>(
      id: AppConstant.onGetLevel,
      builder: (controller) => Scaffold(
        backgroundColor: HexColor('#F5F5F5'),
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: Get.width,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Assets.images.mineBackImg.image(
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  (!controller.isLoading && controller.levelList.isEmpty) ? Expanded(child: NoDataFoundWidget()) : Offstage(),
                ],
              ),
            ),
            Container(
              color: AppColor.transparent,
              height: Get.height - MediaQuery.of(context).viewPadding.top,
              width: Get.width,
              child: controller.isLoading
                  ? LevelShimmerWidget()
                  : Column(
                      children: [
                        90.height,
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 115,
                                width: 115,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: HexColor('#00E4A6'), width: 2),
                                ),
                                child: Container(
                                  height: 115,
                                  width: 115,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    color: AppColor.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: PreviewProfileImageWidget(
                                    image: Database.fetchLoginUserProfile()?.user?.image ?? "",
                                    isBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                child: PreviewWealthLevelImage(
                                  height: 25,
                                  width: 50,
                                  image: profileController.fetchUserProfileModel?.user?.wealthLevel?.levelImage,
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.height,
                        ProgressBar(
                          current: Database.fetchLoginUserProfile()?.user?.topUpCoins ?? 0,
                          next: getLevelProgressInfo()?.nextLevel?.coinThreshold ?? 0,
                        ),
                        20.height,
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    // 主体内容区域
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        children: [
                                          // 表头
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: headerCell(EnumLocal.txtLevel.name.tr),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: headerCell(EnumLocal.txtCoinsRequiredToUpgrade.name.tr),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _tableDivider(),

                                          // 内容行（最后一行不画底部分割线）
                                          ...List.generate(controller.levelList.length, (index) {
                                            final element = controller.levelList[index];
                                            final isLast = index == controller.levelList.length - 1;

                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: levelCell(element.levelImage ?? ""),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: dataCell(element.coinThreshold ?? 0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (!isLast) _tableDivider(), // ✅ 只添加非最后一行的横线
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),

                                    // ✅ 竖向分割线（1/3位置 + 内边距10）
                                    Positioned(
                                      left: (Get.width - 30) * (1 / 3), // 30 = 左右 padding 各15
                                      top: 10,
                                      bottom: 10,
                                      child: Container(
                                        width: 1,
                                        color: HexColor('#EBEBEB'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            LevelAppBarWidget(),
          ],
        ),
      ),
    );
  }
}

Widget _tableDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 1,
      color: HexColor('#EBEBEB'),
    ),
  );
}

Widget headerCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      text,
      style: AppFontStyle.styleW600(AppColor.black, 13),
      textAlign: TextAlign.center,
    ),
  );
}

Widget levelCell(String value) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: PreviewWealthLevelImage(height: 20, width: 40, image: value),
  );
}

Widget dataCell(int value) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      value.toString(),
      textAlign: TextAlign.center,
      style: AppFontStyle.styleW600(AppColor.black, 11),
    ),
  );
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.current, required this.next});

  final int current;
  final int next;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              height: 8,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: current,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (next - current),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(text: EnumLocal.txtTopUpCoin.name.tr, style: AppFontStyle.styleW500(HexColor('#86868F'), 12), children: [
                    TextSpan(
                      text: current.toString(),
                      style: AppFontStyle.styleW700(AppColor.black, 12),
                    ),
                  ]),
                ),
                RichText(
                  text: TextSpan(text: EnumLocal.txtTheDistanceToUpgrade.name.tr, style: AppFontStyle.styleW500(HexColor('#86868F'), 12), children: [
                    TextSpan(
                      text: next.toString(),
                      style: AppFontStyle.styleW700(AppColor.black, 12),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LevelProgressInfo {
  final LevelData currentLevel;
  final LevelData? nextLevel;
  final int coinsNeededForNextLevel;
  final bool isMaxLevel;

  LevelProgressInfo({
    required this.currentLevel,
    this.nextLevel,
    required this.coinsNeededForNextLevel,
    required this.isMaxLevel,
  });
}

LevelProgressInfo? getLevelProgressInfo() {
  final controller = Get.find<LevelController>();
  final profileController = Get.find<ProfileController>();

  final currentLevelId = profileController.fetchUserProfileModel?.user?.wealthLevel?.id;

  if (currentLevelId == null || controller.levelList.isEmpty) return null;

  final currentIndex = controller.levelList.indexWhere((level) => level.id == currentLevelId);
  if (currentIndex == -1) return null;

  final currentLevel = controller.levelList[currentIndex];
  final isMaxLevel = currentIndex + 1 >= controller.levelList.length;

  return LevelProgressInfo(
    currentLevel: currentLevel,
    nextLevel: isMaxLevel ? null : controller.levelList[currentIndex + 1],
    coinsNeededForNextLevel: isMaxLevel ? 0 : (controller.levelList[currentIndex + 1].coinThreshold ?? 0) - (Database.fetchLoginUserProfile()?.user?.topUpCoins ?? 0),
    isMaxLevel: isMaxLevel,
  );
}
