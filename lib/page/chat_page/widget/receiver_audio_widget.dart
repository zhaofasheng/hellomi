import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_format_audio_time.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';
import '../../../common/widget/preview_network_image_widget.dart';

class ReceiverAudioWidget extends StatefulWidget {
  const ReceiverAudioWidget({
    super.key,
    required this.id,
    required this.audio,
    required this.time,
    required this.receiverImage,
    required this.receiverImageIsBanned,
  });

  final String id;
  final String audio;
  final String time;
  final String receiverImage;
  final bool receiverImageIsBanned;

  @override
  State<ReceiverAudioWidget> createState() => _ReceiverAudioWidgetState();
}

class _ReceiverAudioWidgetState extends State<ReceiverAudioWidget> {
  AudioPlayer audioPlayer = AudioPlayer();

  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;

  RxInt audioDuration = 0.obs;
  RxInt audioCurrentDuration = 0.obs;

  final controller = Get.find<ChatController>();

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void onInit() async {
    try {
      isLoading.value = true;
      await audioPlayer.play(UrlSource(widget.audio));
      onPauseAudio();

      final Duration? duration = await audioPlayer.getDuration();

      if (duration != null) {
        audioDuration.value = duration.inSeconds;
        Utils.showLog("Audio Duration => ${audioDuration.value}");
        isLoading.value = false;
      }

      audioPlayer.onPositionChanged.listen((event) {
        audioCurrentDuration.value = event.inSeconds;
        if (controller.currentPlayAudioId != widget.id && isPlaying.value) {
          onPauseAudio();
        }
      });

      audioPlayer.onPlayerComplete.listen(
            (event) async {
          audioCurrentDuration.value = 0;
          onPauseAudio();
          await audioPlayer.play(UrlSource(widget.audio));
          onPauseAudio();
        },
      );
    } catch (e) {
      Utils.showLog("Audio Play Failed !! => $e");
    }
  }

  void onPlayAudio() async {
    isPlaying.value = true;
    audioPlayer.resume();
    controller.currentPlayAudioId = widget.id;
  }

  void onPauseAudio() {
    isPlaying.value = false;
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 🟡 左侧头像
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.secondary),
            ),
            child: ClipOval(
              child: PreviewProfileImageWidget(
                image: widget.receiverImage,
                isBanned: widget.receiverImageIsBanned,
              ),
            ),
          ),
          const SizedBox(width: 5),

          // 🟩 语音条 + 时间
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 44, minWidth: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black54,
                      ),
                    )
                        : GestureDetector(
                      onTap: () => isPlaying.value ? onPauseAudio() : onPlayAudio(),
                      child: Image.asset(
                        isPlaying.value ? AppAssets.icPause : AppAssets.icPlay,
                        width: 20,
                        height: 20,
                        color: Colors.black,
                      ),
                    )),
                    const SizedBox(width: 8),
                    Center(child: Assets.images.chatEqImg.image(height: 20)),
                    const SizedBox(width: 8),
                    Obx(() => Text(
                      CustomFormatAudioTime.convertShort(
                        isPlaying.value ? audioCurrentDuration.value : audioDuration.value,
                      ),
                      style: AppFontStyle.styleW500(Colors.black87, 12),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                FormatMessageTime.onConvert(widget.time),
                style: AppFontStyle.styleW500(HexColor('#999999'), 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
