// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/feed_page/widget/post_item_widget.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FeedFollowTopicsWidget extends StatelessWidget {
//   const FeedFollowTopicsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           5.height,
//           SizedBox(
//             height: 35,
//             width: Get.width,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 4,
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.zero,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: AppColor.white.withValues(alpha: 0.2),
//                       border: Border.all(color: AppColor.white.withValues(alpha: 0.7)),
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: Row(
//                       children: [
//                         Image.asset(AppAssets.icRedYellowColorFire, width: 16),
//                         8.width,
//                         Text(
//                           "#The most beautiful travel photos",
//                           style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 12),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           3.height,
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: 4,
//             padding: const EdgeInsets.only(top: 10),
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return const PostItemWidget();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
