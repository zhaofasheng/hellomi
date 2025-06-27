import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/follow_unfollow_user_api.dart';
import 'package:tingle/common/function/follow_unfollow_toast.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/model/live_top_gift_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/page/live_page/model/pk_gift_top_user_model.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invitation_for_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invite_user_for_pk_battle_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/sending_pk_request_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/tie_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/you_lost_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/pk_battle_widget/you_win_pk_bottom_sheet.dart';
import 'package:tingle/page/live_page/widget/live_gift_bottom_sheet_widget.dart';
import 'package:tingle/socket/socket_emit.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

import '../../stream_page/model/fetch_live_user_model.dart';

class LiveController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // >>>>> >>>>>> >>>> >>>>> >>>>> AGORA <<<<< <<<<< <<<<< <<<<< <<<<<

  LiveModel? liveModel;

  LiveUserList? liveUserList;

  RxBool isShowPkAnimation = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      Utils.showLog("Live Argument => ${Get.arguments}");
      liveUserList = Get.arguments[ApiParams.liveUserList];

      Utils.showLog("Live Argument Is Host => ${Get.arguments[ApiParams.isHost]}");

      Utils.showLog("Live User List Argument => ${liveUserList?.toJson()}");

      liveModel = LiveModel(
        isHost: Get.arguments[ApiParams.isHost] ?? false,
        isFollow: liveUserList?.isFollow ?? false,
        liveType: liveUserList?.liveType ?? 0,
        isChannelMediaRelay: Get.arguments[ApiParams.isChannelMediaRelay],

        // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
        host1Token: liveUserList?.token ?? "",
        host1Channel: liveUserList?.channel ?? "",
        host1Uid: liveUserList?.agoraUid ?? 0,
        host1LiveHistoryId: liveUserList?.liveHistoryId ?? "",

        // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<

        host1UserId: liveUserList?.userId ?? "",
        host1Name: liveUserList?.name ?? "",
        host1UserName: liveUserList?.userName ?? "",
        host1Image: liveUserList?.image ?? "",
        host1UniqueId: liveUserList?.uniqueId ?? "",
        host1ProfilePicIsBanned: false,
        host1WealthLevelImage: liveUserList?.wealthLevelImage ?? "",
        host1Coin: liveUserList?.coin ?? 0,

        // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<

        host2UserId: liveUserList?.host2Id ?? "",
        host2Name: liveUserList?.host2Name ?? "",
        host2UserName: liveUserList?.host2userName ?? "",
        host2UniqueId: liveUserList?.host2UniqueId ?? "",
        host2Image: liveUserList?.host2Image ?? "",
        host2ProfilePicIsBanned: liveUserList?.host2IsProfilePicBanned ?? false,
        host2WealthLevelImage: liveUserList?.host2wealthLevelImage ?? "",
        host2Coin: liveUserList?.host2Coin ?? 0,

        // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<

        host2Uid: Get.arguments[ApiParams.host2Uid],
        host2LiveHistoryId: liveUserList?.host2LiveId ?? "",
        host2Token: liveUserList?.host2Token ?? "",
        host2Channel: liveUserList?.host2Channel ?? "",
      );
    }

    init();
    super.onInit();
  }

  @override
  void onClose() {
    onDispose();
    super.onClose();
  }

  Future<void> init() async {
    initAgora();
    onJoinLiveRoom();
    onDefaultComment();
    onChangeLiveTime();
    // onAutoExit();
    onFetchSingleLiveUser();
    LiveGiftBottomSheetWidget.init();
    Utils.showLog("Live Controller Init Success => ${liveModel?.liveComments}");
    if (liveModel?.isChannelMediaRelay == true) onShowPkAnimation();
  }

  Future<void> onDispose() async {
    try {
      onDisposeAgora();
      onLeaveLiveRoom();
      liveModel?.liveTimer?.cancel();
      liveModel?.pkTimer?.cancel();
      Utils.showLog("Live Controller Dispose Success");
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  void onChangeLiveType({required int value}) {
    liveModel?.liveType = value;
    liveUserList?.liveType = value;
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> AGORA METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  Future<void> initAgora() async {
    try {
      await liveModel?.engine?.leaveChannel();
      await liveModel?.engine?.release();
      liveModel?.engine = null;
      onCreateEngine();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onDisposeAgora() async {
    try {
      await liveModel?.engine?.leaveChannel();
      await liveModel?.engine?.release();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onCreateEngine() async {
    try {
      liveModel?.engine = createAgoraRtcEngine();
      await liveModel?.engine?.initialize(
        RtcEngineContext(
          appId: Utils.agoraAppId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
      await onJoinChannel();
    } catch (e) {
      Utils.showLog("Event Handler => Create Engine Failed => $e");
    }
  }

  Future<void> onJoinChannel() async {
    try {
      await onEventHandler();

      await liveModel?.engine?.joinChannel(
        uid: (liveModel?.isHost == true) ? (liveModel?.host1Uid ?? 0) : (liveModel?.host2Uid ?? 0),
        token: liveModel?.host1Token ?? "",
        channelId: liveModel?.host1Channel ?? "",
        options: ChannelMediaOptions(),
      );

      await liveModel?.engine?.enableVideo();

      await liveModel?.engine?.setClientRole(role: (liveModel?.isHost == true) ? ClientRoleType.clientRoleBroadcaster : ClientRoleType.clientRoleAudience);

      if (liveModel?.isHost == true) {
        await liveModel?.engine?.startPreview();
      }
    } catch (e) {
      Utils.showLog("Event Handler => Join Channel Failed => $e");
    }
  }

  Future<void> onEventHandler() async {
    liveModel?.engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          Utils.showLog("Event Handler => Host Join Success => ChannelId => ${connection.channelId} LocalUid => ${connection.localUid}");
          if (liveModel?.engine != null && liveModel?.isHost == true) {
            liveModel?.isLoading = false;
            update([AppConstant.onEventHandler]);
          }
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          Utils.showLog("Event Handler => User Join Success => ChannelId => ${connection.channelId} LocalUid => ${connection.localUid} RemoteUid => $remoteUid");
          liveModel?.isLoading = false;
          update([AppConstant.onEventHandler]);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          Utils.showLog("Event Handler => User Leave Channel Success");
        },
        onError: (e, message) {
          Utils.showLog("Event Handler => Join Channel Failed => $e");
        },
        onChannelMediaRelayStateChanged: (ChannelMediaRelayState state, ChannelMediaRelayError code) {
          Utils.showLog("Event Handler => Channel Media Relay State Changed : $state");
          switch (state) {
            case ChannelMediaRelayState.relayStateIdle:
              Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
              break;
            case ChannelMediaRelayState.relayStateRunning:
              Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
              break;
            case ChannelMediaRelayState.relayStateFailure:
              Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
              break;
            default:
              Utils.showLog("Event Handler => Channel Media Relay State Changed : ");
              break;
          }
        },
      ),
    );
  }

  Future<void> onSwitchCamera() async {
    try {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
      await liveModel?.engine?.switchCamera();
      Get.back(); // Stop Loading...
    } catch (e) {
      Utils.showLog("Event Handler => Switch Camera Failed => $e");
    }
  }

  Future<void> onSwitchMic() async {
    try {
      if (liveModel?.isMute == true) {
        liveModel?.isMute = false;
        update([AppConstant.onSwitchMic]);
        await liveModel?.engine?.muteLocalAudioStream(false);
      } else {
        liveModel?.isMute = true;
        update([AppConstant.onSwitchMic]);
        await liveModel?.engine?.muteLocalAudioStream(true);
      }
    } catch (e) {
      Utils.showLog("Event Handler => Switch Mic Failed => $e");
    }
  }

  Future<void> onStartChannelMediaRelay() async {
    try {
      await liveModel?.engine?.startOrUpdateChannelMediaRelay(
        ChannelMediaRelayConfiguration(
          srcInfo: ChannelMediaInfo(
            channelName: liveModel?.host1Channel ?? "",
            token: liveModel?.host1Token ?? "",
            uid: 0,
          ),
          destInfos: [
            ChannelMediaInfo(
              channelName: liveModel?.host2Channel ?? "",
              token: liveModel?.host2Token ?? "",
              uid: 1,
            ),
          ],
          destCount: 1,
        ),
      );

      Utils.showLog("On Start Relay Method Call Success");
    } catch (e) {
      Utils.showLog("Stop Channel Media Relay Failed => $e");
    }
  }

  Future<void> onStopChannelMediaRelay() async {
    try {
      await liveModel?.engine?.stopChannelMediaRelay();
    } catch (e) {
      Utils.showLog("Stop Channel Media Relay Failed => $e");
    }
  }

  Future<void> onChangeChannelMediaRelay(bool value) async {
    liveModel?.isChannelMediaRelay = value;

    update([AppConstant.onEventHandler]);

    onChangeLiveType(value: value ? 1 : 3); // 1 Live 3 Pk
  }

  void onUpdateTopGiftUser({required List<PkGiftTopUserModel> users, required String liveHistoryId}) async {
    if (liveModel?.host1LiveHistoryId == liveHistoryId) {
      liveModel?.host1TopGiftUsers = users;
    } else {
      liveModel?.host2TopGiftUsers = users;
    }

    update([AppConstant.onSeatUserUpdate]);
  }

  void onChangeTopGiftUser({
    required List<PkGiftTopUserModel> host1,
    required List<PkGiftTopUserModel> host2,
  }) async {
    liveModel?.host1TopGiftUsers = host1;
    liveModel?.host2TopGiftUsers = host2;

    update([AppConstant.onSeatUserUpdate]);
  }

// >>>>> >>>>>> >>>> >>>>> >>>>> SOCKET EMIT METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onJoinLiveRoom() async {
    if (liveModel?.isHost == true) {
      SocketEmit.onJoinLiveRoom(liveHistoryId: liveModel?.host1LiveHistoryId ?? "");
    } else {
      SocketEmit.onCountLiveJoin(
        userId: Database.loginUserId,
        entryRide: Database.fetchLoginUserProfile()?.user?.activeRide?.image ?? "",
        entryRideType: Database.fetchLoginUserProfile()?.user?.activeRide?.type ?? 0,
        liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
        liveType: liveModel?.liveType ?? 0,
        host2LiveId: liveModel?.host2LiveHistoryId ?? "",
      );
    }
  }

  void onLeaveLiveRoom() async {
    if (liveModel?.isHost == true) {
      liveModel?.isChannelMediaRelay == true
          ? onPkEnd(isManualMode: true)
          : SocketEmit.onEndLiveStream(
              liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
              userId: Database.loginUserId,
            );
    } else {
      SocketEmit.onReduceLiveJoiners(
        userId: Database.loginUserId,
        liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
      );
    }
  }

  Future<void> onSendComment() async {
    if (liveModel?.commentController.text.trim().isNotEmpty ?? false) {
      SocketEmit.onBroadcastLiveComment(
        liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
        senderUserId: Database.fetchLoginUserProfile()?.user?.id ?? "",
        senderName: Database.fetchLoginUserProfile()?.user?.name ?? "",
        senderImage: Database.fetchLoginUserProfile()?.user?.image ?? "",
        senderProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
        commentText: liveModel?.commentController.text.trim() ?? "",
        isBattleActive: liveModel?.isChannelMediaRelay == true,
      );
      liveModel?.commentController.clear();
      update([AppConstant.onChangeComment]);
    }
  }

  Future<void> onSendPkRequest({required String host2UserId}) async {
    SocketEmit.onPkRequest(
      host2Id: host2UserId,
      host1Uid: liveModel?.host1Uid ?? 0,
      host1Token: liveModel?.host1Token ?? "",
      host1Channel: liveModel?.host1Channel ?? "",
      host1LiveHistoryId: liveModel?.host1LiveHistoryId ?? "",
      host1Id: liveModel?.host1UserId ?? "",
      host1Name: liveModel?.host1Name ?? "",
      host1UserName: liveModel?.host1UserName ?? "",
      host1UniqueId: liveModel?.host1UniqueId ?? "",
      host1Image: liveModel?.host1Image ?? "",
      host1ProfilePicIsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
      instantCutRequestByHost: false,
    );
  }

  Future<void> onCancelPkRequest({required String host2UserId}) async {
    SocketEmit.onPkRequest(
      host2Id: host2UserId,
      host1Uid: liveModel?.host1Uid ?? 0,
      host1Token: liveModel?.host1Token ?? "",
      host1Channel: liveModel?.host1Channel ?? "",
      host1LiveHistoryId: liveModel?.host1LiveHistoryId ?? "",
      host1Id: liveModel?.host1UserId ?? "",
      host1Name: liveModel?.host1Name ?? "",
      host1UserName: liveModel?.host1UserName ?? "",
      host1UniqueId: liveModel?.host1UniqueId ?? "",
      host1Image: liveModel?.host1Image ?? "",
      host1ProfilePicIsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
      instantCutRequestByHost: true,
    );
  }

  Future<void> onPkAnswer({required bool isAccept}) async {
    SocketEmit.onPkAnswer(
      isAccept: isAccept,

      // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
      HOST_1_AGORA_ID: liveModel?.host1Uid ?? 0,
      HOST_1_CHANNEL: liveModel?.host1Channel ?? "",
      HOST_1_LIVEID: liveModel?.host1LiveHistoryId ?? "",
      HOST_1_TOKEN: liveModel?.host1Token ?? "",

      // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<
      HOST_1_ID: liveModel?.host1UserId ?? "",
      HOST_1_NAME: liveModel?.host1Name ?? "",
      HOST_1_USERNAME: liveModel?.host1UserName ?? "",
      HOST_1_IMAGE: liveModel?.host1Image ?? "",
      HOST_1_PROFILEPICISBANNED: liveModel?.host1ProfilePicIsBanned ?? false,
      HOST_1_UNIQUEID: liveModel?.host1UniqueId ?? "",
      HOST_1_WEALTHLEVEL_IMAGE: liveModel?.host1WealthLevelImage ?? "",

      // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
      HOST_2_AGORA_ID: liveModel?.host2Uid ?? 0,
      HOST_2_CHANNEL: liveModel?.host2Channel ?? "",
      HOST_2_LIVEID: liveModel?.host2LiveHistoryId ?? "",
      HOST_2_TOKEN: liveModel?.host2Token ?? "",

      // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
      HOST_2_ID: liveModel?.host2UserId ?? "",
      HOST_2_NAME: liveModel?.host2Name ?? "",
      HOST_2_USERNAME: liveModel?.host2UserName ?? "",
      HOST_2_IMAGE: liveModel?.host2Image ?? "",
      HOST_2_PROFILEPICISBANNED: liveModel?.host2ProfilePicIsBanned ?? false,
      HOST_2_UNIQUEID: liveModel?.host2UniqueId ?? "",
      HOST_2_WEALTHLEVEL_IMAGE: liveModel?.host2WealthLevelImage ?? "",
    );
  }

  Future<void> onPkEnd({required bool isManualMode}) async {
    SocketEmit.onPkEnd(
      liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
      userId: liveModel?.host1UserId ?? "",
      isManualMode: isManualMode,
      pkEndUserId: liveModel?.host1UserId ?? "",
    );
  }

  Future<void> onFetchSingleLiveUser() async {
    SocketEmit.onFetchSingleLiveUser(
      liveHistoryId: liveUserList?.liveHistoryId ?? "",
      liveUserObjId: liveUserList?.id ?? "",
    );
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> SOCKET LISTEN METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onUpdateCoin({required int coin}) async {
    liveModel?.liveEarnedCoin = coin;
    update([AppConstant.onUpdateCoin]);
  }

  void onChangeTopLiveGiftUser({required List<LiveTopGiftUserModel> value}) async {
    liveModel?.liveTopGiftUsers = value;
    update([AppConstant.onUpdateTopGiftUser]);
    Utils.showLog("Top Live User List Length => ${liveModel?.liveTopGiftUsers.length}");
  }

  void onListenPkEnd(dynamic data) {
    liveModel?.host1Rank = 0;
    liveModel?.host2Rank = 0;

    if (liveModel?.isHost == true) onStopChannelMediaRelay();
    onChangeChannelMediaRelay(false);

    if (data[SocketParams.isManualMode] == false || data[SocketParams.pkEndUserId] != liveModel?.host1UserId) {
      if (data[SocketParams.data][SocketParams.pkConfig][SocketParams.isWinner] == 1) {
        YouLostPkBottomSheet.onShow(
          h1Name: liveModel?.host1Name ?? "",
          h1Image: liveModel?.host1Image ?? "",
          h1IsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: liveModel?.host2Name ?? "",
          h2Image: liveModel?.host2Image ?? "",
          h2IsBanned: liveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: liveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      } else if (data[SocketParams.data][SocketParams.pkConfig][SocketParams.isWinner] == 2) {
        YouWinPkBottomSheet.onShow(
          h1Name: liveModel?.host1Name ?? "",
          h1Image: liveModel?.host1Image ?? "",
          h1IsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: liveModel?.host2Name ?? "",
          h2Image: liveModel?.host2Image ?? "",
          h2IsBanned: liveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: liveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      } else {
        TiePkBottomSheet.onShow(
          h1Name: liveModel?.host1Name ?? "",
          h1Image: liveModel?.host1Image ?? "",
          h1IsBanned: liveModel?.host1ProfilePicIsBanned ?? false,
          h2Name: liveModel?.host2Name ?? "",
          h2Image: liveModel?.host2Image ?? "",
          h2IsBanned: liveModel?.host2ProfilePicIsBanned ?? false,
          h1Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.localRank],
          h2Rank: data[SocketParams.data][SocketParams.pkConfig][SocketParams.remoteRank],
          isHost: liveModel?.isHost == true,
          battleAgainCallback: () {
            Get.back();
            InviteUserForPkBattleBottomSheet.onShow();
          },
        );
      }
    }

    if (data[SocketParams.isManualMode] == true && data[SocketParams.pkEndUserId] == liveModel?.host1UserId) {
      Get.back(); // Stop Live Steaming
    }
  }

  void onChangeViewCount(int value) {
    liveModel?.host1ViewCount = value;
    update([AppConstant.onChangeViewCount]);
  }

  void onGetComment({required LiveCommentModel comment}) {
    liveModel?.liveComments.add(comment);
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  void onPkRequestReceived(dynamic data) async {
    final jsonResponse = jsonDecode(data);

    if (jsonResponse[SocketParams.InstantCutRequestByHost] == false) {
      // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
      liveModel?.host2Uid = jsonResponse[SocketParams.host1Uid];
      liveModel?.host2Token = jsonResponse[SocketParams.host1Token];
      liveModel?.host2Channel = jsonResponse[SocketParams.host1Channel];
      liveModel?.host2LiveHistoryId = jsonResponse[SocketParams.host1LiveHistoryId];

      // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
      liveModel?.host2UserId = jsonResponse[SocketParams.host1Id];
      liveModel?.host2Name = jsonResponse[SocketParams.host1Name];
      liveModel?.host2Image = jsonResponse[SocketParams.host1Image];
      liveModel?.host2UserName = jsonResponse[SocketParams.host1UserName];
      liveModel?.host2UniqueId = jsonResponse[SocketParams.host1UniqueId];
      liveModel?.host2ProfilePicIsBanned = jsonResponse[SocketParams.host1ProfilePicIsBanned];

      if (InviteUserForPkBattleBottomSheet.isOpenBottomSheet) Get.back();
      if (TiePkBottomSheet.isOpenBottomSheet) Get.back();
      if (YouWinPkBottomSheet.isOpenBottomSheet) Get.back();
      if (YouLostPkBottomSheet.isOpenBottomSheet) Get.back();

      InvitationForPkBottomSheet.onShow(
        name: jsonResponse[SocketParams.host1Name],
        image: jsonResponse[SocketParams.host1Image],
        uniqueId: jsonResponse[SocketParams.host1UniqueId],
        isBanned: jsonResponse[SocketParams.host1ProfilePicIsBanned],
        accept: () {
          Get.back();
          onPkAnswer(isAccept: true);
        },
        reject: () {
          Get.back();
          onPkAnswer(isAccept: false);
        },
      );
    } else {
      // CALL WHEN IF HOST_1 CANCEL PK REQUEST
      if (InvitationForPkBottomSheet.isOpenBottomSheet) Get.back(); // IF OPENED INVITE BOTTOM SHEET THEN CLOSE
    }
  }

  Future<void> onListenPkAnswer(dynamic value) async {
    final jsonResponse = jsonDecode(value[SocketParams.data]);

    if (SendingPkRequestBottomSheet.isOpenBottomSheet) Get.back();
    if (TiePkBottomSheet.isOpenBottomSheet) Get.back();
    if (YouWinPkBottomSheet.isOpenBottomSheet) Get.back();
    if (YouLostPkBottomSheet.isOpenBottomSheet) Get.back();

    if (jsonResponse[SocketParams.isAccept] == true) {
      // IF I AM PK REQUEST HOST
      if (liveModel?.host1LiveHistoryId == jsonResponse[SocketParams.HOST_2_LIVEID]) {
        Utils.showLog("This is Pk Request User => ${liveModel?.host1UserId}");

        liveModel?.host2Uid = jsonResponse[SocketParams.HOST_1_AGORA_ID];
        liveModel?.host2Token = jsonResponse[SocketParams.HOST_1_TOKEN];
        liveModel?.host2Channel = jsonResponse[SocketParams.HOST_1_CHANNEL];
        liveModel?.host2LiveHistoryId = jsonResponse[SocketParams.HOST_1_LIVEID];
        liveModel?.host2Name = jsonResponse[SocketParams.HOST_1_NAME];
        liveModel?.host2UserName = jsonResponse[SocketParams.HOST_1_USERNAME];
        liveModel?.host2Image = jsonResponse[SocketParams.HOST_1_IMAGE];
        liveModel?.host2ProfilePicIsBanned = jsonResponse[SocketParams.HOST_1_PROFILEPICISBANNED];
      }

      onChangePkTime(isPkRequestUser: liveModel?.host1LiveHistoryId == jsonResponse[SocketParams.HOST_2_LIVEID], time: value[SocketParams.response][SocketParams.duration]);
      onShowPkAnimation();
      onChangeChannelMediaRelay(true);
      if (liveModel?.isHost == true) onStartChannelMediaRelay();
    }
  }

  void onLiveViewerUserUpdateSocket(List<LiveViewerUserModel> value) async {
    liveModel?.liveViewers = value;
    update([AppConstant.onChangeViewCount]);
    Utils.showLog("Current Total Viewer => ${liveModel?.liveViewers.length}");
  }

  void onChangeRank({required int host1Rank, required int host2Rank, int? time}) async {
    liveModel?.host1Rank = host1Rank;
    liveModel?.host2Rank = host2Rank;
    update([AppConstant.onChangeRank]);

    Utils.showLog("Left Time => $time");

    if (time != null && liveModel?.isHost == false) {
      onChangePkTime(isPkRequestUser: false, time: time);
    }

    Utils.showLog("Updated Rank => H1=> ${liveModel?.host1Rank} => H2 => ${liveModel?.host2Rank}");
  }

  // >>>>> >>>>>> >>>> >>>>> >>>>> DEFAULT METHOD <<<<< <<<<< <<<<< <<<<< <<<<<

  void onChangeLiveTime() {
    liveModel?.liveTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        liveModel?.liveCountTime++;
        update([AppConstant.onChangeLiveTime]);
      },
    );
  }

  void onChangePkTime({required bool isPkRequestUser, required int time}) {
    liveModel?.pkTimer?.cancel();

    liveModel?.pkCountTime = time;
    liveModel?.pkTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (liveModel?.pkCountTime != 0) {
          liveModel?.pkCountTime--;
          update([AppConstant.onChangePkTime]);
          // Utils.showLog("Pk Battle Time => ${ConvertSecondToTime.onConvert(liveModel?.pkCountTime ?? 0)}");
        } else {
          liveModel?.pkCountTime = 0;
          liveModel?.pkTimer?.cancel();

          liveModel?.host1TopGiftUsers.clear();
          liveModel?.host2TopGiftUsers.clear();

          if (liveModel?.isHost == true && isPkRequestUser) onPkEnd(isManualMode: false);
        }
      },
    );
  }

  void onDefaultComment() {
    liveModel?.liveComments.addAll(
      [
        LiveCommentModel(
          type: 2,
          name: "",
          image: "",
          commentText: "",
          userId: "",
          isBanned: false,
        ),
        LiveCommentModel(
          type: 3,
          name: "",
          image: "",
          commentText: "",
          userId: "",
          isBanned: false,
        ),
      ],
    );
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  Future<void> onScrollAnimation() async {
    try {
      await 10.milliseconds.delay();
      liveModel?.scrollController.animateTo(
        liveModel?.scrollController.position.maxScrollExtent ?? 0,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  void onClickGift(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    LiveGiftBottomSheetWidget.show(
      context: context,
      liveHistoryId: liveModel?.host1LiveHistoryId ?? "",
      receiverUserId: liveModel?.host1UserId ?? "",
    );
  }

  void onShowPkAnimation() async {
    await 1000.milliseconds.delay();
    isShowPkAnimation.value = true;
    await 1500.milliseconds.delay();
    isShowPkAnimation.value = false;
  }

  void onClickFollow() async {
    liveModel?.isFollow = !(liveModel?.isFollow ?? false);
    update([AppConstant.onClickFollow]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    await FollowUnfollowUserApi.callApi(token: token, uid: uid, toUserId: liveModel?.host1UserId ?? "");

    FollowUnfollowToast.onShow(name: liveModel?.host1Name ?? "", isFollow: liveModel?.isFollow == true);
  }

  void onAutoExit() {
    Future.delayed(
      Duration(seconds: 10),
      () {
        if (liveModel?.engine == null || liveModel?.isLoading == true) {
          Get.back();
        }
      },
    );
  }
}
