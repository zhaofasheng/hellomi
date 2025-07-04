import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserProfileWonMomTabWidget extends StatelessWidget {
  // final List<VideoData> userVideos;
  // final bool isLoadingVideo;
  // final Function(int) onClickVideo;

  const OtherUserProfileWonMomTabWidget({
    super.key,
    // required this.userVideos,
    // required this.isLoadingVideo,
    // required this.onClickVideo,
  });

  @override
  Widget build(BuildContext context) {
    if (OtherUserProfileBottomSheet.isLoadingVideo) {
      return const LoadingWidget();
    }

    if (OtherUserProfileBottomSheet.userVideos.isEmpty) {
      return const NoDataFoundWidget();
    }

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: OtherUserProfileBottomSheet.userVideos.length,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final indexData = OtherUserProfileBottomSheet.userVideos[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.previewShortsVideoPage,
                  arguments: {ApiParams.index: index, ApiParams.videos: OtherUserProfileBottomSheet.userVideos},
                );
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.colorBorder.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: LayoutBuilder(builder: (context, box) {
                  return Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomRight,
                    children: [
                      PreviewPostImageWidget(
                        size: 50,
                        image: indexData.videoImage ?? "",
                        isBanned: indexData.isProfilePicBanned,
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
                    ],
                  );
                }),
              ),
            );
          },
        ),
        120.height,
      ],
    );
  }
}
