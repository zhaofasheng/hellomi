import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/new_preview_frame.dart';
import 'package:tingle/custom/widget/custom_coinday_txt_widget.dart';
import 'package:tingle/page/store_page/controller/store_controller.dart';
import 'package:tingle/page/store_page/model/top_frame_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../custom/widget/custum_frame_image.dart';

class HotRecommendWidget extends StatelessWidget {
  const HotRecommendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = Get.width;

    final crossAxisCount = 3;
    final spacing = 10 * (crossAxisCount - 1); // total spacing between items
    final itemWidth = (screenWidth - spacing) / crossAxisCount;

    final itemHeight = itemWidth + 35; // 50 extra for text and icons

    final aspectRatio = itemWidth / itemHeight;
    return GetBuilder<StoreController>(builder: (logic) {
      return Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.ic_store_poster,
              fit: BoxFit.cover,
            ),
            10.height,
            logic.topFramesModel == null
                ? 0.height
                : Text(
                    EnumLocal.txtHotRecommendation.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 18),
                  ),
            14.height,
            logic.topFramesModel == null
                ? 0.height
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, // Max item height
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: aspectRatio, // Adjust width/height ratio
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(), // FIX: Changed from FixedExtentScrollPhysics
                    itemCount: logic.topFramesModel!.recommended!.length,
                    itemBuilder: (context, index) {
                      return LayoutBuilder(builder: (context, constraints) {
                        // Calculate the width and height of the item
                        final itemWidth = constraints.maxWidth;
                        final itemHeight = constraints.maxHeight;

                        // Calculate the aspect ratio
                        final aspectRatio = itemWidth / itemHeight;

                        log("itemWidth: $itemWidth");
                        log("itemHeight: $itemHeight");
                        log("aspectRatio: $aspectRatio");
                        return FrameRecommendationCard(
                          onTap: () {
                            if (logic.topFramesModel!.recommended![index].isPurchased == true) {
                              return;
                            }
                            PreviewSVGADaiLog.show(
                                userId: Database.loginUserId,
                                context: context,
                                frameData: logic.topFramesModel!.recommended?[index] ?? "",
                                itemType: logic.topFramesModel!.recommended?[index].itemType?.name);
                          },
                          width: itemWidth,
                          height: itemHeight,
                          index: index,
                          frameData: logic.topFramesModel!.recommended![index] ?? "",
                          backgroundImage: logic.topFramesModel!.recommended![index].image ?? "",
                          itemType: logic.topFramesModel!.recommended![index].itemType!.name ?? "",
                        );
                      });
                    },
                  )
          ],
        ),
      );
    });
  }
}

// A helper widget for each frame card

class FrameRecommendationCard extends StatelessWidget {
  final int index;
  final dynamic frameData;
  final VoidCallback? onTap;
  final double borderRadius;
  final String backgroundImage;
  final String itemType;
  final double height;
  final double width;

  FrameRecommendationCard({
    super.key,
    required this.index,
    required this.frameData,
    required this.itemType,
    required this.height,
    required this.width,
    this.onTap,
    this.borderRadius = 15,
    this.backgroundImage = AppAssets.ic_hot_recoomend_bg,
  });

  @override
  Widget build(BuildContext context) {
    log("itemType: ${frameData.name}");
    log("itemType: ${frameData.type}");
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(AppColor.transparent),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: itemType == ItemType.THEME.name
                  ? CachedNetworkImage(
                      imageUrl: Api.baseUrl + backgroundImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Center(child: Image.asset(AppAssets.icImagePlaceHolder)),
                      errorWidget: (context, url, error) => Center(child: Image.asset(AppAssets.icImagePlaceHolder)),
                    )
                  : Image.asset(
                      AppAssets.ic_hot_recoomend_bg,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),

            // Foreground content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  itemType == ItemType.THEME.name
                      ? SizedBox(
                          height: (height * 0.3),
                          width: (height * 0.3),
                        )
                      : SizedBox(
                          height: (height * 0.3),
                          width: (height * 0.3),
                          child: CustomSVGAFrameWidget(
                            type: frameData.type ?? 1,
                            itemType: itemType,
                            imagePath: frameData.image!,
                            framePath: frameData.svgaImage,
                            svgapadding: EdgeInsets.all(0),
                          ),
                        ),
                  2.height,
                  Container(
                    width: 120,
                    child: Text(
                      frameData.name ?? "",
                      textAlign: TextAlign.center,
                      style: AppFontStyle.styleW600(itemType == ItemType.THEME.name ? AppColor.white : AppColor.black, 14),
                    ),
                  ),
                  (height * 0.03).height,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.lightestYellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.icCoinStar,
                          width: 18,
                        ),
                        4.width,
                        CoinValidityText(
                          validity: frameData.validity.toString(),
                          coin: frameData.coin.toString(),
                          validityType: frameData.validityType,
                        ),
                      ],
                    ),
                  ),
                  (height * 0.03).height,
                  frameData.isPurchased
                      ? Container(
                          height: 40,
                          width: width,
                          // margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.deepLightGray,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              EnumLocal.txtPurchased.name.tr,
                              style: AppFontStyle.styleW500(AppColor.white, 16),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: width,
                          // margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            gradient: AppColor.lightDarkPinkGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              EnumLocal.txtPurchase.name.tr,
                              style: AppFontStyle.styleW500(AppColor.white, 16),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
