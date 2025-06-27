import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/show_entry_ride.dart';
import 'package:tingle/common/function/show_received_banner.dart';
import 'package:tingle/common/function/show_received_gift.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_seat_users_model.dart';
import 'package:tingle/page/audio_room_page/model/fetch_audio_room_bloc_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_top_gift_user_model.dart';
import 'package:tingle/page/audio_room_page/model/live_viewer_user_model.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_gift_bottom_sheet_widget.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/page/live_page/model/live_comment_model.dart';
import 'package:tingle/page/live_page/model/pk_gift_top_user_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/page/video_call_page/controller/video_call_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/socket/socket_emit.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

class SocketListen {
  static Future<void> onHighCoinWinBroadcast(dynamic data) async {
    if (data != null) {
      ShowReceivedBanner.onGetNewBanner(
        BannerModel(
          isGiftBanner: false,

          // Gift Parameter

          giftType: 0,
          giftUrl: "",
          giftCount: 0,
          giftCoin: 0,
          senderName: "",
          senderImage: "",
          senderUniqueId: "",
          senderProfilePicBanned: false,
          receiverName: "",
          liveUserList: LiveUserList(),
          liveType: 0,

          // Game Parameter
          message: data[SocketParams.message],
          image: data[SocketParams.userImage],
        ),
      );
    }
  }

  static Future<void> onProHighValueGift(dynamic data) async {
    if (data != null) {
      final response = jsonDecode(data);

      ShowReceivedBanner.onGetNewBanner(
        BannerModel(
          isGiftBanner: true,
          giftType: response[SocketParams.giftType] ?? 0,
          giftUrl: response[SocketParams.giftUrl] ?? "",
          giftCount: response[SocketParams.giftCount] ?? 0,
          giftCoin: response[SocketParams.giftCoin] ?? 0,
          senderName: response[SocketParams.senderName] ?? "",
          senderImage: response[SocketParams.senderImage] ?? "",
          senderUniqueId: response[SocketParams.senderUniqueId] ?? "",
          senderProfilePicBanned: response[SocketParams.senderProfilePicBanned] ?? false,
          receiverName: response[SocketParams.receiverName] ?? "",
          liveUserList: LiveUserList.fromJson(response[SocketParams.liveUserList] ?? {}),
          liveType: response[SocketParams.liveType] ?? 0,
          message: "",
          image: "",
        ),
      );
    }
  }

