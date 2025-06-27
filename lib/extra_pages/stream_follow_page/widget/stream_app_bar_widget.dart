// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/stream_page/controller/stream_controller.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class StreamAppBarWidget extends StatelessWidget {
//   const StreamAppBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).viewPadding.top + 60,
//       color: AppColor.transparent,
//       padding: EdgeInsets.only(
//         left: 15,
//         right: 15,
//         top: MediaQuery.of(context).viewPadding.top,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: GetBuilder<StreamController>(
//               id: AppConstant.onChangeStreamTabs,
//               builder: (controller) => SizedBox(
//                 height: 28,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: controller.streamTabs.length,
//                     padding: EdgeInsets.zero,
//                     scrollDirection: Axis.horizontal,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () => controller.onChangeStreamTabs(index),
//                         child: Container(
//                           color: Colors.transparent,
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 controller.streamTabs[index],
//                                 style: AppFontStyle.styleW500(
//                                   controller.selectedTabIndex == index ? AppColor.white : AppColor.white.withValues(alpha:0.6),
//                                   16,
//                                 ),
//                               ),
//                               2.height,
//                               Visibility(
//                                 visible: controller.selectedTabIndex == index,
//                                 child: Container(
//                                   height: 2,
//                                   width: 15,
//                                   decoration: BoxDecoration(
//                                     color: AppColor.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           10.width,
//           Container(
//             height: 40,
//             width: 40,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               color: AppColor.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Image.asset(AppAssets.icSearch, width: 30),
//           ),
//           5.width,
//           Container(
//             height: 40,
//             width: 40,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//               color: AppColor.transparent,
//               shape: BoxShape.circle,
//             ),
//             child: Image.asset(AppAssets.icCup, width: 30),
//           ),
//         ],
//       ),
//     );
//   }
// }
