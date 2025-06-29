import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/message_page/api/fetch_message_user_api.dart';
import 'package:tingle/page/message_page/model/fetch_message_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class MessageController extends GetxController {
  ScrollController scrollController = ScrollController();

  int selectedMessageType = 0;

  bool isLoading = false;
  FetchMessageUserModel? fetchMessageUserModel;
  bool isPagination = false;
  List<MessageData> messageUsers = [];
  bool hasInit = false;
  bool isStartAnimation = false;

  @override
  void onInit() {
    Utils.showLog("Message Controller Init Success");
    super.onInit();
  }

  void init() {
    final bottomBarController = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && bottomBarController.selectedTabIndex == 3) {
      onChangeMessageType(0);
    }
  }
  void onChangeMessageType(int value) {
    if (selectedMessageType == value && hasInit) {
      return;
    }

    selectedMessageType = value;
    update([AppConstant.onChangeMessageType]);

    onRefresh(millisecondsDelay: 0);
    hasInit = true;
  }


  Future<void> onRefresh({required int millisecondsDelay}) async {
    isLoading = true;
    isStartAnimation = false;
    messageUsers.clear();
    update([AppConstant.onFetchMessageUser]);
    FetchMessageUserApi.startPagination = 0;
    await millisecondsDelay.milliseconds.delay();
    await onFetchMessageUser(type: _messageType());
  }

  Future<void> onFetchMessageUser({required String type}) async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchMessageUserModel = await FetchMessageUserApi.callApi(uid: uid, token: token, type: type);

    if (FetchMessageUserApi.startPagination == 1) messageUsers.clear();
    messageUsers.addAll(fetchMessageUserModel?.data ?? []);

    isLoading = false;
    update([AppConstant.onFetchMessageUser]);

    await 50.milliseconds.delay();
    isStartAnimation = true;
    update([AppConstant.onChangeAnimation]);

    if (fetchMessageUserModel?.data?.isEmpty ?? true) {
      FetchMessageUserApi.startPagination--;
    }
  }

  Future<void> onPaginationMessageUser() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      isPagination = true;
      update([AppConstant.onPaginationMessageUser]);
      await onFetchMessageUser(type: _messageType());
      isPagination = false;
      update([AppConstant.onPaginationMessageUser]);
    }
  }

  String _messageType() {
    switch (selectedMessageType) {
      case 0:
        return ApiParams.all;
      case 1:
        return ApiParams.online;
      case 2:
        return ApiParams.unread;
      default:
        return "";
    }
  }
}
