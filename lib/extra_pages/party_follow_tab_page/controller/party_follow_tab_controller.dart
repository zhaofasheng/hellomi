// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
// import 'package:tingle/page/audio_room_page/widget/private_audio_room_bottom_sheet_widget.dart';
// import 'package:tingle/page/stream_page/api/fetch_live_user_api.dart';
// import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/database.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PartyFollowTabController extends GetxController {
//   ScrollController scrollController = ScrollController();
//
//   bool isLoading = false;
//   bool isLoadingPagination = false;
//   FetchLiveUserModel? fetchLiveUserModel;
//   List<LiveUserList> liveUsers = [];
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
//   Future<void> onRefresh() async {
//     isLoading = true;
//     liveUsers.clear();
//     update([AppConstant.onGetLiveUser]);
//     FetchLiveUserApi.startPagination = 0;
//     update([AppConstant.onGetLiveUser]);
//     await onGetLiveUser();
//   }
//
//   Future<void> onGetLiveUser() async {
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//
//     fetchLiveUserModel = await FetchLiveUserApi.callApi(token: token, uid: uid, liveType: ApiParams.followLiveAudio);
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
//
//   void onClickItem(LiveUserList indexData) async {
//     if (indexData.liveType == 2) {
//       if (indexData.audioLiveType == 1) {
//         // Private Room
//
//         PrivateAudioRoomBottomSheetWidget.show(
//           password: indexData.privateCode ?? 0,
//           callBack: () {
//             onJoinAudioRoom(indexData);
//           },
//         );
//       } else if (indexData.audioLiveType == 2) {
//         // Public Room
//         onJoinAudioRoom(indexData);
//       }
//     }
//   }
//
//   void onJoinAudioRoom(LiveUserList indexData) {
//     if (indexData.blockedUsers?.contains(Database.loginUserId) == false) {
//       Get.toNamed(
//         AppRoutes.audioRoomPage,
//         arguments: AudioRoomModel(
//           isHost: false,
//           hostUserId: indexData.userId ?? "",
//           hostUid: indexData.agoraUid ?? 0,
//           hostIsMuted: false,
//           mute: 0,
//           liveHistoryId: indexData.liveHistoryId ?? "",
//           liveUserObjId: indexData.id ?? "",
//           roomName: indexData.roomName ?? "",
//           roomImage: indexData.roomImage ?? "",
//           roomWelcome: indexData.roomWelcome ?? "",
//           token: indexData.token ?? "",
//           channel: indexData.channel ?? "",
//           userUid: (100000 + Random().nextInt(900000)),
//           audioLiveType: indexData.audioLiveType ?? 0,
//           audioRoomPrivateCode: indexData.privateCode ?? 0,
//           audioRoomSeats: indexData.seat ?? [],
//           isFollow: indexData.isFollow ?? false,
//           bgTheme: indexData.bgTheme ?? "",
//         ),
//       );
//     } else {
//       Utils.showToast(text: "You are blocked by admin");
//     }
//   }
// }
