// import 'dart:math';
//
// import 'package:tingle/firebase/chat/FirebaseChatTopicRoot.dart';
// import 'package:tingle/firebase/chat/FirebaseMessageRoot.dart';
// import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
//
// import 'FirebaseUserModel.dart';
// import 'FirestoreHelper.dart';
// import 'RealtimeHelper.dart';
//
// class FirebaseManager {
//   static final FirebaseManager _instance = FirebaseManager._internal();
//   final FirestoreHelper firestoreHelper;
//   final RealtimeHelper realtimeHelper;
//
//   factory FirebaseManager() {
//     return _instance;
//   }
//
//   FirebaseManager._internal()
//       : firestoreHelper = FirestoreHelper(),
//         realtimeHelper = RealtimeHelper();
//
//   void initUser(FirebaseUserModel firebaseUserModel) {
//     FirebaseUserModel user = firebaseUserModel;
//     firestoreHelper.initUser(user);
//     realtimeHelper.initUserStatus(user.uniqueId);
//     realtimeHelper.trackConnectionStatus(user.uniqueId);
//
//
//     sendMessage("Hello!", 1, "987654");
//   }
//
//
//   void sendMessage(String message, int type, String otherUserId) {
//     final String myUserId = FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.uniqueId ?? ""; // Example User ID
//
//     // Generate unique Chat ID
//     String chatId = generateChatId(myUserId, otherUserId);
//
//     // Define participants
//     List<String> participants = [myUserId, otherUserId];
//
//     // Create Chat Room Object
//     FirebaseChatTopicRoot chatRoom = FirebaseChatTopicRoot(
//       chatId: chatId,
//       participants: participants,
//       lastMessage: message,
//       lastUpdated: DateTime.now().millisecondsSinceEpoch,
//     );
//
//     // Create or Get Chat Room
//    firestoreHelper.createOrGetChatRoom(chatId, chatRoom);
//
//     // Create Message Object
//     FirebaseMessageRoot messageObj = FirebaseMessageRoot(
//       messageId: Random().nextInt(100000).toString(), // Unique ID
//       senderId: myUserId,
//       receiverId: otherUserId,
//       data: message,
//       timestamp: DateTime.now().millisecondsSinceEpoch,
//       type: type,
//       price: 0,
//       isOpened: 0,
//       readBy: [],
//       isRead: false,
//     );
//
//     // Send the Message
//  firestoreHelper.sendMessage(chatId, messageObj);
//   }
//
//   String generateChatId(String userId1, String userId2) {
//     List<String> ids = [userId1, userId2];
//     ids.sort(); // Sort to maintain consistency
//     return ids.join("_");
//   }
// }
