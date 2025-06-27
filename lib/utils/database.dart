import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tingle/common/model/fetch_setting_model.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_delete_authentication.dart';
import 'package:tingle/firebase/authentication/firebase_logout_authentication.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/login_page/model/fetch_login_user_profile_model.dart';
import 'package:tingle/page/setting_page/api/delete_user_api.dart';
import 'package:tingle/page/setting_page/model/delete_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/socket/socket_services.dart';
import 'package:tingle/utils/platform_device_id.dart';
import 'package:tingle/utils/utils.dart';

import 'constant.dart';

class Database {
  static final localStorage = GetStorage();

  static const String _searchUserHistory = "searchUserHistory";
  static const String _randomProfileImage = "randomProfileImage";

  static Future<void> init(String identity, String fcmToken) async {
    Utils.showLog("Local Database Initialize....");

    onSetFcmToken(fcmToken);
    onSetIdentity(identity);

    Utils.showLog("Is New User => $isNewUser");
    Utils.showLog("DATABASE PROFILE => ${fetchLoginUserProfile()?.toJson()}");
  }

  // >>>>> >>>>> LOGIN DATABASE <<<<< <<<<<

  static String get fcmToken => localStorage.read("fcmToken") ?? "";
  static String get identity => localStorage.read("identity") ?? "";

  static onSetFcmToken(String fcmToken) async => await localStorage.write("fcmToken", fcmToken);
  static onSetIdentity(String identity) async => await localStorage.write("identity", identity);

  static bool get isNewUser => localStorage.read("isNewUser") ?? true;
  static int get loginType => localStorage.read("loginType") ?? 0;
  static String get loginUserId => localStorage.read("loginUserId") ?? "";

  static onSetIsNewUser(bool isNewUser) async => await localStorage.write("isNewUser", isNewUser);
  static onSetLoginType(int loginType) async => localStorage.write("loginType", loginType);
  static onSetLoginUserId(String loginUserId) async => localStorage.write("loginUserId", loginUserId);

  // >>>>> >>>>> LOGIN USER PROFILE DATABASE <<<<< <<<<<

  static FetchLoginUserProfileModel? fetchLoginUserProfile() => localStorage.read('loginUserProfile') != null ? FetchLoginUserProfileModel.fromJson(jsonDecode(localStorage.read('loginUserProfile') ?? "")) : null;

  static onSetLoginUserProfile(String loginUserProfile) async => localStorage.write("loginUserProfile", loginUserProfile);

  // >>>>> >>>>> ADMIN SETTING DATABASE <<<<< <<<<<

  static FetchSettingModel? fetchAdminSetting() => localStorage.read('adminSetting') != null ? FetchSettingModel.fromJson(jsonDecode(localStorage.read('adminSetting') ?? "")) : null;
  static onSetAdminSetting(String adminSetting) async => localStorage.write("adminSetting", adminSetting);

  // >>>>> >>>>> LANGUAGE DATABASE <<<<< <<<<<

  static String get selectedLanguage => localStorage.read("language") ?? AppConstant.languageEn;
  static String get selectedCountryCode => localStorage.read("countryCode") ?? AppConstant.countryCodeEn;

  static onSetSelectedLanguage(String language) async => await localStorage.write("language", language);
  static onSetSelectedCountryCode(String countryCode) async => await localStorage.write("countryCode", countryCode);

  // >>>>> >>>>> NETWORK IMAGE DATABASE <<<<< <<<<<

  static String? networkImage(String image) => localStorage.read(image);
  static onSetNetworkImage(String image) async => localStorage.write(image, image);

  static String get randomProfileImage => localStorage.read(_randomProfileImage) ?? "";
  static onSetRandomProfileImage(String image) async => localStorage.write(_randomProfileImage, image);

  // >>>>> >>>>> NOTIFICATION DATABASE <<<<< <<<<<

  static bool get isShowNotification => localStorage.read("isShowNotification") ?? true;
  static onSetNotification(bool isShowNotification) async => localStorage.write("isShowNotification", isShowNotification);

  // >>>>> >>>>> Search User History Database <<<<< <<<<<

  static List get searchUserHistory => localStorage.read(_searchUserHistory) ?? [];

  static onSetSearchUserHistory(List searchUserHistory) async => localStorage.write(_searchUserHistory, searchUserHistory);

  // >>>>> >>>>> In App Purchase History Database <<<<< <<<<<

  static onSetIsPurchase(bool isPurchase) async => await localStorage.write("isPurchase", isPurchase);

  // >>>>> >>>>> Log Out User Database <<<<< <<<<<

  static Future<void> onLogOut() async {
    SocketServices.onDisConnect();

    await localStorage.erase();

    final identity = await PlatformDeviceId.getDeviceId ?? "";
    final fcmToken = await FirebaseMessaging.instance.getToken() ?? "";

    onSetFcmToken(identity);
    onSetIdentity(fcmToken);

    await FirebaseLogoutAuthentication.onLogout();

    await Utils.onGetRandomFakeImage();

    Get.offAllNamed(AppRoutes.loginPage);
  }

  static Future<void> onDeleteAccount() async {
    SocketServices.onDisConnect();

    await localStorage.erase();

    final identity = await PlatformDeviceId.getDeviceId ?? "";
    final fcmToken = await FirebaseMessaging.instance.getToken() ?? "";

    onSetFcmToken(identity);
    onSetIdentity(fcmToken);

    await Utils.onGetRandomFakeImage();

    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    DeleteUserModel? deleteUserModel = await DeleteUserApi.callApi(token: token, uid: uid);

    Get.close(2); // Stop Loading...

    if (deleteUserModel?.status == true) {
      await FirebaseDeleteAuthentication.onDelete();
      Get.offAllNamed(AppRoutes.loginPage);
    }
  }
}
