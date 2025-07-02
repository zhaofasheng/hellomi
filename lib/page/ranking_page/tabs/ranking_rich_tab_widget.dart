import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/ranking_page/widget/ranking_user_list_tile_widget.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/page/ranking_page/shimmer/ranking_user_list_shimmer_widget.dart';
import 'package:tingle/page/ranking_page/widget/rich_and_gift_tab_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

import '../../../common/widget/preview_network_image_widget.dart';
import '../model/fetch_ranking_rich_user_model.dart';

class RankingRichTabWidget extends StatelessWidget {
  const RankingRichTabWidget({super.key});

  Widget buildRichHeader(List<Daily> users) {
    final topUsers = List.generate(3, (i) => i < users.length ? users[i] : null);
    final List<int> displayOrder = [1, 0, 2];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: displayOrder.map((i) {
          final user = topUsers[i];
          final isCenter = i == 0;

          final double avatarSize = isCenter ? 60 : 50;

          // 标识图放顶部，适当放大覆盖头像
          final Image badge = switch (i) {
            0 => Assets.images.numberOne.image(width: avatarSize + 22, height: avatarSize + 22),
            1 => Assets.images.numberTwo.image(width: avatarSize + 22, height: avatarSize + 22),
            2 => Assets.images.numberThree.image(width: avatarSize + 22, height: avatarSize + 22),
            _ => Image.asset(''),
          };

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: isCenter ? 0 : 36),
                SizedBox(
                  height: avatarSize,
                  width: avatarSize,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // 头像
                      Container(
                        height: avatarSize,
                        width: avatarSize,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: PreviewProfileImageWithFrameWidget(
                          image: user?.image ?? "",
                          frame: user?.avtarFrame ?? "",
                          type: user?.avtarFrameType ?? 0,
                          fit: BoxFit.cover,
                          margin: const EdgeInsets.all(5),
                        ),
                      ),

                      // 标识图层盖在头像上方（稍大）
                      Positioned(
                        top: -10,
                        child: badge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          20.height,
          RichTabBarWidget(),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.white,
              ),
              child: GetBuilder<RankingController>(
                id: AppConstant.onChangeRichTabBar,
                builder: (controller) => controller.isLoadingRankingRichUser
                    ? RankingUserListShimmerWidget()
                    : controller.rankingRichUser[controller.selectedRichTabIndex].isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            controller: controller.richScrollController,
                            child: Column(
                              children: [
                                if (controller.rankingRichUser[controller.selectedRichTabIndex].isNotEmpty)
                                  buildRichHeader(controller.rankingRichUser[controller.selectedRichTabIndex]),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.rankingRichUser[controller.selectedRichTabIndex].length,
                                  padding: EdgeInsets.only(top: 15),
                                  itemBuilder: (context, index) {
                                    final indexData = controller.rankingRichUser[controller.selectedRichTabIndex][index];
                                    return RankingUserListTileWidget(
                                      index: index,
                                      title: indexData.name ?? "",
                                      coin: indexData.coin ?? 0,
                                      image: indexData.image ?? "",
                                      gender: indexData.gender ?? "",
                                      age: indexData.age ?? 0,
                                      wealthLevelImage: indexData.wealthLevelImage ?? "",
                                      isVerified: indexData.isVerified ?? false,
                                      isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                                      frame: indexData.avtarFrame ?? "",
                                      frameType: indexData.avtarFrameType ?? 0,
                                      callback: () {},
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
              ),
            ),
          ),
          GetBuilder<RankingController>(
            id: AppConstant.onPagination,
            builder: (controller) => Visibility(
              visible: controller.isPaginationRankingRichUser,
              child: LinearProgressIndicator(color: AppColor.primary),
            ),
          )
        ],
      ),
    );
  }
}


