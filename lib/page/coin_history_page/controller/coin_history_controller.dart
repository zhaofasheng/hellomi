import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/coin_history_page/api/fetch_coin_history_api.dart';
import 'package:tingle/page/coin_history_page/model/fetch_coin_history_model.dart';
import 'package:tingle/utils/constant.dart';

class CoinHistoryController extends GetxController {
  bool isLoading = false;
  List<Data> coinHistory = [];
  FetchCoinHistoryModel? fetchCoinHistoryModel;

  DateTimeRange? dateTimeRange;

  String startDate = "All";
  String endDate = "All"; // This is Send on Api....
  String rangeDate = "All"; // This is Show on UI....

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    startDate = "All";
    endDate = "All";
    rangeDate = "All";
    dateTimeRange = null;

    await onGetCoinHistory();
    FetchUserCoin.init();
  }

  Future<void> onGetCoinHistory() async {
    isLoading = true;
    update([AppConstant.onGetCoinHistory]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchCoinHistoryModel = await FetchCoinHistoryApi.callApi(token: token, uid: uid, startDate: startDate, endDate: endDate);

    coinHistory = fetchCoinHistoryModel?.data ?? [];

    isLoading = false;
    update([AppConstant.onGetCoinHistory]);
  }

  Future<void> onChangeDate({required String startDate, required String endDate, required String rangeDate}) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.rangeDate = rangeDate;
    update([AppConstant.onChangeDate]);
  }
}
