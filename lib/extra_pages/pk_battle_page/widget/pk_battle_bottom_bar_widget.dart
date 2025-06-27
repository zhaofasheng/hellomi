// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/widget/gift_bottom_sheet_widget.dart';
// import 'package:tingle/common/widget/stream_text_field_widget.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PkBattleBottomBarWidget extends StatelessWidget {
//   const PkBattleBottomBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: Container(
//         height: 50,
//         width: Get.width,
//         margin: EdgeInsets.all(10),
//         color: AppColor.transparent,
//         child: Row(
//           children: [
//             false
//                 ? Expanded(
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                         height: 45,
//                         width: 120,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: AppColor.bluePurple,
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Text(
//                           "🌹 Hi there!",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: AppFontStyle.styleW600(AppColor.white, 14),
//                         ),
//                       ),
//                     ),
//                   )
//                 : StreamTextFieldWidget(),
//             10.width,
//             Container(
//               height: 45,
//               width: 45,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: AppColor.white.withValues(alpha: 0.2),
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(AppAssets.icWireMic, width: 22),
//             ),
//             10.width,
//             Container(
//               height: 45,
//               width: 45,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: AppColor.white.withValues(alpha: 0.2),
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(AppAssets.icThreeLineMenu, width: 26),
//             ),
//             10.width,
//             GestureDetector(
//               onTap: () => GiftBottomSheetWidget.show(context: context),
//               child: Container(
//                 height: 45,
//                 width: 45,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: AppColor.white.withValues(alpha: 0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.asset(AppAssets.icLightPinkGift, width: 26),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
