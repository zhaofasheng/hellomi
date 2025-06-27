import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/common/widget/confirm_withdraw_dialog_ui.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/withdraw_page/api/create_withdraw_request_api.dart';
import 'package:tingle/page/withdraw_page/api/fetch_withdraw_method_api.dart';
import 'package:tingle/page/withdraw_page/api/fetch_withdraw_request_list_api.dart';
import 'package:tingle/page/withdraw_page/model/fetch_withdraw_method_model.dart';
import 'package:tingle/page/withdraw_page/model/create_withdraw_request_model.dart';
import 'package:tingle/page/withdraw_page/model/fetch_withdraw_request_list_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class WithdrawController extends GetxController {
  TextEditingController coinController = TextEditingController();

  final profileController = Get.find<ProfileController>();

  bool isLoading = false;
  bool isWithdrawLoading = false;
  List<Data> withdrawMethods = [];
  FetchWithdrawMethodModel? fetchWithdrawMethodModel;
  List<TextEditingController> withdrawPaymentDetails = [];
  FetchRetrieveUserPayoutsModel? fetchRetrieveUserPayoutsModel;
  List<PayoutRequest> payoutRequests = [];
  int? selectedPaymentMethod;
  bool isShowPaymentMethod = false;

  CreateWithdrawRequestModel? createWithdrawRequestModel;

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
    FetchUserCoin.init();
    await onChangeDate(endDate: "", rangeDate: 'All', startDate: "");
    await onGetCoinWithdrawHistory();
    await onGetWithdrawMethods();
  }

  Future<void> onGetWithdrawMethods() async {
    isLoading = true;
    fetchWithdrawMethodModel = await FetchWithdrawMethodApi.callApi();
    if (fetchWithdrawMethodModel?.data != null) {
      withdrawMethods.addAll(fetchWithdrawMethodModel?.data ?? []);
      isLoading = false;
      update([ApiParams.onGetWithdrawMethods]);
    }
  }

  Future<void> onSwitchWithdrawMethod() async {
    isShowPaymentMethod = !isShowPaymentMethod;
    update([ApiParams.onSwitchWithdrawMethod, ApiParams.onChangePaymentMethod]);
  }

  Future<void> onChangePaymentMethod(int index) async {
    selectedPaymentMethod = index;
    if (isShowPaymentMethod) {
      onSwitchWithdrawMethod();
    }
    withdrawPaymentDetails = List<TextEditingController>.generate(withdrawMethods[index].details?.length ?? 0, (counter) => TextEditingController());

    update([ApiParams.onChangePaymentMethod]);
  }

  Future<void> onClickWithdraw() async {
    bool isWithdrawDetailsEmpty = false;
    for (int i = 0; i < withdrawPaymentDetails.length; i++) {
      if (withdrawPaymentDetails[i].text.isEmpty) {
        isWithdrawDetailsEmpty = true;
      } else {
        isWithdrawDetailsEmpty = false;
      }
    }

    if (coinController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterWithdrawCoin.name.tr);
    } else if (int.parse(coinController.text) < (Database.fetchAdminSetting()?.data?.minCoinsForPayout ?? 0)) {
      Utils.showToast(text: EnumLocal.txtWithdrawalRequestedCoinMustBeGreaterThanSpecifiedByTheAdmin.name.tr);
    } else if (int.parse(coinController.text) > (profileController.fetchUserProfileModel?.user?.receivedCoins ?? 0)) {
      Utils.showToast(text: EnumLocal.txtTheUserDoesNotHaveSufficientFundsToMakeTheWithdrawal.name.tr);
    } else if (selectedPaymentMethod == null) {
      Utils.showToast(text: EnumLocal.txtPleaseSelectWithdrawMethod.name.tr);
    } else if (isWithdrawDetailsEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterAllPaymentDetails.name.tr);
    } else {
      ConfirmWithdrawDialogUi.onShow(() => onWithdraw());
    }
  }

  Future<void> onWithdraw() async {
    FocusManager.instance.primaryFocus?.unfocus();

    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
    List<String> details = [];

    for (int i = 0; i < withdrawMethods[selectedPaymentMethod ?? 0].details!.length; i++) {
      details.add("${withdrawMethods[selectedPaymentMethod ?? 0].details![i]}:${withdrawPaymentDetails[i].text}");
    }
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    await 1.seconds.delay();

    createWithdrawRequestModel = await CreateWithdrawRequestApi.callApi(
      loginUserId: Database.loginUserId,
      coin: coinController.text,
      paymentGateway: withdrawMethods[selectedPaymentMethod ?? 0].name ?? "",
      paymentDetails: details,
      token: token,
      uid: uid,
    );

    if (createWithdrawRequestModel?.status ?? false) {
      Utils.showToast(text: createWithdrawRequestModel?.message ?? "");
      Get.back(); // Close Withdraw Page...
    } else {
      Utils.showToast(text: createWithdrawRequestModel?.message ?? "");
    }

    Get.close(2); // Stop Loading / Close Dialog
  }

  Future<void> onChangeDate({required String startDate, required String endDate, required String rangeDate}) async {
    this.startDate = startDate;
    this.endDate = endDate;
    this.rangeDate = rangeDate;
    update([AppConstant.onChangeDate]);
  }

  Future<void> onGetCoinWithdrawHistory() async {
    isWithdrawLoading = true;
    update([AppConstant.onGetCoinHistory]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchRetrieveUserPayoutsModel = await FetchWithdrawListApi.callApi(uid: uid, token: token, endDate: endDate, startDate: startDate);

    payoutRequests = fetchRetrieveUserPayoutsModel?.payoutRequests ?? [];
    isWithdrawLoading = false;
    update([AppConstant.onGetCoinHistory]);
  }
}
