// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/audio_room_page/widget/audio_room_gift_bottom_sheet_widget.dart';
// import 'package:tingle/common/widget/no_data_found_widget.dart';
// import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
// import 'package:tingle/page/feed_follow_page/controller/feed_follow_controller.dart';
// import 'package:tingle/page/feed_page/shimmer/feed_shimmer_widget.dart';
// import 'package:tingle/page/feed_page/widget/feed_item_widget.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FeedFollowView extends GetView<FeedFollowController> {
//   const FeedFollowView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     controller.init();
//     return Scaffold(
//       body: Stack(
//         children: [
//           const CustomDarkBackgroundWidget(),
//           SizedBox(
//             height: Get.height,
//             width: Get.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).viewPadding.top + 50),
//                 10.height,
//                 Expanded(
//                   child: GetBuilder<FeedFollowController>(
//                     id: AppConstant.onGetFollowPost,
//                     builder: (controller) => LayoutBuilder(
//                       builder: (context, box) {
//                         return RefreshIndicator(
//                           color: AppColor.primary,
//                           onRefresh: () => controller.onRefreshFollowPost(),
//                           child: controller.isLoading
//                               ? FeedShimmerWidget()
//                               : controller.followPost.isEmpty
//                                   ? SingleChildScrollView(
//                                       child: SizedBox(
//                                         height: box.maxHeight + 1, // USE TO ACTIVE REFRESH INDICATOR
//                                         child: NoDataFoundWidget(),
//                                       ),
//                                     )
//                                   : LayoutBuilder(builder: (context, box) {
//                                       return RefreshIndicator(
//                                         color: AppColor.primary,
//                                         onRefresh: () => controller.onRefreshFollowPost(),
//                                         child: SingleChildScrollView(
//                                           child: SizedBox(
//                                             height: box.maxHeight + 1,
//                                             child: RefreshIndicator(
//                                               color: AppColor.primary,
//                                               onRefresh: () => controller.onRefreshFollowPost(),
//                                               child: SingleChildScrollView(
//                                                 controller: controller.scrollController,
//                                                 child: Column(
//                                                   children: [
//                                                     ListView.builder(
//                                                       shrinkWrap: true,
//                                                       itemCount: controller.followPost.length,
//                                                       padding: const EdgeInsets.only(left: 15, right: 15),
//                                                       physics: const NeverScrollableScrollPhysics(),
//                                                       itemBuilder: (context, index) {
//                                                         final indexData = controller.followPost[index];
//                                                         return FeedItemWidget(post: indexData);
//                                                       },
//                                                     ),
//                                                     controller.followPost.length == 1 ? (Get.width / 2).height : Offstage(),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: GetBuilder<FeedFollowController>(
//         id: AppConstant.onPagination,
//         builder: (controller) => Visibility(
//           visible: controller.isLoadingPagination,
//           child: LinearProgressIndicator(color: AppColor.primary),
//         ),
//       ),
//     );
//   }
// }

// TODO >>> UPLOAD ANIMATION BUTTON
// UploadButtonWidget(),
// Positioned(
//   bottom: 20,
//   right: 20,
//   child: GestureDetector(
//     onTap: feedController.onToggleUploadButton,
//     child: Container(
//       height: 55,
//       width: 55,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         gradient: AppColor.bluePurpleGradient,
//         shape: BoxShape.circle,
//       ),
//       child: GetBuilder<FeedController>(
//         id: AppConstant.onToggleUploadButton,
//         builder: (controller) => controller.isShowUploadButton ? Image.asset(AppAssets.icClose, width: 26, color: AppColor.white) : Image.asset(AppAssets.icCreate, width: 26),
//       ),
//     ),
//   ),
// ),
