import 'dart:convert';
import 'package:tingle/page/audio_room_page/widget/audio_room_gift_bottom_sheet_widget.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/socket/socket_services.dart';
import 'package:tingle/utils/socket_events.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';

class SocketEmit {
  static Future<void> onPkAnswer({
    required bool isAccept,
    required String HOST_1_ID,
    required int HOST_1_AGORA_ID,
    required String HOST_1_CHANNEL,
    required String HOST_1_LIVEID,
    required String HOST_1_TOKEN,
    required String HOST_1_NAME,
    required String HOST_1_USERNAME,
    required String HOST_1_IMAGE,
    required bool HOST_1_PROFILEPICISBANNED,
    required String HOST_1_UNIQUEID,
    required String HOST_1_WEALTHLEVEL_IMAGE,
    required String HOST_2_ID,
    required int HOST_2_AGORA_ID,
    required String HOST_2_CHANNEL,
    required String HOST_2_LIVEID,
    required String HOST_2_TOKEN,
    required String HOST_2_NAME,
    required String HOST_2_USERNAME,
    required String HOST_2_IMAGE,
    required bool HOST_2_PROFILEPICISBANNED,
    required String HOST_2_UNIQUEID,
    required String HOST_2_WEALTHLEVEL_IMAGE,
  }) async {
    final pkRequest = jsonEncode(
      {
        SocketParams.isAccept: isAccept,
        SocketParams.HOST_1_ID: HOST_1_ID,
        SocketParams.HOST_1_AGORA_ID: HOST_1_AGORA_ID,
        SocketParams.HOST_1_CHANNEL: HOST_1_CHANNEL,
        SocketParams.HOST_1_LIVEID: HOST_1_LIVEID,
        SocketParams.HOST_1_TOKEN: HOST_1_TOKEN,
        SocketParams.HOST_1_NAME: HOST_1_NAME,
        SocketParams.HOST_1_USERNAME: HOST_1_USERNAME,
        SocketParams.HOST_1_IMAGE: HOST_1_IMAGE,
        SocketParams.HOST_1_PROFILEPICISBANNED: HOST_1_PROFILEPICISBANNED,
        SocketParams.HOST_1_UNIQUEID: HOST_1_UNIQUEID,
        SocketParams.HOST_1_WEALTHLEVEL_IMAGE: HOST_1_WEALTHLEVEL_IMAGE,
        SocketParams.HOST_2_ID: HOST_2_ID,
        SocketParams.HOST_2_AGORA_ID: HOST_2_AGORA_ID,
        SocketParams.HOST_2_CHANNEL: HOST_2_CHANNEL,
        SocketParams.HOST_2_LIVEID: HOST_2_LIVEID,
        SocketParams.HOST_2_TOKEN: HOST_2_TOKEN,
        SocketParams.HOST_2_NAME: HOST_2_NAME,
        SocketParams.HOST_2_USERNAME: HOST_2_USERNAME,
        SocketParams.HOST_2_IMAGE: HOST_2_IMAGE,
        SocketParams.HOST_2_PROFILEPICISBANNED: HOST_2_PROFILEPICISBANNED,
        SocketParams.HOST_2_UNIQUEID: HOST_2_UNIQUEID,
        SocketParams.HOST_2_WEALTHLEVEL_IMAGE: HOST_2_WEALTHLEVEL_IMAGE,
      },
    );

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.pkAnswer, pkRequest);
      Utils.showLog("Socket Emit => Pk Answer");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onPkRequest({
    required String host2Id,
    required int host1Uid,
    required String host1Token,
    required String host1Channel,
    required String host1LiveHistoryId,
    required String host1Id,
    required String host1Name,
    required String host1UserName,
    required String host1UniqueId,
    required String host1Image,
    required bool host1ProfilePicIsBanned,
    required bool instantCutRequestByHost,
  }) async {
    final pkRequest = jsonEncode(
      {
        SocketParams.InstantCutRequestByHost: instantCutRequestByHost,
        SocketParams.host2Id: host2Id,
        SocketParams.host1Uid: host1Uid,
        SocketParams.host1Token: host1Token,
        SocketParams.host1Channel: host1Channel,
        SocketParams.host1LiveHistoryId: host1LiveHistoryId,
        SocketParams.host1Id: host1Id,
        SocketParams.host1Name: host1Name,
        SocketParams.host1UserName: host1UserName,
        SocketParams.host1UniqueId: host1UniqueId,
        SocketParams.host1Image: host1Image,
        SocketParams.host1ProfilePicIsBanned: host1ProfilePicIsBanned,
      },
    );

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.pkRequest, pkRequest);
      Utils.showLog("Socket Emit => Pk Request");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onPkGift({
    required String senderUserId,
    required String senderName,
    required String senderImage,
    required String senderUniqueId,
    required bool senderProfilePicBanned,
    required String receiverUserId,
    required String liveHistoryId,
    required String giftId,
    required String giftUrl,
    required int giftCount,
    required int giftType,
    required int giftCoin,
    required String giftCategoryId,
    required int liveType,
    required String receiverName,
    required Map<String, dynamic> liveUserList,
  }) async {
    final pkRequest = jsonEncode(
      {
        SocketParams.senderUserId: senderUserId,
        SocketParams.senderName: senderName,
        SocketParams.senderImage: senderImage,
        SocketParams.senderUniqueId: senderUniqueId,
        SocketParams.senderProfilePicBanned: senderProfilePicBanned,
        SocketParams.receiverUserId: receiverUserId,
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.giftId: giftId,
        SocketParams.giftCount: giftCount,
        SocketParams.giftUrl: giftUrl,
        SocketParams.giftType: giftType,
        SocketParams.giftCoin: giftCoin,
        SocketParams.giftCategoryId: giftCategoryId,
        SocketParams.liveType: liveType,
        SocketParams.receiverName: receiverName,
        SocketParams.liveUserList: liveUserList,
      },
    );

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.pkGift, pkRequest);
      Utils.showLog("Socket Emit => Pk Gift");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onPkEnd({
    required String liveHistoryId,
    required String userId,
    required bool isManualMode,
    required String pkEndUserId,
  }) async {
    final pkRequest = jsonEncode(
      {
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.userId: userId,
        SocketParams.isManualMode: isManualMode,
        SocketParams.pkEndUserId: pkEndUserId,
      },
    );

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.pkEnd, pkRequest);
      Utils.showLog("Socket Emit => Pk End");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  // ****************************************************************************************************************************************

