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
import '../../../utils/database.dart';

class SenderAudioWidget extends StatefulWidget {
  const SenderAudioWidget({super.key, required this.id, required this.audio, required this.time});

  final String id;
  final String audio;
  final String time;

  @override
  State<SenderAudioWidget> createState() => _SenderAudioWidgetState();
}

class _SenderAudioWidgetState extends State<SenderAudioWidget> {
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
    Utils.showLog("Audio Initializing...  ${widget.audio}");

    isLoading.value = true;
    audioPlayer.audioCache.clearAll();
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
    final user = Database.fetchLoginUserProfile()?.user;
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // ✅ 顶部对齐
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// 气泡 + 时间
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 44, minWidth: 180),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : GestureDetector(
                      onTap: () => isPlaying.value ? onPauseAudio() : onPlayAudio(),
                      child: Image.asset(
                        isPlaying.value ? AppAssets.icPause : AppAssets.icPlay,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    )),
                    const SizedBox(width: 8),
                    Center(child: Assets.images.chatEqImg.image(height: 20)),
                    const SizedBox(width: 8),
                    Obx(() => Text(
                      CustomFormatAudioTime.convertShort(
                        isPlaying.value ? audioCurrentDuration.value : audioDuration.value,
                      ),
                      style: AppFontStyle.styleW500(Colors.white, 12),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                FormatMessageTime.onConvert(widget.time),
                style: AppFontStyle.styleW500(HexColor('#A8A8AC'), 8),
              ),
            ],
          ),

          const SizedBox(width: 5),

          /// 头像部分
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.secondary),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: PreviewProfileImageWidget(
                image: user?.image ?? "",
                isBanned: user?.isProfilePicBanned ?? false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
