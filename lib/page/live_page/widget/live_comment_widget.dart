import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_comment_widget.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LiveCommentWidget extends StatelessWidget {
  const LiveCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveController>(
      id: AppConstant.onChangeComment,
      builder: (controller) => Container(
        height: 250,
        width: Get.width / 1.8,
        color: AppColor.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ScrollFadeEffectWidget(
            axis: Axis.vertical,
            child: SingleChildScrollView(
              controller: controller.liveModel?.scrollController,
              child: ListView.builder(
                itemCount: controller.liveModel?.liveComments.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final indexData = controller.liveModel?.liveComments[index];
                  return indexData?.type == 1
                      ? LiveCommentTextWidget(
                          name: indexData?.name ?? "",
                          comment: indexData?.commentText ?? "",
                          image: indexData?.image ?? "",
                          isBanned: indexData?.isBanned ?? false,
                          userId: indexData?.userId ?? "",
                        )
                      : indexData?.type == 2
                          ? LiveRoomNameCommentWidget(roomName: controller.liveModel?.host1Name ?? "")
                          : indexData?.type == 3
                              ? LiveAnnouncementCommentWidget(announcement: "")
                              : LiveEmojiCommentWidget(
                                  name: indexData?.name ?? "",
                                  emoji: indexData?.emoji ?? "",
                                );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class LiveCommentWidget extends StatelessWidget {
//   const LiveCommentWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 0,
//       bottom: 70,
//       child: GetBuilder<LiveController>(
//         id: AppConstant.onChangeComment,
//         builder: (controller) => Container(
//           height: 250,
//           width: Get.width / 1.8,
//           color: AppColor.transparent,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: SingleChildScrollView(
//               controller: controller.liveModel?.scrollController,
//               child: ListView.builder(
//                 itemCount: controller.liveModel?.liveComments.length ?? 0,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   final indexData = controller.liveModel?.liveComments[index];
//                   return CommentItemUi(
//                     name: indexData?.name ?? "",
//                     image: indexData?.image ?? "",
//                     commentText: indexData?.commentText ?? "",
//                     isBanned: indexData?.isBanned ?? false,
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CommentItemUi extends StatelessWidget {
//   const CommentItemUi({
//     super.key,
//     required this.name,
//     required this.image,
//     required this.commentText,
//     required this.isBanned,
//   });
//
//   final String name;
//   final String image;
//   final String commentText;
//   final bool isBanned;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width / 2,
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       margin: EdgeInsets.symmetric(vertical: 10),
//       decoration: const BoxDecoration(color: AppColor.transparent),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 38,
//                 width: 38,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.colorBorder.withValues(alpha: 0.8)),
//                 child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
//               ),
//             ],
//           ),
//           10.width,
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   maxLines: 1,
//                   style: AppFontStyle.styleW600(AppColor.white, 11.5),
//                 ),
//                 2.height,
//                 Text(
//                   commentText,
//                   style: AppFontStyle.styleW600(AppColor.white, 13.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
