// class FirebaseChatTopicRoot {
//   String chatId;
//   List<String> participants;
//   String lastMessage;
//   int lastUpdated;
//
//   FirebaseChatTopicRoot({
//     required this.chatId,
//     required this.participants,
//     required this.lastMessage,
//     required this.lastUpdated,
//   });
//
//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "chatId": chatId,
//       "participants": participants,
//       "lastMessage": lastMessage,
//       "lastUpdated": lastUpdated,
//     };
//   }
//
//   // Convert from JSON
//   factory FirebaseChatTopicRoot.fromJson(Map<String, dynamic> json) {
//     return FirebaseChatTopicRoot(
//       chatId: json["chatId"],
//       participants: List<String>.from(json["participants"]),
//       lastMessage: json["lastMessage"],
//       lastUpdated: json["lastUpdated"],
//     );
//   }
// }
