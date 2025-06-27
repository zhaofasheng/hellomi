import 'package:firebase_auth/firebase_auth.dart';
import 'package:tingle/utils/utils.dart';

class FirebaseLogoutAuthentication {
  static Future<void> onLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Utils.showLog("Firebase Delete Authentication Failed => $e");
    }
  }
}
