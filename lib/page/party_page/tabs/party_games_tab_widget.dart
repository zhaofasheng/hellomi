import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/api/fetch_user_profile_images_api.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/play_game_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_random_light_color.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PartyGamesTabWidget extends GetView<PartyController> {
  const PartyGamesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Utils.games.isEmpty
          ? NoDataFoundWidget()
          : SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Utils.games.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final indexData = Utils.games[index];
                  return indexData.isActive == true
                      ? GameItemWidget(
                          title: indexData.name ?? "",
                          image: indexData.image ?? "",
                          callback: () => PlayGameBottomSheetWidget.onShow(
                            name: indexData.name ?? "",
                            height: ((indexData.link ?? "").contains("teenpatti"))
                                ? 370
                                : ((indexData.link ?? "").contains("ferrywheelgame"))
                                    ? 550
                                    : 580,
                            link: (indexData.link?.trim().isNotEmpty ?? false) ? ("${indexData.link}?id=${Database.loginUserId}") : "",
                          ),
                        )
                      : Offstage();
                },
              ),
            ),
    );
  }
}

class GameItemWidget extends StatelessWidget {
  const GameItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.callback,
  });

  final String title;
  final String image;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    FetchUserProfileImagesApi.images.shuffle();
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 90,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: CustomRandomLightColor.onGet(),
          border: Border.all(color: AppColor.white),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: Container(
                height: 90,
                width: 90,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: PreviewPostImageWidget(image: image),
              ),
            ),
            5.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.styleW700(AppColor.black, 14),
                    ),
                  ),
                  5.height,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.icGame_1,
                              width: 16,
                            ),
                            5.width,
                            Text(
                              Random().nextInt(20000).toString(),
                              style: AppFontStyle.styleW800(AppColor.primary, 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Row(
                    children: [
                      Text(
                        EnumLocal.txtTopPlayer.name.tr,
                        style: AppFontStyle.styleW600(AppColor.black, 10),
                      ),
                      Expanded(
                        child: Container(
                          height: 26,
                          color: AppColor.transparent,
                          child: Stack(
                            children: [
                              for (int i = 0; i < 4; i++)
                                Positioned(
                                  left: i == 0 ? 0 : i * 20,
                                  child: Container(
                                    height: 26,
                                    width: 26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.transparent,
                                      border: Border.all(color: AppColor.white),
                                    ),
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.white.withValues(alpha: 0.1),
                                      ),
                                      child: PreviewProfileImageWidget(
                                        image: (FetchUserProfileImagesApi.images.length > i) ? FetchUserProfileImagesApi.images[i] : null,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            5.width,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColor.coinPinkGradient,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColor.white),
              ),
              child: Text(
                EnumLocal.txtPlayNow.name.tr,
                style: AppFontStyle.styleW700(AppColor.white, 10),
              ),
            ),
            15.width,
          ],
        ),
      ),
    );
  }
}
