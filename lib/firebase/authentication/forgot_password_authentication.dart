import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class ForgotPasswordAuthentication {
  static Future<UserCredential?> resetPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).catchError(
        (e) {
          Utils.showLog("Validate User Email => Error: ${e.toString()}");
          Utils.showToast(text: "Error: ${e.toString()}");
        },
      );

      // Utils.showLog("Email Authentication Response resetPassword user => $emailsend");
      Utils.showToast(text: EnumLocal.txtResetLinkSentToYourEmail.name.tr);
    } catch (e) {
      Utils.showToast(text: "Error: ${e.toString()}");
      Utils.showLog("Validate User Email => Error: ${e.toString()}");
    }
    return null;
  }

  static Future<UserCredential?> verifyMail(email) async {
    try {
      await FirebaseAuth.instance.sendSignInLinkToEmail(
          email: email,
          actionCodeSettings: ActionCodeSettings(
            url: 'https://example.com/finishSignUp?cartId=1234',
            handleCodeInApp: true,
            iOSBundleId: 'com.incodes.tingle',
            androidPackageName: 'com.incodes.tingle',
            androidInstallApp: true,
            androidMinimumVersion: '10',
          ));
      Utils.showToast(text: "Password reset email sent");
    } catch (e) {
      Utils.showToast(text: "Error: ${e.toString()}");
      Utils.showLog("Error: ${e.toString()}");
    }
    return null;
  }
}
