import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class PhoneAuthentication {
  static Future<UserCredential?> verifyOtp({required String phoneVerificationId, required String otp}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: phoneVerificationId, smsCode: otp);

      Utils.showLog("Phone Authentication Response credential => $credential");

      // Sign in with the credential
      UserCredential userCredential = await auth.signInWithCredential(credential);

      Utils.showLog("Phone Authentication Response user => ${userCredential.user}");

      return userCredential;
    } on FirebaseAuthException catch (error) {
      Utils.showLog("Phone Authentication Error => ${error.code}: ${error.message}");

      // Handle specific error cases
      if (error.code == 'invalid-verification-code') {
        Utils.showToast(text: 'The verification code is invalid');
      } else if (error.code == 'session-expired') {
        Utils.showToast(text: 'The verification session has expired');
      } else {
        Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      }
    } catch (error) {
      Utils.showLog("General Error => $error");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
    return null;
  }

  static Future<String?> createUserPhoneOtpSend(String phoneNumber) async {
    final completer = Completer<String>();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          Utils.showLog("Phone Authentication Response user => $credential");
          FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Utils.showLog("Phone Authentication Error => $e");
          if (e.code == 'invalid-phone-number') {
            Utils.showToast(text: 'The provided phone number is not valid.');
          } else {
            Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
          }
          completer.completeError(e); // Also fail the future
        },
        codeSent: (String verificationId, int? resendToken) {
          Utils.showLog("Phone Authentication Code Sent => $verificationId");
          Utils.showToast(text: EnumLocal.txtVerificationCodeSent.name.tr);
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Utils.showLog("Phone Authentication Code Auto Retrieval Timeout => $verificationId");
        },
      );

      final result = await completer.future;
      Utils.showLog("Phone Authentication Code Sent 112 => $result");
      return result;
    } catch (error) {
      Utils.showLog("Phone Authentication Error => $error");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      return null;
    }
  }
}
