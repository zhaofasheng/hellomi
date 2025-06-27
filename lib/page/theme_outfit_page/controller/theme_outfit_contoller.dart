import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/connection_page/model/fetch_visitor_model.dart';
import 'package:tingle/page/connection_page/model/search_connection_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class ThemeOutfitController extends GetxController with GetTickerProviderStateMixin {
  int currentIndex = 0;
  RxBool isLoading = false.obs;
  TabController? outfitTabController;

  var argument;

  @override
  void onInit() {
    argument = Get.arguments;
    init();

    super.onInit();
  }

  RxString mainTitle = EnumLocal.txtFriends.name.tr.obs;
  RxInt selectedCount = 0.obs;
  onTabChange(int index) async {
    currentIndex = index;
    update();
    update([AppConstant.onTabBarTap]);
  }

  int tabIndex = 0;
  Future<void> onGetData() async {
    isLoading.value = true;

    final token = await FirebaseAccessToken.onGet() ?? "";
    final uid = FirebaseUid.onGet() ?? "";

    // followerFollowingModel = await FetchGetSocialListsApi.callApi(
    //   userId: uid,
    //   token: token,
    // );
    // visitorModel = await FetchVisitorApi.callApi(
    //   userId: uid,
    //   token: token,
    // );

    // friends.addAll(followerFollowingModel!.friends!);
    // following.addAll(followerFollowingModel!.following!);
    // followers.addAll(followerFollowingModel!.followers!);

    isLoading.value = false;
    update();
  }

  bool isLoadingPagination = false;

  Future<void> init() async {
    isLoading.value = true;
    update([ApiParams.outfitUpdate]);
    log("tabIndex :: ${argument}");
    log("tabIndex1 12 :: ${(argument["TabIndex"] ?? 0)}");
    tabIndex = Get.arguments[ApiParams.tabIndex] ?? 0;
    outfitTabController = await TabController(length: 3, vsync: this, initialIndex: tabIndex);

    outfitTabController!.addListener(
      () {
        onTabChange(outfitTabController!.index);
      },
    );

    onGetData();
    isLoading.value = false;
    update([ApiParams.outfitUpdate]);
  }
}
