import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserProfileMomentsTabWidget extends StatelessWidget {
  const OtherUserProfileMomentsTabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OtherUserProfileBottomSheet.isLoadingPost
            ? LoadingWidget()
            : OtherUserProfileBottomSheet.userPosts.isEmpty
                ? NoDataFoundWidget()
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: OtherUserProfileBottomSheet.userPosts.length,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final indexData = OtherUserProfileBottomSheet.userPosts[index];
                      return GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed(AppRoutes.profileMomentPage, arguments: {
                            AppConstant.postId: indexData.id,
                            AppConstant.onFetchPost: OtherUserProfileBottomSheet.userPosts,
                          });
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.colorBorder.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: LayoutBuilder(
                            builder: (context, box) {
                              return Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.bottomRight,
                                children: [
                                  PreviewPostImageWidget(
                                    size: 50,
                                    image: indexData.postImage?[0].url ?? "",
                                    isBanned: indexData.postImage?[0].isBanned ?? false,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: -3,
                                    left: 0,
                                    child: Container(
                                      height: 35,
                                      width: box.maxWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(14),
                                          bottomRight: Radius.circular(14),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.6)],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              AppAssets.icLikeFill,
                                              width: 12,
                                              color: AppColor.white,
                                            ),
                                            5.width,
                                            Text(
                                              " ${CustomFormatNumber.onConvert(indexData.totalLikes ?? 0)}",
                                              style: AppFontStyle.styleW600(AppColor.white, 10),
                                            ),
                                            8.width,
                                            Image.asset(AppAssets.icCommentFill, width: 12),
                                            5.width,
                                            Text(
                                              " ${CustomFormatNumber.onConvert(indexData.totalComments ?? 0)}",
                                              style: AppFontStyle.styleW600(AppColor.white, 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !(indexData.postImage?.length == 1),
                                    child: Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Image.asset(
                                        AppAssets.icMultipleImage,
                                        color: AppColor.white,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
        120.height,
      ],
    );
    //   Obx(
    //   () =>
    // );
  }
}
