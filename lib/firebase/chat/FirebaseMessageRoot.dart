// class FirebaseMessageRoot {
//   String messageId;
//   String senderId;
//   String receiverId;
//   String data;
//   int timestamp;
//   int type;
//   int price;
//   int isOpened;
//   List<String> readBy;
//   bool isRead;
//
//   FirebaseMessageRoot({
//     required this.messageId,
//     required this.senderId,
//     required this.receiverId,
//     required this.data,
//     required this.timestamp,
//     required this.type,
//     required this.price,
//     required this.isOpened,
//     required this.readBy,
//     required this.isRead,
//   });
//
//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       "messageId": messageId,
//       "senderId": senderId,
//       "receiverId": receiverId,
//       "data": data,
//       "timestamp": timestamp,
//       "type": type,
//       "price": price,
//       "isOpened": isOpened,
//       "readBy": readBy,
//       "isRead": isRead,
//     };
//   }
//
//   // Convert from JSON
//   factory FirebaseMessageRoot.fromJson(Map<String, dynamic> json) {
//     return FirebaseMessageRoot(
//       messageId: json["messageId"],
//       senderId: json["senderId"],
//       receiverId: json["receiverId"],
//       data: json["data"],
//       timestamp: json["timestamp"],
//       type: json["type"],
//       price: json["price"],
//       isOpened: json["isOpened"],
//       readBy: List<String>.from(json["readBy"] ?? []),
//       isRead: json["isRead"] ?? false,
//     );
//   }
// }
