import 'package:firebase_auth/firebase_auth.dart';
import 'package:tingle/utils/utils.dart';

class AnonymousAuthentication {
  static Future<void> signInWithAnonymous() async {
    try {
      // User? user = FirebaseAuth.instance.currentUser;
      // if (user == null) {
      await FirebaseAuth.instance.signOut();
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      Utils.showLog("New Anonymous Login Response => $userCredential");
      // }
    } catch (e) {
      Utils.showLog("Anonymous Authentication Error => $e");
    }
  }
}
