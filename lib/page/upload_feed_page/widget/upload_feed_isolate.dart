import 'dart:isolate';

import 'package:get/get.dart';
import 'package:tingle/page/upload_feed_page/api/upload_feed_api.dart';
import 'package:tingle/page/upload_feed_page/model/upload_feed_model.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

@pragma('vm:entry-point')
Future<void> onUploadFeedIsolate(List<dynamic> arguments) async {
  SendPort sendPort = arguments[0] as SendPort; // 0 Position Only SendPort

  UploadFeedModel? uploadFeedModel = await UploadFeedApi.callApi(
    uid: arguments[1] as String,
    token: arguments[2] as String,
    postImages: arguments[3] as List,
    caption: arguments[4] as String,
    hashTagId: arguments[5] as String,
    mentionedUserIds: arguments[6] as String,
  );

  if (uploadFeedModel?.status == true) {
    Utils.showToast(text: arguments[7]);
    sendPort.send(true);
  } else {
    sendPort.send(false);
    Utils.showToast(text: arguments[8]);
  }
}
