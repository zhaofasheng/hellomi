import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/referral_page/api/fetch_referral_system_api.dart';
import 'package:tingle/page/referral_page/api/fetch_referral_user_history_api.dart';
import 'package:tingle/page/referral_page/model/fetch_referral_system_model.dart';
import 'package:tingle/page/referral_page/model/fetch_referral_user_history_model.dart';
import 'package:tingle/utils/constant.dart';

class ReferralController extends GetxController {
  bool isLoading = false;
  List<ReferralData> referralSystem = [];
  FetchReferralSystemModel? fetchReferralSystemModel;

  bool isLoadingHistory = false;
  List<Referees> referralHistory = [];
  FetchReferralUserHistoryModel? fetchReferralUserHistoryModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetReferralSystem();
  }

  Future<void> onGetReferralSystem() async {
    isLoading = true;
    update([AppConstant.onGetReferralSystem]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchReferralSystemModel = await FetchReferralSystemApi.callApi(token: token, uid: uid);

    referralSystem = fetchReferralSystemModel?.data ?? [];

    isLoading = false;
    update([AppConstant.onGetReferralSystem]);
  }

  Future<void> onGetReferralUserHistory() async {
    isLoadingHistory = true;
    update([AppConstant.onGetReferralUserHistory]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchReferralUserHistoryModel = await FetchReferralUserHistoryApi.callApi(token: token, uid: uid);

    referralHistory = fetchReferralUserHistoryModel?.data?.referees ?? [];

    isLoadingHistory = false;
    update([AppConstant.onGetReferralUserHistory]);
  }
}
