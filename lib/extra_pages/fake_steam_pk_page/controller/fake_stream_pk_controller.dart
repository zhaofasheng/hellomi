// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
// import 'package:tingle/page/fake_steam_pk_page/widget/fake_one_vs_one_pk_widget.dart';
// import 'package:tingle/page/fake_steam_pk_page/widget/fake_team_pk_widget.dart';
// import 'package:tingle/page/stream_page/api/fetch_live_user_api.dart';
// import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FakeStreamPkController extends GetxController {
//   ScrollController scrollController = ScrollController();
//
//   bool isLoading = false;
//   bool isLoadingPagination = false;
//   FetchLiveUserModel? fetchLiveUserModel;
//   List<LiveUserList> liveUsers = [];
//
//   int selectedPkType = 0;
//   List<Widget> FakepkTypePages = [const FakeOneVsOnePkWidget(), const FakeTeamPkWidget()];
//
//   @override
//   void onInit() {
//     scrollController.addListener(onPagination);
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     scrollController.removeListener(onPagination);
//     super.onClose();
//   }
//
//   void init() {
//     final bottomBarController = Get.find<BottomBarController>();
//     if (Get.currentRoute == AppRoutes.bottomBarPage && bottomBarController.selectedTabIndex == 0) {
//       onRefresh();
//     }
//   }
//
//   void onChangePkType(int value) {
//     selectedPkType = value;
//     update([AppConstant.onChangePkType]);
//   }
//
//   Future<void> onRefresh() async {
//     isLoading = true;
//     liveUsers.clear();
//     FetchLiveUserApi.startPagination = 0;
//     update([AppConstant.onGetLiveUser]);
//     await onGetLiveUser();
//   }
//
//   Future<void> onGetLiveUser() async {
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//
//     fetchLiveUserModel = await FetchLiveUserApi.callApi(token: token, uid: uid, liveType: ApiParams.pk);
//
//     Utils.showLog("Live User Pagination Data Length => ${fetchLiveUserModel?.liveUserList}");
//
//     liveUsers.addAll(fetchLiveUserModel?.liveUserList ?? []);
//     isLoading = false;
//     update([AppConstant.onGetLiveUser]);
//
//     if (fetchLiveUserModel?.liveUserList?.isEmpty ?? true) {
//       FetchLiveUserApi.startPagination--;
//     }
//   }
//
//   void onPagination() async {
//     if (scrollController.position.pixels == scrollController.position.minScrollExtent && isLoadingPagination == false) {
//       isLoadingPagination = true;
//       update([AppConstant.onPagination]);
//       onGetLiveUser();
//       isLoadingPagination = false;
//       update([AppConstant.onPagination]);
//     }
//   }
// }
