// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/page/extra_pages/pk_battle_page/controller/pk_battle_controller.dart';
// import 'package:tingle/page/extra_pages/pk_battle_page/widget/pk_battle_app_bar_widget.dart';
// import 'package:tingle/page/extra_pages/pk_battle_page/widget/pk_battle_drawer_widget.dart';
// import 'package:tingle/page/live_page/pk_battle_widget/pk_rank_slider_widget.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PkBattleView extends GetView<PkBattleController> {
//   const PkBattleView({super.key});
//
//   @override
//   Widget build(BuildContext context) {

//
//     return Scaffold(
//       key: controller.scaffoldKey,
//       endDrawer: PkBattleDrawerWidget(),
//       body: Stack(
//         children: [
//           Container(
//             height: Get.height,
//             width: Get.width,
//             decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
//           ),
//           SizedBox(
//             height: Get.height,
//             width: Get.width,
//             child: Column(
//               children: [
//                 (MediaQuery.of(context).viewPadding.top).height,
//                 Expanded(
//                   child: LayoutBuilder(builder: (context, box) {
//                     double commentHeight = (Get.height - (MediaQuery.of(context).viewPadding.top + 70 + 450));
//                     return SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           10.height,
//                           PkBattleAppBarWidget(),
//                           10.height,
//                           Container(
//                             height: 330,
//                             width: Get.width,
//                             color: AppColor.transparent,
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Image.network(
//                                           "https://images.unsplash.com/photo-1516522973472-f009f23bba59?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Image.network(
//                                           "https://images.unsplash.com/photo-1604004215402-e0be233f39be?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTc2fHxnaXJsfGVufDB8fDB8fHww",
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 PkRankSliderWidget(rank1: 0, rank2: 0, width: Get.width, height: 25),
//                                 Container(
//                                   height: 50,
//                                   width: Get.width,
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColor.blue.withValues(alpha: 0.5),
//                                         AppColor.black,
//                                         AppColor.pink.withValues(alpha: 0.9),
//                                       ],
//                                     ),
//                                   ),
//                                   child: Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: SingleChildScrollView(
//                                               scrollDirection: Axis.horizontal,
//                                               child: Row(
//                                                 children: [
//                                                   30.width,
//                                                   ListView.builder(
//                                                     itemCount: 5,
//                                                     shrinkWrap: true,
//                                                     scrollDirection: Axis.horizontal,
//                                                     physics: NeverScrollableScrollPhysics(),
//                                                     itemBuilder: (context, index) {
//                                                       return GestureDetector(
//                                                         onTap: () => Utils.showLog("******$index"),
//                                                         child: Container(
//                                                           height: 40,
//                                                           width: 40,
//                                                           margin: EdgeInsets.only(right: 10),
//                                                           decoration: BoxDecoration(
//                                                             shape: BoxShape.circle,
//                                                             border: Border.all(color: AppColor.white),
//                                                           ),
//                                                           child: Container(
//                                                             height: 40,
//                                                             width: 40,
//                                                             alignment: Alignment.center,
//                                                             clipBehavior: Clip.antiAlias,
//                                                             decoration: BoxDecoration(
//                                                               shape: BoxShape.circle,
//                                                               color: AppColor.transparent,
//                                                             ),
//                                                             child: Stack(
//                                                               alignment: Alignment.center,
//                                                               children: [
//                                                                 PreviewProfileImageWidget(),
//                                                                 Positioned(
//                                                                   bottom: -10,
//                                                                   child: Container(
//                                                                     height: 28,
//                                                                     width: 28,
//                                                                     alignment: Alignment.center,
//                                                                     padding: EdgeInsets.only(bottom: 14),
//                                                                     decoration: BoxDecoration(
//                                                                       shape: BoxShape.circle,
//                                                                       color: AppColor.primary,
//                                                                     ),
//                                                                     child: Text(
//                                                                       "${index + 1}",
//                                                                       style: AppFontStyle.styleW600(AppColor.white, 9),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           30.width,
//                                           Expanded(
//                                             child: SingleChildScrollView(
//                                               scrollDirection: Axis.horizontal,
//                                               child: Row(
//                                                 children: [
//                                                   ListView.builder(
//                                                     itemCount: 5,
//                                                     shrinkWrap: true,
//                                                     scrollDirection: Axis.horizontal,
//                                                     physics: NeverScrollableScrollPhysics(),
//                                                     itemBuilder: (context, index) {
//                                                       return GestureDetector(
//                                                         onTap: () => Utils.showLog("******$index"),
//                                                         child: Container(
//                                                           height: 40,
//                                                           width: 40,
//                                                           margin: EdgeInsets.only(right: 10),
//                                                           decoration: BoxDecoration(
//                                                             shape: BoxShape.circle,
//                                                             border: Border.all(color: AppColor.white),
//                                                           ),
//                                                           child: Container(
//                                                             height: 40,
//                                                             width: 40,
//                                                             alignment: Alignment.center,
//                                                             clipBehavior: Clip.antiAlias,
//                                                             decoration: BoxDecoration(
//                                                               shape: BoxShape.circle,
//                                                               color: AppColor.transparent,
//                                                             ),
//                                                             child: Stack(
//                                                               alignment: Alignment.center,
//                                                               children: [
//                                                                 PreviewProfileImageWidget(),
//                                                                 Positioned(
//                                                                   bottom: -10,
//                                                                   child: Container(
//                                                                     height: 28,
//                                                                     width: 28,
//                                                                     alignment: Alignment.center,
//                                                                     padding: EdgeInsets.only(bottom: 14),
//                                                                     decoration: BoxDecoration(
//                                                                       shape: BoxShape.circle,
//                                                                       color: AppColor.primary,
//                                                                     ),
//                                                                     child: Text(
//                                                                       "${index + 1}",
//                                                                       style: AppFontStyle.styleW600(AppColor.white, 9),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                   30.width,
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Positioned(
//                                         left: 0,
//                                         child: Container(
//                                           height: 70,
//                                           width: 50,
//                                           padding: EdgeInsets.only(left: 10),
//                                           alignment: Alignment.centerLeft,
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               end: Alignment.centerLeft,
//                                               begin: Alignment.centerRight,
//                                               colors: [
//                                                 AppColor.blue.withValues(alpha: 0.1),
//                                                 AppColor.blue,
//                                                 AppColor.blue,
//                                               ],
//                                             ),
//                                           ),
//                                           child: Image.asset(AppAssets.icArrowLeft, width: 8, color: AppColor.white),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         right: 0,
//                                         child: Container(
//                                           height: 70,
//                                           width: 50,
//                                           padding: EdgeInsets.only(right: 10),
//                                           alignment: Alignment.centerRight,
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               begin: Alignment.centerLeft,
//                                               end: Alignment.centerRight,
//                                               colors: [
//                                                 AppColor.pink.withValues(alpha: 0.1),
//                                                 AppColor.pink,
//                                                 AppColor.pink,
//                                               ],
//                                             ),
//                                           ),
//                                           child: Image.asset(AppAssets.icArrowRight, width: 8, color: AppColor.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: commentHeight,
//                             width: Get.width,
//                             color: AppColor.transparent,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: commentHeight - 50,
//                                   width: Get.width / 1.7,
//                                   color: AppColor.transparent,
//                                   child: TabWiseCommentWidget(),
//                                 ),
//                                 5.height,
//                                 CommentTabBar(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//                 PkBattleBottomBarWidget(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
