import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/banner_services.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../page/stream_page/model/fetch_live_user_model.dart';

class ShowReceivedBanner {
  static bool isGiftProcessRunning = false;
  static RxBool isShow = false.obs;
  static RxDouble senderDetailsPosition = (-500.0).obs;
  static RxList<BannerModel> bannerList = <BannerModel>[].obs;
  static String randomBannerImage = "";

  static void onGetNewBanner(BannerModel bannerModel) {
    Utils.showLog("GET NEW BANNER => ${bannerModel.senderName}");

    Utils.showLog("Previous Banner Collection => ${bannerList.length}");

    bannerList.add(bannerModel);

    Utils.showLog("After Add Banner Collection => ${bannerList.length}");

    if (isGiftProcessRunning == false) onShowGiftTime();
  }

  static Future<void> onShowGiftTime() async {
    if (bannerList.isNotEmpty) {
      Utils.showLog("Banner Show Running....");

      randomBannerImage = BannerServices.giftBannerList[Random().nextInt(BannerServices.giftBannerList.length)].imageUrl ?? "";

      isGiftProcessRunning = true;

      isShow.value = true;
      senderDetailsPosition.value = -500;

      await 50.milliseconds.delay();

      senderDetailsPosition.value = (0.5);

      await 4000.milliseconds.delay();

      senderDetailsPosition.value = Get.width;

      await Future.delayed(Duration(seconds: 1));

      isShow.value = false;

      await Future.delayed(Duration(seconds: 1));

      senderDetailsPosition.value = -500;

      if (bannerList.isNotEmpty) bannerList.removeAt(0);

      await 500.milliseconds.delay();

      Utils.showLog("Banner Show Complete....");

      Utils.showLog("My After Remove Banner Collection => ${bannerList.length}");

      if (bannerList.isEmpty) isGiftProcessRunning = false;
      if (isGiftProcessRunning) onShowGiftTime();
    }
  }

  static Widget onShowSenderDetails() {
    return Obx(
      () => isShow.value
          ? AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              right: senderDetailsPosition.value,
              curve: Curves.easeInOut,
              child: bannerList.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        print("********************** ${bannerList[0].isGiftBanner}---------- ${bannerList[0].liveType}");

                        if (Get.currentRoute != AppRoutes.livePage && Get.currentRoute != AppRoutes.audioRoomPage) {
                          if (bannerList[0].isGiftBanner && bannerList[0].liveType == 1) {
                            Get.toNamed(
                              AppRoutes.livePage,
                              arguments: {
                                ApiParams.isHost: false,
                                ApiParams.isChannelMediaRelay: (bannerList[0].liveUserList.host2LiveId != null && (bannerList[0].liveUserList.host2LiveId?.trim().isNotEmpty ?? false)),
                                ApiParams.host2Uid: (100000 + Random().nextInt(900000)),
                                ApiParams.liveUserList: bannerList[0].liveUserList,
                              },
                            );
                          } else if (bannerList[0].isGiftBanner && bannerList[0].liveType == 3) {
                            Get.toNamed(
                              AppRoutes.livePage,
                              arguments: {
                                ApiParams.isHost: false,
                                ApiParams.isChannelMediaRelay: (bannerList[0].liveUserList.host2LiveId != null && (bannerList[0].liveUserList.host2LiveId?.trim().isNotEmpty ?? false)),
                                ApiParams.host2Uid: (100000 + Random().nextInt(900000)),
                                ApiParams.liveUserList: bannerList[0].liveUserList,
                              },
                            );
                          } else if (bannerList[0].isGiftBanner && bannerList[0].liveType == 2) {
                            Get.toNamed(
                              AppRoutes.audioRoomPage,
                              arguments: {
                                ApiParams.isHost: false,
                                ApiParams.userUid: (100000 + Random().nextInt(900000)),
                                ApiParams.liveUserList: bannerList[0].liveUserList,
                              },
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 200,
                        width: Get.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(color: AppColor.transparent),
                        child: Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              width: Get.width,
                              child: PreviewPostImageWidget(
                                image: randomBannerImage,
                                isShowPlaceHolder: false,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 25, left: 100, right: 80),
                              alignment: Alignment.center,
                              color: AppColor.transparent,
                              child: Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: bannerList[0].isGiftBanner
                                        ? PreviewProfileImageWidget(
                                            image: bannerList[0].senderImage,
                                            isBanned: bannerList[0].senderProfilePicBanned,
                                          )
                                        : PreviewProfileImageWidget(
                                            image: bannerList[0].image,
                                            isBanned: false,
                                          ),
                                  ),
                                  5.width,
                                  Flexible(
                                    child: Text(
                                      bannerList[0].isGiftBanner ? "${bannerList[0].senderName} send ${bannerList[0].giftCoin} Coin(s) to ${bannerList[0].receiverName}" : bannerList[0].message,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.styleW700(AppColor.white, 8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Offstage(),
            )
          : Offstage(),
    );
  }
}

class BannerModel {
  bool isGiftBanner; // True => Gift False => Game

  // Gift Parameter

  int giftType;
  int liveType;
  String giftUrl;
  int giftCount;
  int giftCoin;
  String senderName;
  String senderImage;
  bool senderProfilePicBanned;
  String senderUniqueId;
  String receiverName;
  LiveUserList liveUserList;

  // Game Parameter

  String message;
  String image;

  BannerModel({
    required this.isGiftBanner,
    required this.liveType,
    required this.giftType,
    required this.giftUrl,
    required this.giftCount,
    required this.giftCoin,
    required this.senderName,
    required this.senderImage,
    required this.senderProfilePicBanned,
    required this.senderUniqueId,
    required this.receiverName,
    required this.message,
    required this.image,
    required this.liveUserList,
  });
}
