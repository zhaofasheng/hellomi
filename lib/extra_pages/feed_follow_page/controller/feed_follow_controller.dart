// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
// import 'package:tingle/page/feed_page/api/fetch_follow_post_api.dart';
// import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/constant.dart';
//
// class FeedFollowController extends GetxController {
//   ScrollController scrollController = ScrollController();
//
//   bool isLoading = false;
//   bool isLoadingPagination = false;
//
//   List<Post> followPost = [];
//   FetchPostModel? fetchPostModel;
//
//   @override
//   void onInit() {
//     scrollController.addListener(onFollowPagination);
//     super.onInit();
//   }
//
//   Future<void> init() async {
//     final controller = Get.find<BottomBarController>();
//     if (Get.currentRoute == AppRoutes.bottomBarPage && controller.selectedTabIndex == 2) {
//       onRefreshFollowPost();
//     }
//   }
// }
