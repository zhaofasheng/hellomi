// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tingle/firebase/chat/FirebaseChatTopicRoot.dart';
// import 'package:tingle/firebase/chat/FirebaseMessageRoot.dart';
//
// import 'FirebaseUserModel.dart';
//
// class FirestoreHelper {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Example function to add data to Firestore
//   // Add or update a user in Firestore
//   Future<void> initUser(FirebaseUserModel user) async {
//     try {
//       await _firestore.collection('users').doc(user.uniqueId).set(user.toJson());
//       print("User added successfully");
//     } catch (e) {
//       print("Error adding user: $e");
//     }
//   }
//
//   Future<void> createOrGetChatRoom(String chatId, FirebaseChatTopicRoot chatRoom) async {
//     DocumentReference chatRoomRef = _firestore.collection("chatRooms").doc(chatId);
//
//     try {
//       DocumentSnapshot doc = await chatRoomRef.get();
//       if (!doc.exists) {
//         // Create new chat room
//         await chatRoomRef.set(chatRoom.toJson());
//       }
//     } catch (e) {
//       log("Error creating/getting chat room: $e");
//     }
//   }
//
//   // 🔹 Send Message
//   Future<void> sendMessage(String chatId, FirebaseMessageRoot message) async {
//     DocumentReference messageRef = _firestore.collection("chatRooms").doc(chatId).collection("messages").doc(message.messageId);
//
//     try {
//       await messageRef.set(message.toJson());
//       print("Message sent successfully!");
//
//       // Update chat room last message
//       await _firestore.collection("chatRooms").doc(chatId).update({
//         "lastMessage": message.data,
//         "lastUpdated": message.timestamp,
//       });
//     } catch (e) {
//       print("Error sending message: $e");
//     }
//   }
//
//   // Get user document reference
//   DocumentReference getUserDocument(String uniqueId) {
//     return _firestore.collection('users').doc(uniqueId);
//   }
// }
