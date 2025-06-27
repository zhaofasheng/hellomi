import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/coin_seller_page/api/con_seller_history_api.dart';
import 'package:tingle/page/coin_seller_page/api/fetch_coin_seller_profile_api.dart';
import 'package:tingle/page/coin_seller_page/api/fetch_filter_user_list_api.dart';
import 'package:tingle/page/coin_seller_page/api/purchase_coin_from_coin_trader.dart';
import 'package:tingle/page/coin_seller_page/api/validate_user_api.dart';
import 'package:tingle/page/coin_seller_page/model/fetch_coin_seller_history_model.dart';
import 'package:tingle/page/coin_seller_page/model/fetch_coin_seller_model.dart';
import 'package:tingle/page/coin_seller_page/model/filter_user_model.dart';
import 'package:tingle/page/coin_seller_page/model/purchase_coin_from_coin_trader_model.dart';
import 'package:tingle/page/host_request_page/model/validate_agency_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class CoinSellerController extends GetxController {
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  FetchCoinSellerModel? fetchCoinSellerModel;

  bool isHistoryLoading = false;
  List<History> coinSellerHistory = [];
  FetchCoinSellerHistoryModel? fetchCoinSellerHistoryModel;

  String selectedUserId = "";
  UserData? selectedUserData;

  FilterUserModel? fetchFilterUserModel;
  List<UserData> userList = [];
  bool isSearchUser = false;

  bool isValidUserName = false;
  RxBool isCheckingUserName = false.obs;
  ValidateAgencyModel? validateAgencyModel;

  PurchaseCoinFromCoinTraderModel? purchaseCoinFromCoinTraderModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await onGetCoinSellerProfile();
    await onGetUserList(search: ApiParams.All);
  }

  Future<void> onGetCoinSellerProfile() async {
    isLoading = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchCoinSellerModel = await FetchCoinSellerProfileApi.callApi(uid: uid, token: token);

    isLoading = false;
    update([AppConstant.onGetCoinSellerProfile]);
  }

  Future<void> onGetUserList({required String search}) async {
    isSearchUser = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchFilterUserModel = await FetchFilterUserListApi.callApi(uid: uid, token: token, search: search);

    userList.clear();

    userList.addAll(fetchFilterUserModel?.data ?? []);

    if (userList.length == 1 && search != ApiParams.All) selectedUserData = userList[0]; // Get Particular User Details

    isSearchUser = false;
    update([AppConstant.onGetUserList]);
  }

  Future<void> onChangeUserName({required bool isSelectedParticularUser}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    await 300.milliseconds.delay(); // Use For Old Data Clean...

    if (uniqueIdController.text.trim().isNotEmpty) {
      isCheckingUserName.value = true;

      validateAgencyModel = await ValidateUserApi.callApi(uniqueId: uniqueIdController.text.trim(), uid: uid, token: token);
      isValidUserName = validateAgencyModel?.status ?? false;

      if (isValidUserName) {
        selectedUserId = uniqueIdController.text.trim();

        if (isSelectedParticularUser == false) onGetUserList(search: selectedUserId);
      } else {
        Utils.showLog("************************************************************");
      }

      isCheckingUserName.value = false;
    } else {
      isValidUserName = false;
      isCheckingUserName.value = false;
    }

    update([AppConstant.onChangeUserName, AppConstant.onGetUserList]);
  }

  void onClickUser(UserData userData) {
    selectedUserData = userData;
    selectedUserId = userData.uniqueId ?? '';
    uniqueIdController.text = userData.uniqueId ?? '';
    searchController.clear();
    onChangeUserName(isSelectedParticularUser: true);
    Get.back(); // Close bottom sheet...
    update([AppConstant.onGetUserList]);
  }

  Future<void> onClickTransfer() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    if (uniqueIdController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtEnterUserId.name.tr);
    } else if (isValidUserName == false) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterValidUniqueId.name.tr);
    } else if (amountController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterCoinsAmount.name.tr);
    } else {
      Get.dialog(const LoadingWidget(), barrierDismissible: false); // Loading start...

      purchaseCoinFromCoinTraderModel = await PurchaseCoinFromCoinTrader.callApi(
        uid: uid,
        token: token,
        uniqueId: uniqueIdController.text.trim(),
        coinTraderId: fetchCoinSellerModel?.data?.id ?? '',
        coin: amountController.text.trim(),
      );

      Get.back(); // Loading stop...

      if (purchaseCoinFromCoinTraderModel?.status == true) {
        amountController.clear();
        uniqueIdController.clear();
        selectedUserData = null;

        onGetCoinSellerProfile();
        Utils.showToast(text: purchaseCoinFromCoinTraderModel?.message ?? '');
      } else {
        Utils.showToast(text: purchaseCoinFromCoinTraderModel?.message ?? '');
      }
    }
  }

  void onChangeUniqueId() {
    if (isValidUserName) {
      selectedUserData = null;
      isValidUserName = false;
      selectedUserId = "";
      if (userList.length == 1) onGetUserList(search: ApiParams.All); // Call Only One Time When User Change Selected Id...
      update([AppConstant.onChangeUserName, AppConstant.onGetUserList]);
    }
  }
  // ****************************************** HISTORY PAGE **********************************************

  Future<void> onRefreshHistory() async {
    FetchCoinSellerHistoryApi.startPagination = 0;
    coinSellerHistory.clear();

    await onGetCoinSellerHistory();
  }

  Future<void> onGetCoinSellerHistory() async {
    isHistoryLoading = true;
    update([ApiParams.onGetCoinSellerHistory]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchCoinSellerHistoryModel = await FetchCoinSellerHistoryApi.callApi(uid: uid, token: token, coinTraderId: fetchCoinSellerModel?.data?.id ?? '');

    coinSellerHistory.addAll(fetchCoinSellerHistoryModel?.history ?? []);

    isHistoryLoading = false;
    update([ApiParams.onGetCoinSellerHistory]);

    if (fetchCoinSellerHistoryModel?.history?.isEmpty ?? true) {
      FetchCoinSellerHistoryApi.startPagination--;
    }
  }
}