  static Future<void> onFireEntryEffect(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage || Get.currentRoute == AppRoutes.livePage) {
      ShowEntryRide.onGetNewRide(
        EntryRideModel(
          entryRide: data[SocketParams.entryRide],
          entryRideType: data[SocketParams.entryRideType],
        ),
      );
    }
  }

  static Future<void> onPkGift(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();

      ShowReceivedGift.onGetNewGift(
        GiftModel(
          giftType: data[SocketParams.giftData][SocketParams.giftType],
          giftUrl: data[SocketParams.giftData][SocketParams.giftUrl],
          giftCount: data[SocketParams.giftData][SocketParams.giftCount],
          senderName: data[SocketParams.giftData][SocketParams.senderName],
          senderImage: data[SocketParams.giftData][SocketParams.senderImage],
          senderUniqueId: data[SocketParams.giftData][SocketParams.senderUniqueId],
          senderProfilePicBanned: data[SocketParams.giftData][SocketParams.senderProfilePicBanned],
          receiverName: "",
        ),
      );

      controller.onChangeRank(
        host1Rank: data[SocketParams.response][SocketParams.pkConfig][SocketParams.localRank],
        host2Rank: data[SocketParams.response][SocketParams.pkConfig][SocketParams.remoteRank],
      );
    }
  }

  static Future<void> onPkRankUpdate(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();

      controller.onChangeRank(
        host1Rank: data[SocketParams.pkConfig][SocketParams.localRank],
        host2Rank: data[SocketParams.pkConfig][SocketParams.remoteRank],
        time: data[SocketParams.duration],
      );
    }
  }

  static Future<void> onPkEnd(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      controller.onListenPkEnd(data);
    }
  }

  static Future<void> onUpdateHostGifterStats(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();

      List<dynamic> topGiftersHost1 = data[SocketParams.topGiftersHost1];
      List<dynamic> topGiftersHost2 = data[SocketParams.topGiftersHost2];

      List<PkGiftTopUserModel> host1 = topGiftersHost1.map((json) => PkGiftTopUserModel.fromJson(json)).toList();
      List<PkGiftTopUserModel> host2 = topGiftersHost2.map((json) => PkGiftTopUserModel.fromJson(json)).toList();

      controller.onChangeTopGiftUser(host1: host1, host2: host2);
    }
  }

  static Future<void> onTopGiftersUpdate(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      final liveHistoryId = data[SocketParams.liveHistoryId];
      List<dynamic> response = data[SocketParams.topGifters];
      List<PkGiftTopUserModel> users = response.map((json) => PkGiftTopUserModel.fromJson(json)).toList();
      controller.onUpdateTopGiftUser(users: users, liveHistoryId: liveHistoryId);
    }
  }

  static Future<void> onPkAnswer(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      controller.onListenPkAnswer(data);
    }
  }

  static Future<void> onPkRequestReceived(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      controller.onPkRequestReceived(data);
    }
  }

  static Future<void> onGiftInAudioRoom(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final List<dynamic> receiveUsersDetailsJson = data[SocketParams.giftData][SocketParams.receiveUsersDetails];

      final List<ReceiverUserModel> receiveUsersDetails = receiveUsersDetailsJson.map((userJson) => ReceiverUserModel.fromJson(userJson as Map<String, dynamic>)).toList();

      ShowReceivedGift.onGetNewGift(
        GiftModel(
          giftType: data[SocketParams.giftData][SocketParams.giftType],
          giftUrl: data[SocketParams.giftData][SocketParams.giftUrl],
          giftCount: data[SocketParams.giftData][SocketParams.giftCount],
          senderName: data[SocketParams.giftData][SocketParams.senderName],
          senderImage: data[SocketParams.giftData][SocketParams.senderImage],
          senderUniqueId: data[SocketParams.giftData][SocketParams.senderUniqueId],
          senderProfilePicBanned: data[SocketParams.giftData][SocketParams.senderProfilePicBanned],
          receiverName: receiveUsersDetails.isNotEmpty
              ? receiveUsersDetails.length == 1
                  ? receiveUsersDetails.first.name
                  : "Multiple Users"
              : "",
        ),
      );
    }
  }

  static Future<void> onBgTheme(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onChangeTheme(bgTheme: data[SocketParams.bgTheme]);
    }
  }

  static Future<void> onLiveRoomCoinUpdate(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onUpdateCoin(coin: data);
    } else if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      controller.onUpdateCoin(coin: data);
    }
  }

  static Future<void> onTopLiveStreamGifter(dynamic data) async {
    List<dynamic> response = data;
    List<LiveTopGiftUserModel> listData = response.map((json) => LiveTopGiftUserModel.fromJson(json)).toList();

    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();

      controller.onUpdateTopGiftUser(value: listData);
    } else if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      controller.onChangeTopLiveGiftUser(value: listData);
    }
  }

  static Future<void> onBroadcastReaction(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onListenEmojiSocket(data);
    }
  }

  static Future<void> onSeatedUsersUpdate(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      List<dynamic> response = data;
      List<AudioRoomSeatUsersModel> seatUsers = response.map((json) => AudioRoomSeatUsersModel.fromJson(json)).toList();
      controller.onSeatUserUpdateSocket(seatUsers);
    }
  }

  static Future<void> onLiveViewersList(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      List<dynamic> response = data;
      List<LiveViewerUserModel> liveViewers = response.map((json) => LiveViewerUserModel.fromJson(json)).toList();
      controller.onLiveViewerUserUpdateSocket(liveViewers);
    } else if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      List<dynamic> response = data;
      List<LiveViewerUserModel> liveViewers = response.map((json) => LiveViewerUserModel.fromJson(json)).toList();
      controller.onLiveViewerUserUpdateSocket(liveViewers);
    }
  }

  static Future<void> onNotifyBlockedUser(dynamic data) async {
    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onBlockedByAdmin();
    }
  }

  static Future<void> onInviteToJoinRoom(dynamic data) async {
    final json = jsonDecode(data[SocketParams.data]);

    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onGetInviteRequestSocket(
        name: json[SocketParams.name],
        position: json[SocketParams.position],
        image: json[SocketParams.image],
        isMediaBanned: json[SocketParams.isMediaBanned],
      );
    }
  }

  static Future<void> onSeatUpdate(dynamic data) async {
    if (data != null) {
      List<dynamic> seatJson = data[SocketParams.seat];
      List<Seat> seatList = seatJson.map((element) => Seat.fromJson(element)).toList();

      if (Get.currentRoute == AppRoutes.audioRoomPage) {
        final controller = Get.find<AudioRoomController>();

        controller.audioRoomModel?.roomName = data[ApiParams.roomName];
        controller.audioRoomModel?.roomWelcome = data[ApiParams.roomWelcome];
        controller.audioRoomModel?.roomImage = data[ApiParams.roomImage];

        controller.onSeatUpdateSocket(seatList);
      }
    }
  }

  static Future<void> onChangeUserBlockList(dynamic data) async {
    List<dynamic> jsonData = data;
    List<BlockedUsers> blocList = jsonData.map((element) => BlockedUsers.fromJson(element)).toList();

    if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onChangeUserBlockList(blocList);
    }
  }

  //************************************************************************************************************************

  static Future<void> onFetchLiveGifts(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      ShowReceivedGift.onGetNewGift(
        GiftModel(
          giftType: data[SocketParams.giftType],
          giftUrl: data[SocketParams.giftUrl],
          giftCount: data[SocketParams.giftCount],
          senderName: data[SocketParams.senderName],
          senderImage: data[SocketParams.senderImage],
          senderUniqueId: data[SocketParams.senderUniqueId],
          senderProfilePicBanned: data[SocketParams.senderProfilePicBanned],
          receiverName: "",
        ),
      );
    }
  }

  static Future<void> onLuckyGiftWin(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage || Get.currentRoute == AppRoutes.audioRoomPage) {
      ShowReceivedGift.onGetLuckyWinCoin(coin: data);
      // Utils.showToast(text: "${EnumLocal.txtYouWinLuckyGift.name.tr} $data ${EnumLocal.txtCoins.name.tr.toLowerCase()}");
    }
  }

  static Future<void> onChangeViewCount(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();
      controller.onChangeViewCount(data);
    } else if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();
      controller.onChangeViewCountSocket(data);
    }
  }

  static Future<void> onBroadcastLiveComment(dynamic data) async {
    Map<String, dynamic> response = jsonDecode(data);
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();

      controller.onGetComment(
        comment: LiveCommentModel(
          type: 1,
          name: response[SocketParams.senderName],
          image: response[SocketParams.senderImage],
          commentText: response[SocketParams.commentText],
          isBanned: response[SocketParams.senderProfilePicBanned],
          userId: response[SocketParams.senderUserId],
        ),
      );
    } else if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();

      controller.onGetComment(
        comment: LiveCommentModel(
          type: 1,
          name: response[SocketParams.senderName],
          image: response[SocketParams.senderImage],
          commentText: response[SocketParams.commentText],
          isBanned: response[SocketParams.senderProfilePicBanned],
          userId: response[SocketParams.senderUserId],
        ),
      );
    }
  }

  static Future<void> onEndLiveStream(dynamic data) async {
    if (Get.currentRoute == AppRoutes.livePage || Get.currentRoute == AppRoutes.audioRoomPage) {
      Get.back();

      if (Get.currentRoute == AppRoutes.livePage || Get.currentRoute == AppRoutes.audioRoomPage) Get.back();
    }
  }

  //************************************************************************************************************************

  static Future<void> onCallStarted(dynamic data) async {
    if (Get.currentRoute == AppRoutes.chatPage && Get.isRegistered<ChatController>()) {
      Get.toNamed(
        AppRoutes.videoCallRingingPage,
        arguments: {
          SocketParams.callerId: data[SocketParams.callerId],
          SocketParams.receiverId: data[SocketParams.receiverId],
          SocketParams.callId: data[SocketParams.callId],
          SocketParams.receiverName: data[SocketParams.receiverName],
          SocketParams.receiverImage: data[SocketParams.receiverImage],
        },
      )?.then(
        (value) => Utils.onChangeStatusBar(brightness: Brightness.dark),
      );
    }
  }

  static Future<void> onIncomingCall(dynamic data) async {
    Get.toNamed(
      AppRoutes.incomingVideoCallPage,
      arguments: {
        SocketParams.callId: data[SocketParams.callId],
        SocketParams.callerId: data[SocketParams.callerId],
        SocketParams.callerName: data[SocketParams.callerName],
        SocketParams.callerImage: data[SocketParams.callerImage],
        SocketParams.receiverId: data[SocketParams.receiverId],
        SocketParams.receiverName: data[SocketParams.receiverName],
        SocketParams.receiverImage: data[SocketParams.receiverImage],
        SocketParams.token: data[SocketParams.token],
        SocketParams.channel: data[SocketParams.channel],
      },
    );
  }

  static Future<void> onInitiateCall(dynamic data) async {
    if (data[SocketParams.isOnline] == false) {
      Utils.showToast(text: data[SocketParams.message]);
    }
    if (data[SocketParams.isBusy] != null && data[SocketParams.isBusy] == true && data[SocketParams.message] != null) {
      Utils.showToast(text: data[SocketParams.message]);
      //  Utils.showToast(text:"Receiver is busy with someone else");
    }
  }

  static Future<void> onCallEnded(dynamic data) async {
    if (Get.currentRoute == AppRoutes.incomingVideoCallPage || Get.currentRoute == AppRoutes.videoCallRingingPage || Get.currentRoute == AppRoutes.videoCallPage) {
      Get.back();
    }
  }

  static Future<void> onCallRejectedByReceiver(dynamic data) async {
    final Map jsonResponse = jsonDecode(data);
    if (Get.currentRoute == AppRoutes.videoCallRingingPage) {
      Get.back();
      if (jsonResponse.containsKey(SocketParams.receiverName)) Utils.showToast(text: "${jsonResponse[SocketParams.receiverName]} ${EnumLocal.txtIsCurrentlyUnavailable.name.tr}");
    }
  }

  static Future<void> onInsufficientCoins(dynamic data) async {
    if (Get.currentRoute == AppRoutes.videoCallPage && Get.isRegistered<VideoCallController>()) {
      final controller = Get.find<VideoCallController>();
      if (controller.callerId == Database.loginUserId) {
        controller.onClickCallCut();
      }
    }
  }

  static Future<void> callAcceptedByReceiver(dynamic data) async {
    Map<String, dynamic> response = jsonDecode(data);

    if (Get.currentRoute == AppRoutes.videoCallRingingPage || Get.currentRoute == AppRoutes.incomingVideoCallPage) {
      Get.back();
    }

    Get.toNamed(
      AppRoutes.videoCallPage,
      arguments: {
        SocketParams.callId: response[SocketParams.callId],
        SocketParams.callerId: response[SocketParams.callerId],
        SocketParams.callerName: response[SocketParams.callerName],
        SocketParams.callerImage: response[SocketParams.callerImage],
        SocketParams.receiverId: response[SocketParams.receiverId],
        SocketParams.receiverName: response[SocketParams.receiverName],
        SocketParams.receiverImage: response[SocketParams.receiverImage],
        SocketParams.token: response[SocketParams.token],
        SocketParams.channel: response[SocketParams.channel],
      },
    )?.then(
      (value) {
        if (Get.currentRoute == AppRoutes.chatPage) Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 100);
      },
    );
  }

  //************************************************************************************************************************

  static Future<void> onMessageSent(dynamic data) async {
    Map<String, dynamic> response = jsonDecode(data[SocketParams.data]);

    response.addAll({SocketParams.messageId: data[SocketParams.messageId]});

    if (Get.currentRoute == AppRoutes.chatPage && Get.isRegistered<ChatController>()) {
      final controller = Get.find<ChatController>();

      controller.onGetMessageFromSocket(message: response);
    }
  }

  static Future<void> onConnect() async {
    if (Get.currentRoute == AppRoutes.livePage) {
      final controller = Get.find<LiveController>();

      await 10.seconds.delay();

      SocketEmit.onJoinLiveRoom(liveHistoryId: controller.liveModel?.host1LiveHistoryId ?? "");

      Utils.showLog("Reconnect Live Steaming...");
    } else if (Get.currentRoute == AppRoutes.audioRoomPage) {
      final controller = Get.find<AudioRoomController>();

      await 10.seconds.delay();

      SocketEmit.onJoinLiveRoom(liveHistoryId: controller.audioRoomModel?.liveHistoryId ?? "");

      Utils.showLog("Reconnect Live Steaming...");
    }
  }
}
