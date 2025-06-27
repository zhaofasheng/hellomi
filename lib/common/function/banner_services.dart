import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_banner_api.dart';
import 'package:tingle/common/model/fetch_banner_model.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/on_boarding_page/view/on_boarding_view.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class BannerServices {
  static RxBool isLoading = false.obs;
  static FetchBannerModel? fetchBannerModel;

  static List<BannerData> giftBannerList = [];
  static List<BannerData> homeBannerList = [];
  static List<BannerData> gameBannerList = [];
  static List<BannerData> splashBannerList = [];

  static onInit() {}

  static Future<void> onGetTypeWiseBanner({required int bannerType}) async {
    switch (bannerType) {
      case 1:
        {
          giftBannerList = await onGetBanner(bannerType: bannerType);
          Utils.showLog("Gift Banner Length => ${splashBannerList.length}");
        }
      case 2:
        {
          splashBannerList = await onGetBanner(bannerType: bannerType);
          Utils.showLog("Splash Banner Length => ${splashBannerList.length}");
        }
      case 3:
        {
          homeBannerList = await onGetBanner(bannerType: bannerType);
          Utils.showLog("Home Banner Length => ${splashBannerList.length}");
        }
      case 4:
        {
          gameBannerList = await onGetBanner(bannerType: bannerType);
          Utils.showLog("Game Banner Length => ${splashBannerList.length}");
        }
      default:
    }
  }

  static Future<List<BannerData>> onGetBanner({required int bannerType}) async {
    isLoading.value = true;
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchBannerModel = await FetchBannerApi.callApi(uid: uid, token: token, bannerType: bannerType);
    isLoading.value = false;
    List<BannerData> bannerData = fetchBannerModel?.data ?? [];
    return bannerData;
  }
}

class DotIndicatorUi extends StatelessWidget {
  const DotIndicatorUi({super.key, required this.index, required this.length});

  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: Get.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < length; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 8,
              width: i == index ? 30 : 10,
              margin: EdgeInsets.only(left: 4),
              child: Container(
                decoration: BoxDecoration(
                  shape: i == index ? BoxShape.rectangle : BoxShape.circle,
                  color: i == index ? AppColor.white : AppColor.white.withValues(alpha: 0.3),
                  borderRadius: i == index ? BorderRadius.circular(20) : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
