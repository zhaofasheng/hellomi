// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/feed_follow_page/controller/feed_follow_controller.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
//
// class FeedFollowTabBarWidget extends StatelessWidget {
//   const FeedFollowTabBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FeedFollowController>(
//       id: AppConstant.onChangeFeedType,
//       builder: (controller) => Container(
//         color: AppColor.transparent,
//         height: 30,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: ListView.builder(
//             shrinkWrap: true,
//             // itemCount: controller.feedTypes.length,
//             itemCount: 5,
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.horizontal,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 child: Container(
//                   height: 30,
//                   margin: const EdgeInsets.only(right: 15),
//                   alignment: Alignment.center,
//                   color: AppColor.transparent,
//                   // child: Text(
//                   //   controller.feedTypes[index],
//                   //   style: controller.selectedFeedType == index ? AppFontStyle.styleW700(AppColor.primary, 18) : AppFontStyle.styleW600(AppColor.white, 16),
//                   // ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
