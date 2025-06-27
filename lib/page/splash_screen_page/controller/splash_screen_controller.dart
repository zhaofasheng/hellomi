import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/common/api/fetch_user_profile_images_api.dart';
import 'package:tingle/common/function/banner_services.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/api/check_audio_room_session_api.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Utils.showLog("App Start... 11");
    init();

    super.onInit();
  }

  Future<void> init() async {
    await FetchUserProfileImagesApi.callApi();

    BranchIoServices.onListenBranchIoLinks();

    await splashScreen();
  }

  Future<void> splashScreen() async {
    Timer(
      const Duration(milliseconds: 100),
      () async {
        if (Database.isNewUser) {
          Get.offAllNamed(AppRoutes.onBoardingPage);
        } else {
          await BannerServices.onGetTypeWiseBanner(bannerType: 2); // Splash Banner
          await BannerServices.onGetTypeWiseBanner(bannerType: 3); // Home Banner

          await onGetProfile();
        }
      },
    );
  }

  Future<void> onGetProfile() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    if (uid.trim().isNotEmpty && token.trim().isNotEmpty) {
      await FetchSettingApi.callApi(uid: uid, token: token); // CALL ADMIN SETTING API

      if (FetchSettingApi.fetchSettingModel?.data != null) {
        await FetchLoginUserProfileApi.callApi(token: token, uid: uid); // CALL FETCH LOGIN USER PROFILE API
        if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user != null) {
          if (FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.isBlock == true) {
            Utils.showToast(text: EnumLocal.txtYouAreBlockedByAdmin.name.tr);
          } else {
            BannerServices.splashBannerList.isNotEmpty ? Get.offAndToNamed(AppRoutes.splashBannerPage) : Get.offAllNamed(AppRoutes.bottomBarPage);
          }
        } else {
          Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
        }
      } else if (FetchSettingApi.fetchSettingModel?.message == "User not found in the database.") {
        Utils.showToast(text: EnumLocal.txtUserNotExist.name.tr);
        Database.onLogOut();
      } else {
        Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
      }
    } else {
      Database.onLogOut();
    }
  }

  Future<void> onPrecacheAllImage(BuildContext context) async {
    await Future.wait([
      precacheImage(AssetImage(AppAssets.imgOnBoarding_1), context),
      precacheImage(AssetImage(AppAssets.imgOnBoarding_2), context),
      precacheImage(AssetImage(AppAssets.imgOnBoarding_3), context),
      precacheImage(AssetImage(AppAssets.icLogo), context),
      precacheImage(AssetImage(AppAssets.imgReferralBg), context),
    ]);
  }
}
