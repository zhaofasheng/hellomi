import 'dart:async';
import 'dart:math';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/follow_unfollow_user_api.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/function/follow_unfollow_toast.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/stand_up_seat_dialog_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/api/edit_audio_room_api.dart';
import 'package:tingle/page/audio_room_page/api/fetch_audio_room_bloc_user_api.dart';
import 'package:tingle/page/audio_room_page/api/stop_audio_room_api.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_seat_users_model.dart';
import 'package:tingle/page/audio_room_page/model/fetch_audio_room_bloc_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_top_gift_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/audio_room_page/model/reaction_model.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_blank_seat_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_gift_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_seat_request_dialog_widget.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_seat_user_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/widget/close_audio_room_dialog_widget.dart';
import 'package:tingle/page/audio_room_page/widget/emoji_bottom_sheet_widget.dart';
import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/socket/socket_emit.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

class AudioRoomController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedTabIndex = 0;
  bool isShowTextField = true;

  AudioRoomModel? audioRoomModel;

  LiveUserList? liveUserList;

  @override
  void onInit() {
    Utils.showLog("Get Argument => ${Get.arguments}");
    if (Get.arguments != null) {
      audioRoomModel?.seatUsers.clear();

      liveUserList = Get.arguments[ApiParams.liveUserList];

      Utils.showLog("Live Argument Is Host => ${Get.arguments[ApiParams.isHost]}");
      Utils.showLog("Live Argument UID => ${Get.arguments[ApiParams.userUid]}");

      audioRoomModel = AudioRoomModel(
        streamSource: liveUserList?.streamSource ?? "",
        isHost: Get.arguments[ApiParams.isHost] ?? false,
        hostUserId: liveUserList?.userId ?? "",
        hostUid: liveUserList?.agoraUid ?? 0,
        hostIsMuted: false,
        mute: 0,
        liveHistoryId: liveUserList?.liveHistoryId ?? "",
        liveUserObjId: liveUserList?.id ?? "",
        roomName: liveUserList?.roomName ?? "",
        roomImage: liveUserList?.roomImage ?? "",
        roomWelcome: liveUserList?.roomWelcome ?? "",
        privateCode: liveUserList?.privateCode ?? 0,
        token: liveUserList?.token ?? "",
        channel: liveUserList?.channel ?? "",
        userUid: Get.arguments[ApiParams.userUid] ?? 0,
        audioLiveType: liveUserList?.audioLiveType ?? 0,
        audioRoomPrivateCode: liveUserList?.privateCode ?? 0,
        audioRoomSeats: liveUserList?.seat ?? [],
        isFollow: liveUserList?.isFollow ?? false,
        bgTheme: liveUserList?.bgTheme ?? "",
        hostUniqueId: liveUserList?.uniqueId ?? "",
        hostName: liveUserList?.name ?? "",
      );
    }
    init();
    super.onInit();
  }

  @override
  void onClose() {
    onDispose();
    audioRoomModel?.timer?.cancel();
    super.onClose();
  }

  void init() {
    onCreateEngine();
    onJoinAudioRoomSocket();
    onFetchBlockUser();
    onInitReaction();
    onStartVoiceAnimation();
    onDefaultComment();
    EmojiBottomSheetWidget.onGetEmoji();
    AudioRoomGiftBottomSheetWidget.init();
    onSeatCountModifiedSocket(seatCount: 12); // Change Initial Seat Count...
  }

  void onInitReaction() {
    audioRoomModel?.reactions = [];

    final seatLength = audioRoomModel?.audioRoomSeats.length ?? 0;

    for (int i = 0; i < seatLength; i++) {
      audioRoomModel?.reactions.add(null);
    }

    Utils.showLog("Reaction Init Length => ${audioRoomModel?.reactions.length}");
  }

  void onClickFollow() async {
    audioRoomModel?.isFollow = !(audioRoomModel?.isFollow ?? false);
    update([AppConstant.onClickFollow]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    await FollowUnfollowUserApi.callApi(token: token, uid: uid, toUserId: audioRoomModel?.hostUserId ?? "");

    FollowUnfollowToast.onShow(name: audioRoomModel?.hostName ?? "", isFollow: audioRoomModel?.isFollow == true);
  }

  void onToggleComment({bool? isShow}) {
    audioRoomModel?.isShowComments = isShow ?? !(audioRoomModel?.isShowComments ?? false);

    update([AppConstant.onToggleComment]);
    FocusManager.instance.primaryFocus?.unfocus();
    onScrollAnimation();
  }

  void onStartVoiceAnimation() async {
    audioRoomModel?.timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        for (int i = 0; i < (audioRoomModel?.reactions.length ?? 0); i++) {
          final index = audioRoomModel?.reactions[i];

          if (index != null && index.time < DateTime.now().second) {
            audioRoomModel?.reactions[i] = null;
            update([AppConstant.onSeatUpdate]);
            Utils.showLog("Reaction Removed Position=> $i");
          }
        }
      },
    );
  }

  Future<void> onDispose() async {
    try {
      await audioRoomModel?.engine?.leaveChannel();
      await audioRoomModel?.engine?.release();
      onEndAudioRoomSocket();
    } catch (e) {
      Utils.showLog("Dispose Failed => $e");
    }
  }

  Future<void> onScrollAnimation() async {
    try {
      await 50.milliseconds.delay();
      audioRoomModel?.scrollController.jumpTo(audioRoomModel?.scrollController.position.maxScrollExtent ?? 0);
      update([AppConstant.onChangeComment]);
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  void onChangeCommentTab(int index) {
    selectedTabIndex = index;
    update([AppConstant.onChangeCommentTab]);
  }

  void onChangeTextField(bool value) {
    isShowTextField = value;
    update([AppConstant.onChangeTextField]);
  }

  void onClickSeat({required BuildContext context, required int position}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    bool isHostOnSeat = audioRoomModel?.audioRoomSeats.any((element) => element.userId == audioRoomModel?.hostUserId) ?? false;

    Utils.showLog("Is Host On Seat => $isHostOnSeat");
    Utils.showLog("Click Seat Position => $position");

    if (audioRoomModel?.isHost == true) {
      Utils.showLog("Click User Is Host");
      if (audioRoomModel?.audioRoomSeats[position].userId == null && audioRoomModel?.audioRoomSeats[position].lock == true) {
        Utils.showLog("Host Click Lock Seat");

        AudioRoomBlankSeatBottomSheetWidget.show(position);
      } else if (audioRoomModel?.audioRoomSeats[position].userId == null) {
        Utils.showLog("Host Click Empty Seat");

        AudioRoomBlankSeatBottomSheetWidget.show(position);
      } else if (audioRoomModel?.audioRoomSeats[position].userId == Database.loginUserId) {
        Utils.showLog("Host Click Own Seat");

        StandUpSeatDialogWidget.onShow(
          callBack: () {
            Get.back();
            onChangePosition(position: position);
          },
        );
      } else {
        Utils.showLog("Host Click User Seat => ${audioRoomModel?.audioRoomSeats[position].name}");

        AudioRoomSeatUserBottomSheetWidget.onShow(position: position);
      }
    } else {
      Utils.showLog("Click User Is Not Host");
      if (audioRoomModel?.audioRoomSeats[position].lock == true) {
        Utils.showLog("User Click Lock Seat");
        Utils.showToast(text: EnumLocal.txtSeatIsLockedByAdmin.name.tr);
      } else if (audioRoomModel?.audioRoomSeats[position].userId == null || audioRoomModel?.audioRoomSeats[position].userId == Database.loginUserId) {
        bool isBloc = audioRoomModel?.blockUsers.any((element) => element.blockedUserId?.id == Database.loginUserId) ?? false;
        if (isBloc == false) {
          if (audioRoomModel?.selectedSeat == position) {
            StandUpSeatDialogWidget.onShow(
              callBack: () {
                Get.back();
                onChangePosition(position: position);
              },
            );
          } else {
            if (audioRoomModel?.isAbleForSeatChange == true) {
              audioRoomModel?.isAbleForSeatChange = false;
              onChangePosition(position: position);
              Timer(Duration(seconds: 2), () => audioRoomModel?.isAbleForSeatChange = true);
            }
          }
        } else {
          Utils.showToast(text: EnumLocal.txtYouAreBlockedByAdmin.name.tr);
        }
      } else {
        Utils.showLog("User Click Other User Seat => $position");
        if (Database.loginUserId != audioRoomModel?.audioRoomSeats[position].userId) {
          OtherUserProfileBottomSheet.show(context: context, userID: audioRoomModel?.audioRoomSeats[position].userId ?? "");
        }
      }
    }
  }

  void onToggleLockSeat(int position) async {
    audioRoomModel?.loadingSeatIndex = position;
    update([AppConstant.onUpdateParticularSeat]);
    Get.back();
    if (audioRoomModel?.audioRoomSeats[position].lock == true) {
      onSeatLockedSocket(position: position, isLock: false);
    } else {
      onSeatLockedSocket(position: position, isLock: true);
    }
  }

  void onUnBlocUser(int index) async {
    onRemoveFromBlockedListSocket(userId: audioRoomModel?.blockUsers[index].blockedUserId?.id ?? "");
    audioRoomModel?.blockUsers.removeAt(index);
    update([AppConstant.onChangeUserBlockList]);
  }

  Future<void> onChangePosition({required int position}) async {
    audioRoomModel?.loadingSeatIndex = position;
    update([AppConstant.onUpdateParticularSeat]);

    int lastPosition = audioRoomModel?.selectedSeat ?? 0;
    audioRoomModel?.selectedSeat = audioRoomModel?.selectedSeat == position ? null : position;

    Utils.showLog("On Change Seat Position => Last => $lastPosition Current => ${audioRoomModel?.selectedSeat}");

    if (audioRoomModel?.selectedSeat != null) {
      if (audioRoomModel?.mute != 3) {
        audioRoomModel?.mute = 0;
      }
      onParticipantAddedSocket(audioRoomModel?.selectedSeat ?? 0);
      await audioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await audioRoomModel?.engine?.muteLocalAudioStream(true);
    } else {
      onParticipantRemoveSocket(position: lastPosition, userId: audioRoomModel?.audioRoomSeats[lastPosition].userId ?? "");
      await audioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleAudience);
      await audioRoomModel?.engine?.muteLocalAudioStream(true);
    }
    update([AppConstant.onSeatUpdate]);
  }

  void onUpdateMic() async {
    bool available = audioRoomModel?.audioRoomSeats.any((element) => element.userId == Database.loginUserId) ?? false;

    // MUTE => 0.NONE 1.MUTE 2.UN_MUTE 3.MUTE_BY_HOST_TO_USER

    if (audioRoomModel?.selectedSeat != null && available) {
      // Current My Mic Not Muted By Admin && Future Admin Mute My Mic
      if (audioRoomModel?.mute != 3 && audioRoomModel?.audioRoomSeats[audioRoomModel?.selectedSeat ?? 0].mute == 3) {
        audioRoomModel?.mute = 3; // Mute By Admin

        update([AppConstant.onSwitchMic]);

        await audioRoomModel?.engine?.muteLocalAudioStream(true);

        // Current My Mic Muted By Admin && Future Admin UnMute My Mic
      } else if (audioRoomModel?.mute == 3 && audioRoomModel?.audioRoomSeats[audioRoomModel?.selectedSeat ?? 0].mute != 3) {
        audioRoomModel?.mute = 1; // Simple Mute Mic (But Not Mute By Admin)

        update([AppConstant.onSwitchMic]);

        await audioRoomModel?.engine?.muteLocalAudioStream(true);
      }
    }

    Utils.showLog("IsAvailable $available => ${audioRoomModel?.mute}");

    if (available == false) {
      audioRoomModel?.selectedSeat = null;
      await audioRoomModel?.engine?.muteLocalAudioStream(true);
      await audioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleAudience);
      Utils.showLog("Admin Kick Out Me => ${audioRoomModel?.mute}");
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SOCKET LISTEN <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  void onSeatUserUpdateSocket(List<AudioRoomSeatUsersModel> value) async {
    audioRoomModel?.seatUsers = value;

    update([AppConstant.onSeatUserUpdate]);

    Utils.showLog("Current Total Seat User => ${audioRoomModel?.seatUsers.length}");
  }

  void onLiveViewerUserUpdateSocket(List<LiveViewerUserModel> value) async {
    audioRoomModel?.liveViewers = value;
    update([AppConstant.onChangeViewCount]);
    Utils.showLog("Current Total Viewer => ${audioRoomModel?.liveViewers.length}");
  }

  void onSeatUpdateSocket(List<Seat> value) async {
    audioRoomModel?.audioRoomSeats = value;
    liveUserList?.seat = value;
    audioRoomModel?.loadingSeatIndex = null;
    onUpdateMic(); // This Method Working Only If Admin Change My Mic...
    update([AppConstant.onSeatUpdate, AppConstant.onUpdateParticularSeat, AppConstant.onSwitchMic]);
    if (value.length != audioRoomModel?.reactions.length) onInitReaction();
  }

  void onGetInviteRequestSocket({required String name, required String image, required bool isMediaBanned, required int position}) {
    AudioRoomSeatRequestDialogWidget.onShow(
      name: name,
      image: image,
      isMediaBanned: isMediaBanned,
      position: position,
      onAccept: () async {
        Get.back();
        audioRoomModel?.mute = 0;
        onParticipantAddedSocket(position);
        audioRoomModel?.selectedSeat = position;
        await audioRoomModel?.engine?.muteLocalAudioStream(true);
        await audioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      },
      onDecline: () {
        Get.back();
        onAudioRoomInviteRevokedSocket(position);
      },
    );
  }

  void onChangeViewCountSocket(int value) {
    audioRoomModel?.viewCount = value;
    update([AppConstant.onChangeViewCount]);
  }

  void onChangeUserBlockList(List<BlockedUsers> value) async {
    audioRoomModel?.blockUsers = value;
    update([AppConstant.onChangeUserBlockList]);
  }

  void onBlockedByAdmin() async {
    Utils.showToast(text: EnumLocal.txtYouAreBlockedByAdmin.name.tr);
    audioRoomModel?.selectedSeat = null;

    audioRoomModel?.mute = 0;
    update([AppConstant.onSwitchMic]);
    await audioRoomModel?.engine?.muteLocalAudioStream(true);
    Get.back();
  }

  void onGetComment({required LiveCommentModel comment}) {
    audioRoomModel?.liveComments.add(comment);
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  void onDefaultComment() {
    audioRoomModel?.liveComments.addAll(
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
          userId: "",
          commentText: "",
          isBanned: false,
        ),
      ],
    );
    onScrollAnimation();
    update([AppConstant.onChangeComment]);
  }

  Future<void> onListenEmojiSocket(dynamic data) async {
    if (data[SocketParams.position] != null) {
      audioRoomModel?.reactions[data[SocketParams.position]] = ReactionModel(
        position: data[SocketParams.position],
        image: data[SocketParams.image],
        senderName: data[SocketParams.senderName],
        senderImage: data[SocketParams.senderImage],
        senderProfilePicBanned: data[SocketParams.senderProfilePicBanned],
        time: data[SocketParams.time],
      );

      update([AppConstant.onSeatUpdate]);
    } else {
      audioRoomModel?.liveComments.add(
        LiveCommentModel(
          type: 4,
          name: data[SocketParams.senderName],
          userId: "",
          image: "",
          commentText: "",
          isBanned: false,
          emoji: data[SocketParams.image],
        ),
      );
      onScrollAnimation();
      update([AppConstant.onChangeComment]);
    }
  }

  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SOCKET EMIT <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  Future<void> onSendEmojiSocket({int? position, required String image}) async {
    SocketEmit.onBroadcastReaction(
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      position: position,
      image: image,
      senderName: Database.fetchLoginUserProfile()?.user?.name ?? "",
      senderImage: Database.fetchLoginUserProfile()?.user?.image ?? "",
      senderProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
      time: DateTime.now().add(Duration(seconds: 5)).second,
    );
  }

  Future<void> onSendComment() async {
    if (audioRoomModel?.commentController.text.trim().isNotEmpty ?? false) {
      SocketEmit.onBroadcastLiveComment(
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
        senderUserId: Database.fetchLoginUserProfile()?.user?.id ?? "",
        senderName: Database.fetchLoginUserProfile()?.user?.name ?? "",
        senderImage: Database.fetchLoginUserProfile()?.user?.image ?? "",
        senderProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
        commentText: audioRoomModel?.commentController.text.trim() ?? "",
        isBattleActive: false,
      );
      audioRoomModel?.commentController.clear();
      update([AppConstant.onChangeComment]);
    }
  }

  void onJoinAudioRoomSocket() async {
    if (audioRoomModel?.isHost == true) {
      SocketEmit.onJoinLiveRoom(
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      );

      SocketEmit.onHostJoinAudioRoom(
        userId: audioRoomModel?.hostUserId ?? "",
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      );
    } else {
      SocketEmit.onCountLiveJoin(
        userId: Database.loginUserId,
        entryRide: Database.fetchLoginUserProfile()?.user?.activeRide?.image ?? "",
        entryRideType: Database.fetchLoginUserProfile()?.user?.activeRide?.type ?? 0,
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
        liveType: 2, // Audio Live
      );
    }
  }

  void onEndAudioRoomSocket() async {
    if (audioRoomModel?.isHost == true) {
      SocketEmit.onEndLiveStream(
        userId: Database.loginUserId,
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      );

      // SocketEmit.onHostLeaveAudioRoom(
      //   userId: audioRoomModel?.hostUserId ?? "",
      //   liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      // );

      // Gujarati => Jya re audio room background ma thai tya re end mate stream_pk_item_widget.dart.dart event (onHostLeaveAudioRoom) no thai tya shu dhi stream_pk_item_widget.dart.dart event (onEndLiveStream)
    } else {
      if (audioRoomModel?.selectedSeat != null) {
        onParticipantRemoveSocket(position: audioRoomModel?.selectedSeat ?? 0, userId: Database.loginUserId);
      }

      SocketEmit.onReduceLiveJoiners(
        userId: Database.loginUserId,
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      );
    }
  }

  void onParticipantAddedSocket(int position) {
    SocketEmit.onParticipantAdded(
      userId: Database.loginUserId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      liveUserObjId: audioRoomModel?.liveUserObjId ?? "",
      position: position,
      name: Database.fetchLoginUserProfile()?.user?.name ?? "",
      image: Database.fetchLoginUserProfile()?.user?.image ?? "",
      avtarFrameType: Database.fetchLoginUserProfile()?.user?.activeAvtarFrame?.type ?? 0,
      avtarFrame: Database.fetchLoginUserProfile()?.user?.activeAvtarFrame?.image ?? "",
      agoraUid: audioRoomModel?.userUid ?? 0,
      mute: audioRoomModel?.audioRoomSeats[position].mute == 3 ? 3 : (audioRoomModel?.mute ?? 0), // If Admin Already Muted Seat Then Set My Mic Type => Mute
      coin: FetchUserCoin.coin.value,
    );
  }

  void onParticipantRemoveSocket({
    required int position,
    required String userId,
  }) {
    SocketEmit.onParticipantRemoved(
      userId: userId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      liveUserObjId: audioRoomModel?.liveUserObjId ?? "",
      position: position,
    );
  }

  void onAudioRoomInviteRevokedSocket(int position) {
    SocketEmit.onAudioRoomInviteRevoked(
      userId: Database.loginUserId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      liveUserObjId: audioRoomModel?.liveUserObjId ?? "",
      position: position,
    );
  }

  void onRequestToJoinAudioRoomSocket({
    required int position,
    required String userId,
  }) {
    SocketEmit.onRequestToJoinAudioRoom(
      userId: userId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      liveUserObjId: audioRoomModel?.liveUserObjId ?? "",
      position: position,
      name: Database.fetchLoginUserProfile()?.user?.name ?? "",
      image: Database.fetchLoginUserProfile()?.user?.image ?? "",
      isMediaBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
    );
  }

  void onSeatLockedSocket({required int position, required bool isLock}) {
    SocketEmit.onSeatLocked(
      userId: Database.loginUserId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      liveUserObjId: audioRoomModel?.liveUserObjId ?? "",
      position: position,
      lock: isLock,
    );
  }

  void onSeatMutedSocket({required int position, required int mute, required String userId}) {
    SocketEmit.onSeatMuted(
      userId: userId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      liveUserObjId: audioRoomModel?.liveUserObjId ?? "",
      position: position,
      mute: mute,
    );
  }

  void onSeatCountModifiedSocket({required int seatCount}) {
    if (audioRoomModel?.isHost == true) {
      audioRoomModel?.seatLength = seatCount;
      SocketEmit.onSeatCountModified(
        liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
        seatCount: seatCount,
      );
      update([AppConstant.onSeatUpdate]);
    }
  }

  void onAddToBlockedListSocket({required String userId}) {
    SocketEmit.onAddToBlockedList(
      blockedUserId: userId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
    );
  }

  void onRemoveFromBlockedListSocket({required String userId}) {
    SocketEmit.onRemoveFromBlockedList(
      unblockedUserId: userId,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
    );
  }

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> AGORA EVENT <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  Future<void> onCreateEngine() async {
    try {
      audioRoomModel?.engine = createAgoraRtcEngine();
      await audioRoomModel?.engine?.initialize(
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

      await audioRoomModel?.engine?.joinChannel(
        uid: audioRoomModel?.isHost == true ? (audioRoomModel?.hostUid ?? 0) : (audioRoomModel?.userUid ?? 0),
        token: audioRoomModel?.token ?? "",
        channelId: audioRoomModel?.channel ?? "",
        options: ChannelMediaOptions(),
      );

      await audioRoomModel?.engine?.enableAudio();
      await audioRoomModel?.engine?.setClientRole(role: ClientRoleType.clientRoleAudience);
    } catch (e) {
      Utils.showLog("Event Handler => Join Channel Failed => $e");
    }
  }

  Future<void> onEventHandler() async {
    audioRoomModel?.engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          Utils.showLog("Event Handler => Host Join Success => ChannelId => ${connection.channelId} LocalUid => ${connection.localUid}");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          Utils.showLog("Event Handler => User Join Success => ChannelId => ${connection.channelId} LocalUid => ${connection.localUid} RemoteUid => $remoteUid");
          update([AppConstant.onEventHandler]);
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          Utils.showLog("Event Handler => User Leave Channel Success");
        },
        onLocalAudioStateChanged: (connection, state, reason) {
          Utils.showLog("onLocalAudioStateChanged ${connection.localUid}**** ${state} -------${reason}");
        },
        onError: (e, message) {
          Utils.showLog("Event Handler => Join Channel Failed => $e");
        },
      ),
    );
  }

  Future<void> onSwitchMic() async {
    try {
      AppPermission.onGetMicrophonePermission(
        onGranted: () async {
          if (audioRoomModel?.selectedSeat != null) {
            Utils.showLog("My Current Mute => ${audioRoomModel?.audioRoomSeats[audioRoomModel?.selectedSeat ?? 0].mute}");

            if (audioRoomModel?.mute != 3) {
              if (audioRoomModel?.mute == 1 || audioRoomModel?.mute == 0) {
                audioRoomModel?.mute = 2;
                update([AppConstant.onSwitchMic]);
                onSeatMutedSocket(position: audioRoomModel?.selectedSeat ?? 0, mute: 2, userId: Database.loginUserId);
                await audioRoomModel?.engine?.muteLocalAudioStream(false);
              } else {
                audioRoomModel?.mute = 1;
                update([AppConstant.onSwitchMic]);
                onSeatMutedSocket(position: audioRoomModel?.selectedSeat ?? 0, mute: 1, userId: Database.loginUserId);
                await audioRoomModel?.engine?.muteLocalAudioStream(true);
              }
            } else {
              Utils.showToast(text: EnumLocal.txtYouAreMuteByAdmin.name.tr);
            }
          } else {
            Utils.showToast(text: EnumLocal.txtYouAreNotOnSeat.name.tr);
          }
          Utils.showLog("My Change After Mute => ${audioRoomModel?.mute}");
        },
      );
    } catch (e) {
      Utils.showLog("Event Handler => Switch Mic Failed => $e");
    }
  }

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FETCH BLOCKED USER LIST <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  Future<void> onFetchBlockUser() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    await FetchAudioRoomBlocUserApi.callApi(token: token, uid: uid, liveHistoryId: audioRoomModel?.liveHistoryId ?? "");
    audioRoomModel?.blockUsers = FetchAudioRoomBlocUserApi.fetchAudioRoomBlocUserModel?.blockedUsers ?? [];
    update([AppConstant.onChangeUserBlockList]);
  }

  Future<void> onEditAudioRoom({required String roomName, required String roomWelcome, required String roomImage, required String privateCode}) async {
    CreateLiveUserModel? createLiveUserModel;

    FocusManager.instance.primaryFocus?.unfocus();

    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    createLiveUserModel = await EditAudioRoomApi.callApi(
      token: token,
      uid: uid,
      liveHistoryId: audioRoomModel?.liveHistoryId ?? "",
      roomName: roomName,
      roomWelcome: roomWelcome,
      roomImage: roomImage,
      privateCode: privateCode,
    );

    if (createLiveUserModel?.status == true) {
      Utils.showToast(text: createLiveUserModel?.message ?? "");

      audioRoomModel?.roomName = createLiveUserModel?.data?.roomName ?? "";
      audioRoomModel?.roomWelcome = createLiveUserModel?.data?.roomWelcome ?? "";
      audioRoomModel?.roomImage = createLiveUserModel?.data?.roomImage ?? "";
      audioRoomModel?.privateCode = createLiveUserModel?.data?.privateCode ?? 0;

      Get.back(); // Close Bottom Sheet..
    }

    Get.back(); // Stop Loading...
  }

  void onChangeTheme({required String bgTheme}) async {
    audioRoomModel?.bgTheme = bgTheme;
    update([AppConstant.onChangeTheme]);
  }

  void onUpdateCoin({required int coin}) async {
    audioRoomModel?.audioRoomEarnedCoin = coin;
    update([AppConstant.onUpdateCoin]);
  }

  void onUpdateTopGiftUser({required List<LiveTopGiftUserModel> value}) async {
    audioRoomModel?.liveTopGiftUsers = value;
    update([AppConstant.onUpdateTopGiftUser]);
    Utils.showLog("Top Live User List Length => ${audioRoomModel?.liveTopGiftUsers.length}");
  }
}
