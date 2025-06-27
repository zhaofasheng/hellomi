import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/page/video_call_page/controller/video_call_controller.dart';
import 'package:tingle/page/video_call_page/widget/remote_camera_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';

class HostCameraWidget extends StatelessWidget {
  const HostCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      id: AppConstant.onEventHandler,
      builder: (controller) => controller.isVideoOn
          ? (controller.engine != null && controller.isLoading == false)
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: controller.engine!,
                    canvas: const VideoCanvas(uid: 0, mirrorMode: VideoMirrorModeType.videoMirrorModeAuto),
                  ),
                )
              // : LoadingWidget(color: AppColor.white),

              : VideoCallPlaceHolder(
                  image: controller.callerId == Database.loginUserId ? controller.receiverImage : controller.callerImage,
                )
          : VideoCallPlaceHolder(
              image: controller.callerId == Database.loginUserId ? controller.receiverImage : controller.callerImage,
            ),
    );
  }
}
