// class FirebaseUserModel {
//   String name;
//   String uniqueId;
//   String mongoId;
//   String fcmToken;
//   String image;
//   int type;
//   bool isOnline;
//   int chatRoomCount;
//   int lastSeenTimestamp;
//
//   FirebaseUserModel({
//     required this.name,
//     required this.uniqueId,
//     required this.mongoId,
//     required this.fcmToken,
//     required this.image,
//     required this.type,
//     required this.isOnline,
//     required this.lastSeenTimestamp,
//     this.chatRoomCount = 0, // Default value
//   });
//
//   // Convert model to JSON for Firestore
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "uniqueId": uniqueId,
//       "mongoId": mongoId,
//       "fcmToken": fcmToken,
//       "image": image,
//       "type": type,
//       "isOnline": isOnline,
//       "chatRoomCount": chatRoomCount,
//       "lastSeenTimestamp": lastSeenTimestamp,
//     };
//   }
//
//   // Create a FirebaseUserModel from a Firestore document
//   factory FirebaseUserModel.fromJson(Map<String, dynamic> json) {
//     return FirebaseUserModel(
//       name: json['name'] ?? '',
//       uniqueId: json['uniqueId'] ?? '',
//       mongoId: json['mongoId'] ?? '',
//       fcmToken: json['fcmToken'] ?? '',
//       image: json['image'] ?? '',
//       type: json['type'] ?? 1,
//       isOnline: json['isOnline'] ?? false,
//       chatRoomCount: json['chatRoomCount'] ?? 0,
//       lastSeenTimestamp: json['lastSeenTimestamp'] ?? 0,
//     );
//   }
// }
