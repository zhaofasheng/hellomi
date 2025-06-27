import 'package:get/get.dart';
import 'package:tingle/common/api/toggle_notification_api.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';

class SettingController extends GetxController {
  bool isShowNotification = false;

  @override
  void onInit() {
    isShowNotification = Database.fetchLoginUserProfile()?.user?.isPushNotificationEnabled ?? false;

    super.onInit();
  }

  Future<void> onSwitchNotification() async {
    isShowNotification = !isShowNotification;
    // Database.onSetNotification(isShowNotification);
    update([AppConstant.onSwitchNotification]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    await ToggleNotificationApi.callApi(token: token, uid: uid);
    await FetchLoginUserProfileApi.callApi(token: token, uid: uid);
  }
}
