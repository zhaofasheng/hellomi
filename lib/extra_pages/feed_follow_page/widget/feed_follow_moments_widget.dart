// import 'package:flutter/material.dart';
// import 'package:tingle/common/widget/no_data_found_widget.dart';
// import 'package:tingle/page/feed_page/widget/post_item_widget.dart';
//
// class FeedFollowMomentsWidget extends StatelessWidget {
//   const FeedFollowMomentsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return true
//         ? NoDataFoundWidget()
//         : SingleChildScrollView(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: 4,
//               padding: const EdgeInsets.only(top: 10),
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return const PostItemWidget();
//               },
//             ),
//           );
//   }
// }

// class FeedMomentItemWidget extends StatefulWidget {
//   const FeedMomentItemWidget({super.key});
//
//   @override
//   State<FeedMomentItemWidget> createState() => _FeedMomentItemWidgetState();
// }
//
// class _FeedMomentItemWidgetState extends State<FeedMomentItemWidget> {
//   RxBool isLike = false.obs;
//
//   void onToggleLike() {
//     isLike.value = !isLike.value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500,
//       width: Get.width,
//       margin: const EdgeInsets.only(bottom: 15),
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(32),
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 80,
//             width: Get.width,
//             padding: const EdgeInsets.all(15),
//             child: Row(
//               children: [
//                 Container(
//                   height: 47,
//                   width: 47,
//                   padding: const EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: AppColor.secondary),
//                   ),
//                   child: Container(
//                     clipBehavior: Clip.antiAlias,
//                     decoration: const BoxDecoration(shape: BoxShape.circle),
//                     child: const CustomPreviewProfileImageWidget(),
//                   ),
//                 ),
//                 12.width,
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           Flexible(
//                             fit: FlexFit.loose,
//                             child: Text(
//                               "Anaya Khan",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: AppFontStyle.styleW700(AppColor.black, 16),
//                             ),
//                           ),
//                           Visibility(
//                             visible: true,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 5),
//                               child: Text(
//                                 "🇮🇳",
//                                 style: AppFontStyle.styleW700(AppColor.white, 16),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       3.height,
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                             decoration: BoxDecoration(
//                               color: AppColor.purple,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Row(
//                               children: [
//                                 Image.asset(AppAssets.icFemale, width: 10),
//                                 3.width,
//                                 Text(
//                                   "26",
//                                   style: AppFontStyle.styleW600(AppColor.white, 10),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 40,
//                   width: 40,
//                   alignment: Alignment.center,
//                   decoration: const BoxDecoration(shape: BoxShape.circle),
//                   child: Image.asset(
//                     AppAssets.icVerticalVert,
//                     width: 4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 335,
//             width: Get.width,
//             child: const CustomPreviewNetworkImageWidget(),
//           ),
//           SizedBox(
//             height: 85,
//             width: Get.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     5.width,
//                     Obx(
//                       () => IconButtonWidget(
//                         icon: isLike.value ? AppAssets.icLikeFill : AppAssets.icLikeBorder,
//                         count: 98700000,
//                         iconSize: 25,
//                         callback: onToggleLike,
//                       ),
//                     ),
//                     IconButtonWidget(
//                       icon: AppAssets.icCommentBorder,
//                       count: 2565,
//                       iconSize: 25,
//                       callback: () {},
//                     ),
//                     IconButtonWidget(
//                       icon: AppAssets.icShareBorder,
//                       count: 256,
//                       iconSize: 22,
//                       callback: () {},
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Text(
//                     "10 min ago",
//                     style: AppFontStyle.styleW500(AppColor.secondary, 13),
//                   ),
//                 ),
//                 15.height,
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class IconButtonWidget extends StatelessWidget {
//   const IconButtonWidget({
//     super.key,
//     required this.icon,
//     required this.count,
//     required this.iconSize,
//     required this.callback,
//   });
//
//   final String icon;
//   final int count;
//   final double iconSize;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: callback,
//       child: Container(
//         color: AppColor.transparent,
//         height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(icon, width: iconSize),
//             8.width,
//             Text(
//               CustomFormatNumber.convert(count),
//               style: AppFontStyle.styleW600(AppColor.secondary, 15),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
