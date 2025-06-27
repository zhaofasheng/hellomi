// import 'package:firebase_database/firebase_database.dart';
//
// class RealtimeHelper {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//
//   // Initialize user status in Firebase Realtime Database
//   Future<void> initUserStatus(String uniqueId) async {
//     try {
//       await _database.child('user_status').child(uniqueId).set({
//         "isOnline": true,
//         "lastSeen": DateTime.now().millisecondsSinceEpoch,
//       });
//       print("User status initialized");
//     } catch (e) {
//       print("Error initializing user status: $e");
//     }
//   }
//
//   // Track connection status
//   void trackConnectionStatus(String uniqueId) {
//     DatabaseReference userStatusRef = _database.child('user_status').child(uniqueId);
//
//     userStatusRef.onDisconnect().update({
//       "isOnline": false,
//       "lastSeen": DateTime.now().millisecondsSinceEpoch,
//     });
//   }
// }
