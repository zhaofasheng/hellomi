// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/extra_pages/old_go_live_page/controller/go_live_controller.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class GoLiveTabBarWidget extends StatelessWidget {
//   const GoLiveTabBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 30,
//       child: GetBuilder<GoLiveController>(
//         id: AppConstant.onChangeLiveType,
//         builder: (controller) => Container(
//           height: 50,
//           width: Get.width,
//           color: AppColor.transparent,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () => controller.onChangeLiveType(0),
//                 child: Container(
//                   height: 50,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: controller.selectedLiveType == 0 ? AppColor.primary : AppColor.transparent,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Live",
//                     style: AppFontStyle.styleW700(AppColor.white, 16),
//                   ),
//                 ),
//               ),
//               10.width,
//               GestureDetector(
//                 onTap: () => controller.onChangeLiveType(1),
//                 child: Container(
//                   height: 50,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: controller.selectedLiveType == 1 ? AppColor.primary : AppColor.transparent,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Audio Room",
//                     style: AppFontStyle.styleW700(AppColor.white, 16),
//                   ),
//                 ),
//               ),
//               10.width,
//               GestureDetector(
//                 onTap: () => controller.onChangeLiveType(2),
//                 child: Container(
//                   height: 50,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: controller.selectedLiveType == 2 ? AppColor.primary : AppColor.transparent,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Pk Battle",
//                     style: AppFontStyle.styleW700(AppColor.white, 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
