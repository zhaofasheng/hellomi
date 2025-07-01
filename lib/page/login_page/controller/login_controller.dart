import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/common/api/user_exists_for_reset_api.dart';
import 'package:tingle/common/api/verify_mail_api.dart';
import 'package:tingle/common/model/validate_user.dart';
import 'package:tingle/custom/function/custom_fetch_random_name.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/anonymous_authentication.dart';
import 'package:tingle/firebase/authentication/email_password_authentication.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_phone_authentication.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/firebase/authentication/forgot_password_authentication.dart';
import 'package:tingle/firebase/authentication/google_authentication.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/page/login_page/api/login_api.dart';
import 'package:tingle/page/login_page/model/login_model.dart';
import 'package:tingle/page/login_page/screen/forgot_password_screen.dart';
import 'package:tingle/page/login_page/screen/phone_otp_verification_screen.dart';
import 'package:tingle/page/login_page/screen/self_registration_screen.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class LoginController extends GetxController {
  LoginModel? loginModel;

  String randomName = "";
  // Login Variables
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isCheckedConditions = false;

  // Register Variables
  TextEditingController registrationNameController = TextEditingController();
  TextEditingController registrationEmailController = TextEditingController();
  TextEditingController registrationPasswordController = TextEditingController();
  TextEditingController registrationConfirmPasswordController = TextEditingController();

  RxBool isObscure = true.obs;
  RxBool confirmIsObscure = true.obs;

  // Phone Number Variables

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  int otpCountTime = 29;
  Timer? timer;
  String verificationId = "";
  String countryCode = "91";
  bool isRunningPhoneAuth = false;

  // Forgot Variables
  TextEditingController forgotPasswordEmailController = TextEditingController();

  @override
  void onInit() {
    randomName = CustomFetchRandomName.onGet();
    super.onInit();
  }

  void onChangeIsCheckedConditions() {
    isCheckedConditions = !isCheckedConditions;
    update([ApiParams.onChangeIsCheckedConditions]);
  }

  void onChangeObscure({bool? value}) {
    isObscure.value = value ?? !isObscure.value;
    update([ApiParams.password]);
  }

  void onChangeConfirmObscure() {
    confirmIsObscure.value = !confirmIsObscure.value;
    update([ApiParams.password]);
  }

  void onGetPhoneNumber({String phoneNumber = "", Country? code}) {
    countryCode = code?.dialCode ?? "";
    update([ApiParams.onPhoneNumber]);
  }

  void onQuickLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (isCheckedConditions == false) {
      Utils.showToast(text: EnumLocal.txtPleaseAcceptTermsAndConditions.name.tr);
      return;
    }
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final userName = "@${"${randomName.replaceAll(' ', '').trim().toLowerCase()}_${time.substring(time.length - 4)}"}";

    Get.dialog(
        PopScope(
          canPop: false, // Block system back button
          child: const LoadingWidget(),
        ),
        barrierDismissible: false); // Start Loading...

    await AnonymousAuthentication.signInWithAnonymous(); // Anonymous Login...

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();

    loginModel = await LoginApi.callApi(
      loginType: 3, // Quick Login
      identity: Database.identity,
      fcmToken: Database.fcmToken,
      email: Database.identity,
      uid: uid ?? "",
      token: token ?? "",
      name: randomName,
      userName: userName,
      image: Database.randomProfileImage,
    );

    Get.back(); // Stop Loading...

    if (loginModel?.status == true) {
      onGetProfile(token: token ?? "", uid: uid ?? "");
    } else {
      Utils.showLog(loginModel?.message ?? "");
    }
  }

  void onGoogleLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isCheckedConditions == false) {
      Utils.showToast(text: EnumLocal.txtPleaseAcceptTermsAndConditions.name.tr);
      return;
    }

    Get.dialog(
        PopScope(
          canPop: false, // Block system back button
          child: const LoadingWidget(),
        ),
        barrierDismissible: false); // Start Loading...

    UserCredential? userCredential = await GoogleAuthentication.signInWithGoogle(); // Google Login...

    final uid = FirebaseUid.onGet();
    final token = await FirebaseAccessToken.onGet();
    // if User Link accounts that use the same email User this condition
    // userCredential?.user?.email != null
    // if  accounts are not Linking  that use the same email User this condition
    // userCredential?.additionalUserInfo?.profile?[ApiParams.email] != null

    if ((userCredential?.additionalUserInfo?.profile?[ApiParams.email] != null || userCredential?.user?.email != null) && userCredential?.user?.displayName != null && userCredential?.user?.photoURL != null) {
      loginModel = (userCredential?.additionalUserInfo?.isNewUser == false)
          ? await LoginApi.callApi(
              loginType: 2,
              // Google Login
              identity: Database.identity,
              fcmToken: Database.fcmToken,
              email: userCredential?.additionalUserInfo?.profile?[ApiParams.email] ?? "",
              uid: uid ?? "",
              token: token ?? "",
            )
          : await LoginApi.callApi(
              loginType: 2,
              // Google Login
              identity: Database.identity,
              fcmToken: Database.fcmToken,
              email: userCredential?.additionalUserInfo?.profile?[ApiParams.email] ?? "",
              uid: uid ?? "",
              token: token ?? "",
              name: userCredential?.user?.displayName ?? "",
              userName: "@${(userCredential?.user?.displayName ?? "").replaceAll(' ', '').trim().toLowerCase()}",
              image: userCredential?.user?.photoURL ?? "",
            );

      Get.back(); // Stop Loading...

      if (loginModel?.status == true) {
        onGetProfile(token: token ?? "", uid: uid ?? "");
      } else {
        Utils.showLog(loginModel?.message ?? "");
        Utils.showToast(text: loginModel?.message ?? "");
      }
    } else {
      Utils.showToast(text: EnumLocal.txtGoogleLoginFailed.name.tr);
      Get.back(); // Stop Loading...
    }
  }

  void onEmailPasswordLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isCheckedConditions) {
      if (emailController.text.trim().isEmpty) {
        Utils.showToast(text: EnumLocal.txtPleaseEnterEmail.name.tr);
      } else if (isValidEmail(emailController.text) == false) {
        Utils.showToast(text: EnumLocal.txtPleaseEnterValidEmail.name.tr);
      } else if (passwordController.text.trim().isEmpty) {
        Utils.showToast(text: EnumLocal.txtPleaseEnterPassword.name.tr);
      } else if (passwordController.text.length < 6) {
        Utils.showToast(text: EnumLocal.txtPasswordMustBeMoreThan6Chars.name.tr);
      } else {
        Get.dialog(
          PopScope(
            canPop: false, // Block system back button
            child: const LoadingWidget(),
          ),
          barrierDismissible: false,
        ); // Start Loading...

        ValidateUserModel? validateUserModel = await UserExistsForResetApi.callApi(loginType: 4, email: emailController.text);
        // = await VerifyMailApi.callApi(loginType: 4, password: passwordController.text, email: emailController.text); // Check Email Is Exist...

        if (validateUserModel?.isLogin != true) {
          Utils.showLog("Validate User Email => ${validateUserModel?.status}");
          Utils.showLog("Validate User Email => ${validateUserModel?.message}");
          if (validateUserModel?.status == false && validateUserModel?.message == "Password doesn't match for this user.") {
            Utils.showToast(text: EnumLocal.txtPasswordDoesNotMatch.name.tr);
            Utils.showLog("Validate User NOT MATCH Email => ${validateUserModel?.status}");
            Get.back(); // Stop Loading...
          } else {
            Utils.showLog("Validate User NOT => ${validateUserModel?.message}");
            Get.back(); // Stop Loading...
            Utils.showToast(text: "${validateUserModel?.message}");
            Get.to(() => const SelfRegistrationScreen());
          }
        } else {
          Utils.showLog("Validate User Email => ${validateUserModel?.status}");
          UserCredential? userCredential = await EmailPasswordAuthentication.signInWithEmailPassword(emailController.text, passwordController.text); // Email Password Login...
          Utils.showLog("Validate User Email => ${userCredential?.user?.email}");
          if (userCredential?.user?.email != null || userCredential?.user?.email?.isEmpty == false) {
            final uid = FirebaseUid.onGet();
            final token = await FirebaseAccessToken.onGet();

            loginModel = await LoginApi.callApi(
              loginType: 4, // Email Login
              identity: Database.identity,
              fcmToken: Database.fcmToken,
              email: userCredential?.user?.email ?? "",
              password: passwordController.text,
              uid: uid ?? "",
              token: token ?? "",
            );

            Get.back(); // Stop Loading...

            if (loginModel?.status == true) {
              emailController.clear();
              passwordController.clear();
              onGetProfile(token: token ?? "", uid: uid ?? "");
            } else {
              Utils.showLog(loginModel?.message ?? "");
            }
          } else {
            // Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
            Get.back(); // Stop Loading...
          }
        }
      }
    } else {
      Utils.showToast(text: EnumLocal.txtPleaseAcceptTermsAndConditions.name.tr);
    }
  }

  void onRegisterUser() async {
    if (registrationNameController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterYourName.name.tr);
    } else if (registrationEmailController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterEmail.name.tr);
    } else if (isValidEmail(registrationEmailController.text) == false) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterValidEmail.name.tr);
    } else if (registrationPasswordController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterPassword.name.tr);
    } else if (registrationPasswordController.text.length < 6) {
      Utils.showToast(text: EnumLocal.txtPasswordMustBeMoreThan6Chars.name.tr);
    } else if (registrationConfirmPasswordController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterConfirmPassword.name.tr);
    } else if (registrationConfirmPasswordController.text.trim() != registrationPasswordController.text.trim()) {
      Utils.showToast(text: EnumLocal.txtPasswordAndConfirmPasswordDoNotMatch.name.tr);
    } else {
      Get.dialog(
          PopScope(
            canPop: false, // Block system back button
            child: const LoadingWidget(),
          ),
          barrierDismissible: false); // Start Loading...

      ValidateUserModel? validateUserModel = await VerifyMailApi.callApi(
        loginType: 4,
        password: registrationPasswordController.text,
        email: registrationEmailController.text,
      ); // Check Email Is Exist...

      if (validateUserModel?.status != true) {
        Utils.showToast(text: EnumLocal.txtEmailAlreadyExist.name.tr);
        Utils.showLog("Validate User Email => ${validateUserModel?.status}");
        Get.back(); // Stop Loading...
        Get.back(); // Back To Login Page..
      } else {
        Utils.showLog("Validate User Email => ${validateUserModel?.status}");

        UserCredential? userCredential = await EmailPasswordAuthentication.createUserWithEmailAndPassword(
          registrationEmailController.text,
          registrationConfirmPasswordController.text,
        ); // Email Password SignUp...

        Utils.showLog("User Credential => ${userCredential?.user?.email}");

        if (userCredential?.user?.email != null) {
          final uid = FirebaseUid.onGet();
          final token = await FirebaseAccessToken.onGet();

          loginModel = await LoginApi.callApi(
            loginType: 4, // Email Login
            identity: Database.identity,
            fcmToken: Database.fcmToken,
            email: userCredential?.user?.email ?? "",
            password: registrationPasswordController.text,
            uid: uid ?? "",
            token: token ?? "",

            image: Database.randomProfileImage,
            name: registrationNameController.text,
            userName: "@${registrationNameController.text.replaceAll(' ', '').trim().toLowerCase()}",
          );

          registrationNameController.clear();
          registrationEmailController.clear();
          registrationPasswordController.clear();
          registrationConfirmPasswordController.clear();

          Get.back(); // Stop Loading...

          Utils.showLog("User message ${loginModel?.message ?? ""}");
          Utils.showLog("User message Status ${loginModel?.status}");

          if (loginModel?.status == true) {
            onGetProfile(token: token ?? "", uid: uid ?? "");
          } else {
            Utils.showLog(loginModel?.message ?? "");
          }
        } else {
          Get.back(); // Stop Loading...
        }
      }
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  Future<void> onPhoneSendOtp() async {
    try {
      if (phoneNumberController.text.trim().isEmpty) {
        Utils.showToast(text: EnumLocal.txtPleaseEnterYourPhoneNumber.name.tr);
      } else {
        final String phoneNumber = "+$countryCode${phoneNumberController.text.trim()}";
        Get.dialog(
            PopScope(
              canPop: false, // Block system back button
              child: const LoadingWidget(),
            ),
            barrierDismissible: false); // Start Loading...

        String? verificationPasswordId = await PhoneAuthentication.createUserPhoneOtpSend(phoneNumber);

        if (verificationPasswordId != null && verificationPasswordId.isNotEmpty) {
          Utils.showLog("Phone Number verificationId => $verificationPasswordId");

          verificationId = verificationPasswordId;
          Utils.showLog("Phone Number verificationId NEW => $verificationId");

          onCountTime(); // Start countdown

          await 2000.milliseconds.delay(); // Use For Late Otp Ui Change Issue

          Get.back(); // Stop Loading...

          Get.to(() => PhoneOtpVerificationScreen());
        } else {
          Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
          Get.back(); // Stop Loading...
        }
      }
    } catch (e) {
      Get.back(); // Stop Loading...
      Utils.showLog("Phone OTP Sending Failed => $e");
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    }
  }

  Future<void> onForgotPassword() async {
    if (forgotPasswordEmailController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterEmail.name.tr);
    } else if (isValidEmail(forgotPasswordEmailController.text) == false) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterValidEmail.name.tr);
    } else {
      Get.dialog(
          PopScope(
            canPop: false, // Block system back button
            child: const LoadingWidget(),
          ),
          barrierDismissible: false); // Start Loading...

      ValidateUserModel? validateUserModel = await UserExistsForResetApi.callApi(loginType: 4, email: forgotPasswordEmailController.text); // Check Email Is Exist...

      if (validateUserModel?.isLogin != true) {
        Utils.showToast(text: EnumLocal.txtNoAccountFoundForThisEmail.name.tr);
        Utils.showLog("Validate User Email => ${validateUserModel?.status}");
        Get.back(); // Stop Loading...
        return;
      } else {
        Utils.showLog("Validate User Email => ${validateUserModel?.status}");

        var data = await ForgotPasswordAuthentication.resetPassword(forgotPasswordEmailController.text.trim());
        Utils.showLog("Validate User Email 124=>  ${data}");
        Get.back(); // Stop Loading...
        Get.back(); // Back To Login Page..
        emailController.text = forgotPasswordEmailController.text.trim();
        forgotPasswordEmailController.clear();
      }
    }
    // ForgotPasswordAuthentication.resetPassword(emailController.text.trim());
  }

  Future<void> onVerifyOtp({required String otp}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (verificationId.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
    } else {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

      UserCredential? userCredential = await PhoneAuthentication.verifyOtp(phoneVerificationId: verificationId, otp: otp);

      Utils.showLog("User Credential => ${userCredential?.user?.phoneNumber}");

      if (userCredential?.user?.phoneNumber != null) {
        final uid = FirebaseUid.onGet();
        final token = await FirebaseAccessToken.onGet();

        loginModel = await LoginApi.callApi(
          loginType: 1, // Phone Login...
          identity: Database.identity,
          fcmToken: Database.fcmToken,
          mobileNumber: userCredential?.user?.phoneNumber ?? "",
          email: Database.identity,
          uid: uid ?? "",
          token: token ?? "",
        );

        Get.back(); // Stop Loading...

        Utils.showLog("User message ${loginModel?.message ?? ""}");
        Utils.showLog("User message Status ${loginModel?.status}");

        if (loginModel?.status == true) {
          onGetProfile(token: token ?? "", uid: uid ?? "");
        } else {
          Utils.showLog(loginModel?.message ?? "");
        }
      } else {
        Get.back(); // Stop Loading...
      }
    }
  }

  void onCountTime() {
    Utils.showLog("Count Time => $otpCountTime");
    Utils.showLog("Count Time timer => $timer");

    if (timer?.isActive ?? false) {
      timer?.cancel();
      update([ApiParams.onCountTime]);
    }

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (otpCountTime > 0) {
          otpCountTime--;
        } else {
          this.timer?.cancel();
          otpCountTime = 30;
        }
        update([ApiParams.onCountTime]);
      },
    );
  }

  void onGetProfile({required String token, required String uid}) async {
    Utils.showLog("Token Profile Inn  => $token");
    await FetchSettingApi.callApi(uid: uid, token: token); // CALL ADMIN SETTING API

    if (FetchSettingApi.fetchSettingModel?.data != null) {
      await FetchLoginUserProfileApi.callApi(token: token, uid: uid);

      if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.id != null) {
        // >>>> >>>>> Store In Local Database <<<<< <<<<<

        Database.onSetIsNewUser(false);
        Database.onSetLoginUserId(FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.id ?? "");
        Database.onSetLoginType(FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.loginType ?? 0);

        Get.toNamed(AppRoutes.fillProfilePage)?.then((value) => Utils.onChangeStatusBar(brightness: Brightness.light));
      }
    }
  }

  void onClickForgotPasswordText() {
    FocusManager.instance.primaryFocus?.unfocus();
    forgotPasswordEmailController.text = emailController.text.trim();
    emailController.clear();
    passwordController.clear();

    Get.to(ForgotPasswordScreen());
  }

  void onClickRegisterText() {
    FocusManager.instance.primaryFocus?.unfocus();
    registrationEmailController.text = emailController.text.trim();
    emailController.clear();
    passwordController.clear();
    onChangeObscure(value: true);
    Get.to(SelfRegistrationScreen());
  }
}
// TODO: Verify Google Login Mail
// ValidateUserModel? validateUserModel =
//     await VerifyMailApi.callApi(loginType: 2, email: userCredential?.additionalUserInfo?.profile?[ApiParams.email] ?? "", password: ""); // Check Email Is Exist...

// if (validateUserModel?.isLogin != true) {
//   Utils.showLog("Validate User Goggle => ${validateUserModel?.status}");
//   Utils.showLog("Validate User Goggle => ${validateUserModel?.message}");
//
//   Utils.showLog("Validate User NOT => ${validateUserModel?.message}");
//   Get.back(); // Stop Loading...
//   Utils.showToast(text: "${validateUserModel?.message}");
//
//   return;
// }
// Utils.showLog("Validate User Email => ${validateUserModel?.status}");
