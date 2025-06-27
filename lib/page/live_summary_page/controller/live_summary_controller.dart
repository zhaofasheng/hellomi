import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/audio_room_page/api/stop_audio_room_api.dart';
import 'package:tingle/page/live_summary_page/api/fetch_live_summary_api.dart';
import 'package:tingle/page/live_summary_page/model/fetch_live_summary_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class LiveSummaryController extends GetxController {
  bool isLoading = false;

  FetchLiveSummaryModel? fetchLiveSummaryModel;

  String liveHistoryId = "";
  bool isStopAudioRoom = false;

  @override
  void onInit() {
    Utils.showLog("Live Summary Argument => ${Get.arguments}");

    if (Get.arguments[ApiParams.liveHistoryId] != null) liveHistoryId = Get.arguments[ApiParams.liveHistoryId];
    if (Get.arguments[ApiParams.isStopAudioRoom] != null) isStopAudioRoom = Get.arguments[ApiParams.isStopAudioRoom];

    onGetLiveSummary();
    super.onInit();
  }

  Future<void> onGetLiveSummary() async {
    isLoading = true;

    await 800.milliseconds.delay();

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchLiveSummaryModel = await FetchLiveSummaryApi.callApi(uid: uid, token: token, liveHistoryId: liveHistoryId);
    isLoading = false;
    update([AppConstant.onGetLiveSummary]);

    if (isStopAudioRoom) onStopAudioRoom();
  }

  Future<void> onStopAudioRoom() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    await StopAudioRoomApi.callApi(token: token, uid: uid);
  }
}
