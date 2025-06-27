import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class EmailPasswordAuthentication {
  static Future<UserCredential?> signInWithEmailPassword(email, password) async {
    try {
      Utils.showLog("Email Authentication signInWithEmailPassword email => $email");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Utils.showLog("Email Authentication Response signInWithEmailPassword user => $credential");

      return credential;
    } on FirebaseAuthException catch (e) {
      Utils.showLog("FirebaseAuthException => ${e.code}");
      if (e.code == 'user-not-found') {
        Utils.showLog('No user found for that email.');
        Utils.showToast(text: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.showLog('Wrong password provided for that user.');
        Utils.showToast(text: 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        Utils.showLog('Wrong password provided for that user.');
        Utils.showToast(text: 'Wrong password provided for that user.');
      }
    } catch (error) {
      Utils.showLog("Email Authentication Error => $error");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
    return null;
  }

  static Future<UserCredential?> createUserWithEmailAndPassword(email, password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Utils.showLog("Email Authentication createUserWithEmailAndPassword Response user => $credential");

      return credential;
    } on FirebaseAuthException catch (e) {
      Utils.showLog("FirebaseAuthException => ${e.code}");

      switch (e.code) {
        case 'email-already-in-use':
          Utils.showToast(text: 'This email is already in use.');
          break;
        case 'invalid-email':
          Utils.showToast(text: 'The email address is not valid.');
          break;
        case 'operation-not-allowed':
          Utils.showToast(text: 'Email/password accounts are not enabled.');
          break;
        case 'weak-password':
          Utils.showToast(text: 'The password is too weak.');
          break;
        default:
          Utils.showToast(text: 'Something went wrong. Please try again.');
          break;
      }
    } catch (error) {
      Utils.showLog("Email Authentication Error => $error");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
    return null;
  }
}