  static Future<void> onHostJoinAudioRoom({
    required String userId,
    required String liveHistoryId,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.hostJoinAudioRoom, data);
      Utils.showLog("Socket Emit => Host Join Audio Room");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onHostLeaveAudioRoom({
    required String userId,
    required String liveHistoryId,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.hostLeaveAudioRoom, data);
      Utils.showLog("Socket Emit => Host Leave Audio Room");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onRequestToJoinAudioRoom({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
    required String name,
    required String image,
    required bool isMediaBanned,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
      SocketParams.name: name,
      SocketParams.image: image,
      SocketParams.isMediaBanned: isMediaBanned,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.requestToJoinAudioRoom, data);
      Utils.showLog("Socket Emit => Request To Join Audio Room");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onAudioRoomInviteRevoked({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.audioRoomInviteRevoked, data);
      Utils.showLog("Socket Emit => Audio Room Invite Revoked");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onParticipantAdded({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
    required String name,
    required String image,
    required int agoraUid,
    required int mute,
    required int coin,
    required String avtarFrame,
    required int avtarFrameType,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
      SocketParams.name: name,
      SocketParams.image: image,
      SocketParams.agoraUid: agoraUid,
      SocketParams.mute: mute,
      SocketParams.coin: coin,
      SocketParams.avtarFrame: avtarFrame,
      SocketParams.avtarFrameType: avtarFrameType,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.participantAdded, data);
      Utils.showLog("Socket Emit => Participant Added => $data");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onParticipantRemoved({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.participantRemoved, data);
      Utils.showLog("Socket Emit => Participant Removed");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onSeatLocked({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
    required bool lock,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
      SocketParams.lock: lock,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.seatLocked, data);
      Utils.showLog("Socket Emit => Seat Locked");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onSeatMuted({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
    required int mute,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
      SocketParams.mute: mute,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.seatMuted, data);
      Utils.showLog("Socket Emit => Seat Muted");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onHostSeatMuted({
    required String liveHistoryId,
    required String liveUserObjId,
    required int hostIsMuted,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.hostIsMuted: hostIsMuted,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.hostSeatMuted, data);
      Utils.showLog("Socket Emit => Host Seat Muted");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onParticipantSpeaking({
    required String userId,
    required String liveHistoryId,
    required String liveUserObjId,
    required int position,
    required bool speaking,
  }) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.position: position,
      SocketParams.speaking: speaking,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.participantSpeaking, data);
      Utils.showLog("Socket Emit => Participant Speaking");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onSeatCountModified({
    required String liveHistoryId,
    required int seatCount,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.seatCount: seatCount,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.seatCountModified, data);
      Utils.showLog("Socket Emit => Seat Count Modified");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onAddToBlockedList({
    required String liveHistoryId,
    required String blockedUserId,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.blockedUserId: blockedUserId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.addToBlockedList, data);
      Utils.showLog("Socket Emit => Add To Blocked List");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onUpdateLiveTheme({
    required String liveHistoryId,
    required String bgTheme,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.bgTheme: bgTheme,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.updateLiveTheme, data);
      Utils.showLog("Socket Emit => Update Live Theme");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onRemoveFromBlockedList({
    required String liveHistoryId,
    required String unblockedUserId,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.unblockedUserId: unblockedUserId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.removeFromBlockedList, data);
      Utils.showLog("Socket Emit => Remove From Blocked List");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onGiftInAudioRoom({
    required String senderUserId,
    required String senderName,
    required String senderImage,
    required String senderUniqueId,
    required bool senderProfilePicBanned,
    required List receiverUserId,
    required String liveHistoryId,
    required String liveUserObjId,
    required String giftId,
    required int giftCount,
    required String giftUrl,
    required int giftType,
    required int giftCoin,
    required String giftCategoryId,
    required List receiveUsersDetails,
    required int liveType,
    required String receiverName,
    required Map<String, dynamic> liveUserList,
  }) async {
    final data = jsonEncode({
      SocketParams.senderUserId: senderUserId,
      SocketParams.senderName: senderName,
      SocketParams.senderImage: senderImage,
      SocketParams.senderUniqueId: senderUniqueId,
      SocketParams.senderProfilePicBanned: senderProfilePicBanned,
      SocketParams.receiverUserId: receiverUserId,
      SocketParams.receiveUsersDetails: receiveUsersDetails,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.liveUserObjId: liveUserObjId,
      SocketParams.giftId: giftId,
      SocketParams.giftCount: giftCount,
      SocketParams.giftUrl: giftUrl,
      SocketParams.giftType: giftType,
      SocketParams.giftCoin: giftCoin,
      SocketParams.giftCategoryId: giftCategoryId,
      SocketParams.liveType: liveType,
      SocketParams.receiverName: receiverName,
      SocketParams.liveUserList: liveUserList,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.giftInAudioRoom, data);
      Utils.showLog("Socket Emit => Gift In Audio Room => $data");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onBroadcastReaction({
    int? position,
    required String liveHistoryId,
    required String image,
    required String senderName,
    required String senderImage,
    required bool senderProfilePicBanned,
    required int time,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.position: position,
      SocketParams.image: image,
      SocketParams.senderName: senderName,
      SocketParams.senderImage: senderImage,
      SocketParams.senderProfilePicBanned: senderProfilePicBanned,
      SocketParams.time: time,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.broadcastReaction, data);

      Utils.showLog("Socket Emit => Broadcast Reaction");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  // ****************************************************************************************************************************************

  static Future<void> onJoinLiveRoom({required String liveHistoryId}) async {
    final data = jsonEncode({SocketParams.liveHistoryId: liveHistoryId});

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.joinLiveRoom, data);
      Utils.showLog("Socket Emit => Join Live Room => $data");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onCountLiveJoin({
    required String userId,
    required String liveHistoryId,
    String? host2LiveId,
    required int liveType,
    required String entryRide,
    required int entryRideType,
  }) async {
    dynamic data;
    if (host2LiveId != null && host2LiveId.trim().isNotEmpty) {
      data = jsonEncode({
        SocketParams.userId: userId,
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.liveType: liveType,
        SocketParams.host2LiveId: host2LiveId,
      });
    } else {
      data = jsonEncode({
        SocketParams.userId: userId,
        SocketParams.liveHistoryId: liveHistoryId,
        SocketParams.liveType: liveType,
        SocketParams.entryRide: entryRide,
        SocketParams.entryRideType: entryRideType,
      });
    }

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.countLiveJoin, data);
      Utils.showLog("Socket Emit => Count Live Join => $data");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onReduceLiveJoiners({required String userId, required String liveHistoryId}) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.reduceLiveJoiners, data);
      Utils.showLog("Socket Emit => Reduce Live Joiners");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onBroadcastLiveComment({
    required String liveHistoryId,
    required String senderUserId,
    required String senderName,
    required String senderImage,
    required bool senderProfilePicBanned,
    required String commentText,
    required bool isBattleActive,
  }) async {
    final data = jsonEncode({
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.senderUserId: senderUserId,
      SocketParams.senderName: senderName,
      SocketParams.senderImage: senderImage,
      SocketParams.senderProfilePicBanned: senderProfilePicBanned,
      SocketParams.commentText: commentText,
      SocketParams.isBattleActive: isBattleActive,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.broadcastLiveComment, data);
      Utils.showLog("Socket Emit => Broadcast Live Comment");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onGiftToLiveStream({
    required String senderUserId,
    required String senderName,
    required String senderImage,
    required String senderUniqueId,
    required bool senderProfilePicBanned,
    required String liveHistoryId,
    required List receiverUserId,
    required String giftId,
    required int giftCount,
    required String giftUrl,
    required int giftCoin,
    required int giftType,
    required String giftCategoryId,
    required int liveType,
    required String receiverName,
    required Map<String, dynamic> liveUserList,
  }) async {
    final data = jsonEncode({
      SocketParams.senderUserId: senderUserId,
      SocketParams.senderName: senderName,
      SocketParams.senderImage: senderImage,
      SocketParams.senderUniqueId: senderUniqueId,
      SocketParams.senderProfilePicBanned: senderProfilePicBanned,
      SocketParams.receiverUserId: receiverUserId,
      SocketParams.liveHistoryId: liveHistoryId,
      SocketParams.giftId: giftId,
      SocketParams.giftCount: giftCount,
      SocketParams.giftUrl: giftUrl,
      SocketParams.giftType: giftType,
      SocketParams.giftCoin: giftCoin,
      SocketParams.giftCategoryId: giftCategoryId,
      SocketParams.liveType: liveType,
      SocketParams.receiverName: receiverName,
      SocketParams.liveUserList: liveUserList,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.giftToLiveStream, data);
      Utils.showLog("Socket Emit => Gift To Live Stream => $data");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onEndLiveStream({required String userId, required String liveHistoryId}) async {
    final data = jsonEncode({
      SocketParams.userId: userId,
      SocketParams.liveHistoryId: liveHistoryId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.endLiveStream, data);
      Utils.showLog("Socket Emit => End Live Stream");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  // ****************************************************************************************************************************************
  static Future<void> onSendMessage({
    required String chatTopicId,
    required String senderId,
    required String receiverId,
    required String message,
    required int messageType,
    required String date,
    String? messageId,
    bool? isMediaBanned,
  }) async {
    final data = jsonEncode({
      SocketParams.chatTopicId: chatTopicId,
      SocketParams.senderId: senderId,
      SocketParams.receiverId: receiverId,
      SocketParams.message: message,
      SocketParams.messageType: messageType,
      SocketParams.date: date,
      SocketParams.messageId: messageId,
      SocketParams.isMediaBanned: messageId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.messageSent, data);
      Utils.showLog("Socket Emit => Message Send");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onMessageSeen({required String messageId}) async {
    final data = jsonEncode({SocketParams.messageId: messageId});

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.messageSeen, data);
      Utils.showLog("Socket Emit => Message Seen");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  // ****************************************************************************************************************************************

  static Future<void> onInitiateCall({required String callerId, required String receiverId, required int agoraUID, required String channel}) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.agoraUID: agoraUID,
      SocketParams.channel: channel,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.initiateCall, data);
      Utils.showLog("Socket Emit => Initiate Call");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onHandleCallResponse({
    required String callId,
    required String callerId,
    required String callerName,
    required String callerImage,
    required String receiverId,
    required String receiverName,
    required String receiverImage,
    required String token,
    required String channel,
    required bool isAccept,
  }) async {
    final data = jsonEncode({
      SocketParams.callId: callId,
      SocketParams.callerId: callerId,
      SocketParams.callerName: callerName,
      SocketParams.callerImage: callerImage,
      SocketParams.receiverId: receiverId,
      SocketParams.receiverName: receiverName,
      SocketParams.receiverImage: receiverImage,
      SocketParams.token: token,
      SocketParams.channel: channel,
      SocketParams.isAccept: isAccept,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.handleCallResponse, data);
      Utils.showLog("Socket Emit => Handle Call Response");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onCancelOngoingCall({
    required String callerId,
    required String receiverId,
    required String callId,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callId: callId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.cancelOngoingCall, data);
      Utils.showLog("Socket Emit => Cancel Ongoing Call");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onCallEnded({
    required String callId,
    required String callerId,
    required String receiverId,
  }) async {
    final data = jsonEncode({
      SocketParams.callId: callId,
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.callEnded, data);
      Utils.showLog("Socket Emit => Call Ended");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onCallCoinDeduction({
    required String callerId,
    required String receiverId,
    required String callId,
  }) async {
    final data = jsonEncode({
      SocketParams.callerId: callerId,
      SocketParams.receiverId: receiverId,
      SocketParams.callId: callId,
    });

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.callCoinDeduction, data);
      Utils.showLog("Socket Emit => Call Coin Deduction");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onFetchSingleLiveUser({required String liveHistoryId, required String liveUserObjId}) async {
    final data = jsonEncode({SocketParams.liveHistoryId: liveHistoryId, SocketParams.liveUserObjId: liveUserObjId});

    if (socket != null && socket?.connected == true) {
      socket?.emit(SocketEvents.fetchSingleLiveUser, data);
      Utils.showLog("Socket Emit => Fetch Single Live User => $data");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }
}
