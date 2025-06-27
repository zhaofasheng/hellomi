import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_setting_api.dart';
import 'package:tingle/common/api/fetch_user_profile_images_api.dart';
import 'package:tingle/common/model/fetch_setting_model.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';

abstract class Utils {
  static bool isDemoApp = false;

  static String appName = "Halomi";

  static final String demoAgencyId = "";
  static final String demoHostCenterId = "";

  static RxBool isAppOpen = false.obs;

  static RxBool isCurrentlyVideoPage = true.obs;

  static const int bannerShowIndex = 4;

  static RxBool isExtendBody = false.obs;

  static String defaultCountryName = "India";
  static String defaultCountryFlag = "🇮🇳";

  static RxBool isShowAudioRoomIcon = false.obs;

  static RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  static void onChangeExtendBody(bool value) async {
    await 20.milliseconds.delay();
    isExtendBody.value = value;
  }

  static String withdrawAmount = "1.00";
  static void showLog(String text) {
    log("LOG => $text");
    // print("PRINT => $text");
    // debugPrint("Debug Print => $text");
  }

  static void showToast({
    required String text,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: backgroundColor ?? AppColor.primary,
      textColor: textColor ?? AppColor.white,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void onChangeStatusBar({
    required Brightness brightness,
    int? delay,
  }) {
    showLog("Change Status Bar => Brightness => $brightness => $delay");
    Future.delayed(
      Duration(milliseconds: delay ?? 0),
      () => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: brightness,
        ),
      ),
    );
  }

  static Future<void> onGetRandomFakeImage() async {
    try {
      final List profileImageList = FetchUserProfileImagesApi.fetchUserProfileImagesModel?.data ?? [];
      int randomIndex = math.Random().nextInt(profileImageList.length);
      Database.onSetRandomProfileImage(profileImageList[randomIndex]);
      await 100.milliseconds.delay();
    } catch (e) {
      Utils.showLog("Get Random Image Failed => $e");
    }
  }

  static double waterMarkSize = 25;
  static bool isShowWaterMark = FetchSettingApi.fetchSettingModel?.data?.watermarkEnabled ?? false;
  static String waterMarkIcon = FetchSettingApi.fetchSettingModel?.data?.watermarkIcon ?? "";

  // >>>>> >>>>> WEB VIEW <<<<< <<<<<
  static final String privacyPolicyLink = FetchSettingApi.fetchSettingModel?.data?.privacyPolicyLink ?? "";
  static final String termsOfUseLink = FetchSettingApi.fetchSettingModel?.data?.termsOfUsePolicyLink ?? "";

  // >>>>> >>>>> VIDEO UPLOAD DURATION <<<<< <<<<<
  static final int shortsDuration = FetchSettingApi.fetchSettingModel?.data?.durationOfShorts ?? 0;

  // >>>>> >>>>> AGORA CREDENTIAL <<<<< <<<<<

  static String agoraAppId = FetchSettingApi.fetchSettingModel?.data?.agoraAppId ?? "";
  static String agoraCertificate = FetchSettingApi.fetchSettingModel?.data?.agoraAppCertificate ?? "";

  // >>>>> >>>>> DEEP AR CREDENTIAL <<<<< <<<<<
  static final bool isShowReelsEffect = FetchSettingApi.fetchSettingModel?.data?.shortsEffectEnabled ?? false;
  static final String effectAndroidLicenseKey = FetchSettingApi.fetchSettingModel?.data?.androidEffectLicenseKey ?? "";
  static final String effectIosLicenseKey = FetchSettingApi.fetchSettingModel?.data?.iosEffectLicenseKey ?? "";

  // >>>>> >>>>> CURRENCY <<<<< <<<<<
  static final String currencySymbol = FetchSettingApi.fetchSettingModel?.data?.currency?.symbol ?? "";
  static final String currencyCode = FetchSettingApi.fetchSettingModel?.data?.currency?.currencyCode ?? "";
  static final String countryCode = FetchSettingApi.fetchSettingModel?.data?.currency?.countryCode ?? "";

  // >>>>> >>>>> Show Payment Method <<<<< <<<<<
  static final bool isShowStripePaymentMethod = FetchSettingApi.fetchSettingModel?.data?.isStripeEnabled ?? false;
  static final bool isShowRazorPayPaymentMethod = FetchSettingApi.fetchSettingModel?.data?.isRazorpayEnabled ?? false;
  static final bool isShowFlutterWavePaymentMethod = FetchSettingApi.fetchSettingModel?.data?.isFlutterwaveEnabled ?? false;
  static final bool isShowInAppPurchasePaymentMethod = FetchSettingApi.fetchSettingModel?.data?.isGooglePlayEnabled ?? false;

  // >>>>> >>>>> RAZORPAY PAYMENT CREDENTIAL <<<<< <<<<<
  static String razorpayTestKey = FetchSettingApi.fetchSettingModel?.data?.razorSecretKey ?? "";

  // >>>>> >>>>> STRIPE PAYMENT CREDENTIAL <<<<< <<<<<
  static const String stripeUrl = "https://api.stripe.com/v1/payment_intents";
  static String stripeTestSecretKey = FetchSettingApi.fetchSettingModel?.data?.stripeSecretKey ?? "";
  static String stripeTestPublicKey = FetchSettingApi.fetchSettingModel?.data?.stripePublishableKey ?? "";

  // >>>>> >>>>> FLUTTER WAVE CREDENTIAL <<<<< <<<<<
  static String flutterWaveId = FetchSettingApi.fetchSettingModel?.data?.flutterWaveId ?? "";

  // >>>>> >>>>> Games <<<<< <<<<<
  static List<Game> games = FetchSettingApi.fetchSettingModel?.data?.game ?? [];
}

extension HeightExtension on num {
  SizedBox get height => SizedBox(height: toDouble());
}

extension WidthExtension on num {
  SizedBox get width => SizedBox(width: toDouble());
}
