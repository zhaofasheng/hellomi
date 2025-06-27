import 'package:firebase_auth/firebase_auth.dart';
import 'package:tingle/utils/utils.dart';

class FirebaseUid {
  static bool isCheckStart = false;
  static String? onGet() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      Utils.showLog("Firebase Uid => ${user?.uid}");

      return user?.uid;
    } catch (e) {
      Utils.showLog("Firebase Uid Failed => $e");
      return null;
    }
  }

  static void onCheckAuth() async {
    if (isCheckStart == false) {
      try {
        isCheckStart = true;
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            Utils.showLog('User is currently signed out!');
          } else {
            Utils.showLog('User is signed in!');
          }
        });
      } catch (e) {
        Utils.showLog('Check Auth Failed => $e');
      }
    }
  }
}
