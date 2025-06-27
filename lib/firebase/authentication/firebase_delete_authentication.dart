import 'package:firebase_auth/firebase_auth.dart';
import 'package:tingle/utils/utils.dart';

class FirebaseDeleteAuthentication {
  static Future<void> onDelete() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.delete();
    } catch (e) {
      Utils.showLog("Firebase Delete Authentication Failed => $e");
    }
  }
}
