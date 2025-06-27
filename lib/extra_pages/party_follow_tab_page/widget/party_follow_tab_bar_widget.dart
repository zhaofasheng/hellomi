// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:tingle/page/message_page/controller/message_controller.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PartyFollowTabBarWidget extends StatelessWidget {
//   const PartyFollowTabBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MessageController>(
//       id: AppConstant.onChangeMessageType,
//       builder: (controller) => Container(
//         height: 35,
//         width: Get.width,
//         color: AppColor.transparent,
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Row(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: controller.messageTypes.length,
//                   padding: EdgeInsets.zero,
//                   scrollDirection: Axis.horizontal,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return MessageTabItemWidget(
//                       title: controller.messageTypes[index],
//                       count: null,
//                       isSelected: controller.selectedMessageType == index,
//                       callback: () => controller.onChangeMessageType(index),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Container(
//                 height: 40,
//                 width: 40,
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColor.transparent,
//                 ),
//                 child: Image.asset(AppAssets.icMenu, width: 22)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MessageTabItemWidget extends StatelessWidget {
//   const MessageTabItemWidget({super.key, required this.title, this.count, required this.isSelected, required this.callback});
//
//   final String title;
//   final int? count;
//   final bool isSelected;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: callback,
//       child: Container(
//         margin: const EdgeInsets.only(right: 10),
//         padding: const EdgeInsets.only(left: 18, right: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColor.primary : AppColor.white.withValues(alpha: 0.15),
//           borderRadius: BorderRadius.circular(100),
//           border: isSelected ? Border.all(color: AppColor.white) : null,
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: isSelected ? AppFontStyle.styleW600(AppColor.white, 14) : AppFontStyle.styleW500(AppColor.white, 14),
//             ),
//             count != null
//                 ? Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(6),
//                     margin: const EdgeInsets.only(left: 8, right: 3),
//                     decoration: const BoxDecoration(color: AppColor.pink, shape: BoxShape.circle),
//                     child: Text(
//                       count.toString(),
//                       style: AppFontStyle.styleW600(AppColor.white, 14),
//                     ),
//                   )
//                 : 8.width,
//           ],
//         ),
//       ),
//     );
//   }
// }
