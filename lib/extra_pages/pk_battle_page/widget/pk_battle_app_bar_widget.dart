// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/page/pk_battle_page/controller/pk_battle_controller.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PkBattleAppBarWidget extends GetView<PkBattleController> {
//   const PkBattleAppBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: Get.width,
//       color: AppColor.transparent,
//       child: Column(
//         children: [
//           Container(
//             height: 50,
//             width: Get.width,
//             color: AppColor.transparent,
//             child: Row(
//               children: [
//                 10.width,
//                 Container(
//                   height: 50,
//                   width: 170,
//                   padding: EdgeInsets.only(left: 3, right: 3, top: 4, bottom: 4),
//                   decoration: BoxDecoration(
//                     color: AppColor.black.withValues(alpha: 0.3),
//                     borderRadius: BorderRadius.circular(100),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 45,
//                         width: 45,
//                         padding: EdgeInsets.all(1),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppColor.white),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Container(
//                           height: 45,
//                           width: 45,
//                           alignment: Alignment.center,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                             gradient: AppColor.lightYellowOrangeGradient,
//                             shape: BoxShape.circle,
//                           ),
//                           child: PreviewProfileImageWidget(fit: BoxFit.cover),
//                         ),
//                       ),
//                       5.width,
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Text(
//                               "Andrew Fi..",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: AppFontStyle.styleW700(AppColor.white, 12),
//                             ),
//                             2.height,
//                             Row(
//                               children: [
//                                 Image.asset(AppAssets.icUser, color: AppColor.white, width: 10),
//                                 5.width,
//                                 Flexible(
//                                   fit: FlexFit.loose,
//                                   child: Text(
//                                     "1320",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: AppFontStyle.styleW700(AppColor.white, 12),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       5.width,
//                       Container(
//                         height: 45,
//                         width: 45,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: AppColor.primary,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.asset(AppAssets.icFollow, color: AppColor.white, width: 25),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: ListView.builder(
//                       itemCount: 5,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) => Container(
//                         height: 50,
//                         width: 50,
//                         padding: EdgeInsets.only(left: 5),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Container(
//                               height: 30,
//                               width: 30,
//                               clipBehavior: Clip.antiAlias,
//                               margin: EdgeInsets.only(top: 3),
//                               decoration: BoxDecoration(shape: BoxShape.circle),
//                               child: PreviewProfileImageWidget(),
//                             ),
//                             Image.asset(AppAssets.icGoldRing, height: 50, width: 50),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 10.width,
//                 GestureDetector(
//                   onTap: () {
//                     if (controller.scaffoldKey.currentState != null) {
//                       if (controller.scaffoldKey.currentState!.isEndDrawerOpen) {
//                         Navigator.of(context).pop();
//                       } else {
//                         controller.scaffoldKey.currentState!.openEndDrawer();
//                       }
//                     }
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: AppColor.black.withValues(alpha: 0.3),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(AppAssets.icManyUser, color: AppColor.white, width: 16),
//                   ),
//                 ),
//                 10.width,
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: AppColor.black.withValues(alpha: 0.3),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Image.asset(AppAssets.icClose, color: AppColor.white, width: 20),
//                   ),
//                 ),
//                 10.width,
//               ],
//             ),
//           ),
//           10.height,
//           Row(
//             children: [
//               10.width,
//               Container(
//                 height: 30,
//                 padding: EdgeInsets.only(left: 5, right: 8, top: 5, bottom: 5),
//                 decoration: BoxDecoration(
//                   color: AppColor.white.withValues(alpha: 0.3),
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.only(left: 5, right: 8),
//                       decoration: BoxDecoration(
//                         gradient: AppColor.lightOrangeYellowGradient,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(AppAssets.icRedYellowColorFire, width: 12),
//                           3.width,
//                           Text(
//                             "Hours",
//                             style: AppFontStyle.styleW700(AppColor.white, 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     5.width,
//                     Text(
//                       "No.4",
//                       style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
//                     ),
//                   ],
//                 ),
//               ),
//               10.width,
//               Container(
//                 height: 30,
//                 padding: EdgeInsets.only(left: 5, right: 8, top: 4, bottom: 4),
//                 decoration: BoxDecoration(
//                   color: AppColor.bluePurple,
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.only(left: 5, right: 8),
//                       decoration: BoxDecoration(
//                         color: AppColor.white,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(AppAssets.icLotus, width: 15),
//                           3.width,
//                           Text(
//                             "16",
//                             style: AppFontStyle.styleW700(AppColor.darkBlue, 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     5.width,
//                     Text(
//                       "2560.45k",
//                       style: AppFontStyle.styleW700(AppColor.white, 10),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 "ID:511178956",
//                 style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.5), 10),
//               ),
//               10.width,
//             ],
//           ),
//           10.height,
//         ],
//       ),
//     );
//   }
// }
