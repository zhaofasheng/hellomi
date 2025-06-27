// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
// import 'package:tingle/page/feed_page/api/fetch_video_api.dart';
// import 'package:tingle/page/feed_video_page/model/fetch_video_model.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FeedVideoController extends GetxController {
//   @override
//   void onInit() {
//     Utils.showLog("Feed Video Controller Init Success");
//     super.onInit();
//   }
//
//   Future<void> init() async {
//     final controller = Get.find<BottomBarController>();
//     if (Get.currentRoute == AppRoutes.bottomBarPage && controller.selectedTabIndex == 2) {
//       // await 100.milliseconds.delay(); // Use For Extend Body...
//       await onRefreshVideos();
//     }
//   }
// }
