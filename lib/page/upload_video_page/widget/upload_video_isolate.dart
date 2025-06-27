import 'package:get/get.dart';
import 'package:tingle/page/upload_video_page/api/upload_video_api.dart';
import 'package:tingle/page/upload_video_page/model/upload_video_model.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

@pragma('vm:entry-point')
Future<void> onUploadVideoIsolate(Map<String, dynamic> parameterMap) async {
  var parameter = UploadVideoParameterModel.fromMap(parameterMap);

  UploadVideoModel? uploadVideoModel = await UploadVideoApi.callApi(parameter: parameter);

  if (uploadVideoModel?.status == true) {
    Utils.showToast(text: parameter.successToast);
    parameter.sendPort?.send(true);
  } else {
    Utils.showToast(text: parameter.failedToast);
    parameter.sendPort?.send(false);
  }
}
