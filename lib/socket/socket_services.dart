import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tingle/socket/socket_listen.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/socket_events.dart';
import 'package:tingle/utils/utils.dart';

io.Socket? socket;

class SocketServices {
  static Future<void> onConnect() async {
    Utils.showLog("MY USER ID => ${Database.loginUserId}");
    try {
      socket = io.io(
        Api.baseUrl,
        io.OptionBuilder().setTransports(['websocket']).setQuery({"globalRoom": "globalRoom:${Database.loginUserId}"}).build(),
      );

      socket?.connect();

      socket?.onConnect((data) {
        Utils.showLog("Socket Listen => Socket Connected : ${socket?.id}");
        SocketListen.onConnect();
      });

      socket!.once(
        "connect",
        (data) {
          socket?.on(SocketEvents.messageSent, (data) async {
            Utils.showLog("Socket Listen => Message Sent : $data");
            SocketListen.onMessageSent(data);
          });

          // ***************************************************** VIDEO CALL EVENT *******************************************************

          socket?.on(SocketEvents.callStarted, (data) async {
            Utils.showLog("Socket Listen => Call Started : $data");
            SocketListen.onCallStarted(data);
            // IF CALLER START CALL...
          });

          socket?.on(SocketEvents.incomingCall, (data) async {
            Utils.showLog("Socket Listen => Incoming Call : $data");
            SocketListen.onIncomingCall(data);
            // IF ANY INCOMING CALL...
          });

          socket?.on(SocketEvents.initiateCall, (data) async {
            Utils.showLog("Socket Listen => Initial Call : $data");
            SocketListen.onInitiateCall(data);
            // IF ANY ERROR LIKE BUSY, CALLER OR RECEIVER NOT FOUND THEN LISTEN...
          });

          socket?.on(SocketEvents.callEnded, (data) async {
            Utils.showLog("Socket Listen => Call Ended : $data");
            SocketListen.onCallEnded(data);
            // IF RUNNING CALL IN CALLER/RECEIVER CUT CALL OR CALLER CANCEL CALL...
          });

          socket?.on(SocketEvents.callAcceptedByReceiver, (data) async {
            Utils.showLog("Socket Listen => Call Accepted By Receiver : $data");
            SocketListen.callAcceptedByReceiver(data);
            // IF IS ACCEPT TRUE THEN JOINING CALLER AND RECEIVER TO CALL ROOM AND LISTEN TO BOTH...
          });

          socket?.on(SocketEvents.callRejectedByReceiver, (data) async {
            Utils.showLog("Socket Listen => Call Rejected By Receiver : $data");
            SocketListen.onCallRejectedByReceiver(data);
            // IF IS ACCEPT FALSE THEN LISTEN TO CALLER...
          });

          socket?.on(SocketEvents.callCancelFailed, (data) async {
            Utils.showLog("Socket Listen => Call Cancel Failed : $data");
            // IF INVALID CALLER, RECEIVER, OR CALL HISTORY THEN LISTEN...
          });

          socket?.on(SocketEvents.callDisconnected, (data) async {
            Utils.showLog("Socket Listen => Call Disconnected : $data");
            // IF CALL ID NOT MATCH THEN LISTEN...
          });

          socket?.on(SocketEvents.callProcessFailed, (data) async {
            Utils.showLog("Socket Listen => Call Process Failed : $data");
            // IF INVALID CALLER, RECEIVER, OR CALL HISTORY THEN LISTEN...
          });

          socket?.on(SocketEvents.insufficientCoins, (data) async {
            Utils.showToast(text: data);
            Utils.showLog("Socket Listen => Insufficient Coins : $data");
            // IF CALLER COIN INSUFFICIENT THEN LISTEN...
            SocketListen.onInsufficientCoins(data);
          });

          // ***************************************************** LIVE EVENT *******************************************************

          socket?.on(SocketEvents.joinLiveRoom, (data) async {
            Utils.showLog("Socket Listen => Join Live Room : $data");
            // WHEN USER LIVE THEN JOIN INTO LIVE ROOM...
          });

          socket?.on(SocketEvents.resumeLiveBroadcast, (data) async {
            Utils.showLog("Socket Listen => Resume Live Broadcast : $data");
            // WHEN USER ALREADY LIVE THEN RE-JOIN INTO LIVE ROOM...
          });

          socket?.on(SocketEvents.countLiveJoin, (data) async {
            Utils.showLog("Socket Listen => Count Live Join : $data");
            SocketListen.onChangeViewCount(data);
            // WHEN USER WANT TO ADD FROM VIEW LIVE-STREAMING...
          });

          socket?.on(SocketEvents.reduceLiveJoiners, (data) async {
            Utils.showLog("Socket Listen => Reduce Live Joiners : $data");
            SocketListen.onChangeViewCount(data);
            // WHEN USER WANT TO REMOVE FROM VIEW LIVE-STREAMING...
          });

          socket?.on(SocketEvents.broadcastLiveComment, (data) async {
            Utils.showLog("Socket Listen => Broadcast Live Comment : $data");
            SocketListen.onBroadcastLiveComment(data);
            // WHEN USER WANT TO COMMENT TO LIVE-STREAMING...
          });

          socket?.on(SocketEvents.fetchLiveGifts, (data) async {
            Utils.showLog("Socket Listen => Fetch Live Gifts : $data");
            // WHEN USER WANT TO SEND GIFT TO LIVE-STREAMING...

            SocketListen.onFetchLiveGifts(data);
          });

          socket?.on(SocketEvents.luckyGiftWin, (data) async {
            Utils.showLog("Socket Listen => Lucky Gift Win : $data");
            // IF LUCKY GIFT WIN BY SENDER USER...

            SocketListen.onLuckyGiftWin(data);
          });

          socket?.on(SocketEvents.endLiveStream, (data) async {
            Utils.showLog("Socket Listen => End LiveStream : $data");
            SocketListen.onEndLiveStream(data);
            // WHEN USER WANT TO END LIVE-STREAMING...
          });

          socket?.on(SocketEvents.singleLiveUserResponse, (data) async {
            Utils.showLog("Socket Listen => Single Live User Response : $data");
          });

          // ***************************************************** AUDIO ROOM EVENT *******************************************************

          socket?.on(SocketEvents.seatUpdate, (data) async {
            Utils.showLog("Socket Listen => Seat Update : $data");
            SocketListen.onSeatUpdate(data);
          });

          socket?.on(SocketEvents.seatedUsersUpdate, (data) async {
            Utils.showLog("Socket Listen => Seated Users Update : $data");
            SocketListen.onSeatedUsersUpdate(data);
          });

          socket?.on(SocketEvents.liveViewersList, (data) async {
            Utils.showLog("Socket Listen => Live Viewers List : $data");
            SocketListen.onLiveViewersList(data);
          });

          socket?.on(SocketEvents.inviteToJoinRoom, (data) async {
            Utils.showLog("Socket Listen => Invite To Join Room : $data");
            SocketListen.onInviteToJoinRoom(data);
          });

          socket?.on(SocketEvents.participantRemoved, (data) async {
            Utils.showLog("Socket Listen => Participant Removed : $data");
          });

          socket?.on(SocketEvents.addToBlockedList, (data) async {
            Utils.showLog("Socket Listen => Add To Blocked List : $data");
            SocketListen.onChangeUserBlockList(data);
          });

          socket?.on(SocketEvents.notifyBlockedUser, (data) async {
            Utils.showLog("Socket Listen => Notify Blocked User : $data");
            SocketListen.onNotifyBlockedUser(data);
          });

          socket?.on(SocketEvents.removeFromBlockedList, (data) async {
            Utils.showLog("Socket Listen => Remove From Blocked List : $data");
            SocketListen.onChangeUserBlockList(data);
          });

          socket?.on(SocketEvents.giftInAudioRoom, (data) async {
            Utils.showLog("Socket Listen => Gift In Audio Room : $data");
            SocketListen.onGiftInAudioRoom(data);
          });

          socket?.on(SocketEvents.broadcastReaction, (data) async {
            Utils.showLog("Socket Listen => Broadcast Reaction : $data");
            SocketListen.onBroadcastReaction(data);
          });

          socket?.on(SocketEvents.themeUpdated, (data) async {
            Utils.showLog("Socket Listen => Theme Updated : $data");
            SocketListen.onBgTheme(data);
          });

          socket?.on(SocketEvents.liveRoomCoinUpdate, (data) async {
            Utils.showLog("Socket Listen => Live Room Coin Update : $data");
            SocketListen.onLiveRoomCoinUpdate(data);
          });

          socket?.on(SocketEvents.fireEntryEffect, (data) async {
            Utils.showLog("Socket Listen => Fire Entry Effect : $data");
            SocketListen.onFireEntryEffect(data);
          });

          socket?.on(SocketEvents.topLiveStreamGifter, (data) async {
            Utils.showLog("Socket Listen => Top Live Stream Gifter $data");
            SocketListen.onTopLiveStreamGifter(data);
          });

          socket?.on(SocketEvents.broadcastTopGifter, (data) async {
            Utils.showLog("Socket Listen => Broadcast Top Gifter : $data");
            SocketListen.onTopLiveStreamGifter(data);
          });

          // ***************************************************** PK BATTLE EVENT *******************************************************

          socket?.on(SocketEvents.pkRequestReceived, (data) async {
            Utils.showLog("Socket Listen => Pk Request Received : $data");
            SocketListen.onPkRequestReceived(data);
          });

          socket?.on(SocketEvents.pkAnswer, (data) async {
            Utils.showLog("Socket Listen => Pk Answer : $data");
            SocketListen.onPkAnswer(data);
          });

          socket?.on(SocketEvents.pkGift, (data) async {
            Utils.showLog("Socket Listen => Pk Gift : $data");
            SocketListen.onPkGift(data);
          });

          socket?.on(SocketEvents.topGiftersUpdate, (data) async {
            Utils.showLog("Socket Listen => Top Gifters Update : $data");
            SocketListen.onTopGiftersUpdate(data);
          });

          socket?.on(SocketEvents.updateHostGifterStats, (data) async {
            Utils.showLog("Socket Listen => Update Host Gifter Stats : $data");
            SocketListen.onUpdateHostGifterStats(data);
          });

          socket?.on(SocketEvents.pkEnd, (data) async {
            Utils.showLog("Socket Listen => Pk End : $data");
            SocketListen.onPkEnd(data);
          });

          socket?.on(SocketEvents.pkRankUpdate, (data) async {
            Utils.showLog("Socket Listen => Pk Rank Update : $data");
            SocketListen.onPkRankUpdate(data);
          });

          // ***************************************************** BANNER EVENT *******************************************************

          socket?.on(SocketEvents.proHighValueGift, (data) async {
            Utils.showLog("Socket Listen => Pro High Value Gift : $data");
            // WHEN USER SEND HIGH VALUE GIFT IN LIVE THEN LISTEN ALL USER...
            SocketListen.onProHighValueGift(data);
          });

          socket?.on(SocketEvents.highCoinWinBroadcast, (data) async {
            Utils.showLog("Socket Listen => High Coin Win Broadcast : $data");
            // WHEN USER WIN HIGH VALUE IN GIFT THEN LISTEN ALL USER...
            SocketListen.onHighCoinWinBroadcast(data);
          });
        },
      );

      socket?.on(SocketEvents.error, (data) {
        Utils.showLog("Socket Listen => Socket Error : $data");
      });

      socket?.on(SocketEvents.connectError, (data) {
        Utils.showLog("Socket Listen => Socket Connection Error : $data");
      });

      socket?.on(SocketEvents.connectTimeout, (data) {
        Utils.showLog("Socket Listen => Socket Connection Timeout : $data");
      });

      socket?.on(SocketEvents.disconnect, (data) {
        Utils.showLog("Socket Listen => Socket Disconnected : $data");
      });
    } catch (e) {
      Utils.showLog("Socket Listen => Socket Connection Error: $e");
    }
  }

  static Future<void> onDisConnect() async {
    try {
      socket?.disconnect();
      socket?.onDisconnect((data) => Utils.showLog("Socket Listen => Socket Disconnected Called Success: ${socket?.id}"));
    } catch (e) {
      Utils.showLog("Socket Listen => Socket Disconnected Called Failed: $e");
    }
  }
}
