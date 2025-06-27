import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:deepar_flutter_plus/deepar_flutter_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retrytech_plugin/retrytech_plugin.dart' show RetrytechPlugin;
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_thumbnail.dart';
import 'package:tingle/custom/function/custom_video_time.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/create_reels_page/api/fetch_song_api.dart';
import 'package:tingle/page/create_reels_page/api/fetch_favorite_song_api.dart';
import 'package:tingle/page/create_reels_page/api/search_sound_api.dart';
import 'package:tingle/page/create_reels_page/model/fetch_favorite_sound_model.dart';
import 'package:tingle/page/create_reels_page/model/fetch_song_model.dart';
import 'package:tingle/page/create_reels_page/model/search_sound_model.dart';
import 'package:tingle/page/create_reels_page/widget/add_music_bottom_sheet_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/utils.dart';

class CreateReelsController extends GetxController {
  // >>>>> >>>>> >>>>> Main Variable <<<<< <<<<< <<<<<

  final bool isUseEffects = Utils.isShowReelsEffect;

  bool isFlashOn = false;

  int countTime = 0;
  Timer? timer;
  int selectedDuration = 5;
  final List<int> recordingDurations = [5, 10, 15, 30];

  double? videoTime;
  String? videoImage;

  String isRecording = ApiParams.stop; // Recording Types => [start,pause,stop]

  // >>>>> >>>>> >>>>> Camera Controller <<<<< <<<<< <<<<<

  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  // >>>>> >>>>> >>>>> Camera Controller <<<<< <<<<< <<<<<

  DeepArControllerPlus deepArController = DeepArControllerPlus();

  final List effectsCollection = [
    "None",
    AppAssets.effectBrightGlasses,
    AppAssets.effectNeonDevilHorns,
    AppAssets.effectMakeupKim,
    AppAssets.effectBurningEffect,
    AppAssets.effectSpringFairy,
    AppAssets.effectBunnyEars,
    AppAssets.effectButterflyHeadband,
    AppAssets.effectCrackedPorcelainFace,
    AppAssets.effectFaceSwap,
    AppAssets.effectSequinButterfly,
    AppAssets.effectSpringDeer,
    AppAssets.effectSmallFlowers,
  ];

  final List<String> effectImages = [
    "None",
    AppAssets.imgBrightGlasses,
    AppAssets.imgNeonDevilHorns,
    AppAssets.imgMakeupKim,
    AppAssets.imgBurningEffect,
    AppAssets.imgSpringFairy,
    AppAssets.imgBunnyEars,
    AppAssets.imgButterflyHeadband,
    AppAssets.imgCrackedPorcelainFace,
    AppAssets.imgFaceSwap,
    AppAssets.imgSequinButterfly,
    AppAssets.imgSmallFlowers,
    AppAssets.imgSpringDeer,
  ];

  final List<String> effectNames = [
    "None",
    "Bright Glasses",
    "Neon Devil Horns",
    "Makeup Kim",
    "Burning Effect",
    "Spring Fairy",
    "Bunny Ears",
    "Butterfly Headband",
    "Cracked Porcelain Face",
    "Face Swap",
    "Sequin Butterfly",
    "Spring Deer",
    "Small Flowers",
  ];

  final List effectsImageCollection = [];

  bool isShowEffects = false;

  int selectedEffectIndex = 0;

  InitializeResult? initializeResult;

  bool isFrontCamera = false;

  // >>>>> >>>>> >>>>> Initialize Method <<<<< <<<<< <<<<<

  @override
  void onInit() {
    Utils.showLog("Argument => ${Get.arguments}");

    if (Get.arguments != null) {
      selectedSound = Get.arguments;
      initAudio(selectedSound?[ApiParams.link] ?? "");
    }
    onGetPermission();
    super.onInit();
  }

  @override
  void onClose() {
    if (isUseEffects) {
      onDisposeEffect();
    } else {
      onDisposeCamera();
    }
    super.onClose();
  }

  Future<void> onGetPermission() async {
    AppPermission.onGetCameraPermission(
      onGranted: () {
        AppPermission.onGetMicrophonePermission(
          onGranted: () {
            if (isUseEffects) {
              onInitializeEffect();
            } else {
              onInitializeCamera();
            }
          },
        );
      },
    );
  }

  // >>>>> >>>>> >>>>> Camera Controller Method <<<<< <<<<< <<<<<

  Future<void> onInitializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.last; // Use the first available camera
      cameraController = CameraController(camera, ResolutionPreset.medium);
      await cameraController?.initialize();
      update([AppConstant.onInitializeCamera]);
    } catch (e) {
      Utils.showLog("Error initializing camera: $e");
    }
  }

  Future<void> onDisposeCamera() async {
    cameraController?.dispose();
    cameraController = null;
    cameraController?.removeListener(cameraControllerListener);

    Utils.showLog("Camera Controller Dispose Success");
  }

  Future<void> cameraControllerListener() async {
    Utils.showLog("Change Camera Event => ${cameraController?.value}");
  }

  Future<void> onSwitchFlash() async {
    if (cameraLensDirection == CameraLensDirection.back) {
      if (isFlashOn) {
        isFlashOn = false;
        await cameraController?.setFlashMode(FlashMode.off);
      } else {
        isFlashOn = true;
        await cameraController?.setFlashMode(FlashMode.torch);
      }
      update([AppConstant.onSwitchFlash]);
    }
  }

  Future<void> onSwitchCamera() async {
    Utils.showLog("Switch Normal Camera Method Calling....");

    if (isRecording == ApiParams.stop) {
      Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
      if (isFlashOn) {
        onSwitchFlash();
      }

      cameraLensDirection = cameraLensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
      final cameras = await availableCameras();
      final camera = cameras.firstWhere((camera) => camera.lensDirection == cameraLensDirection);
      cameraController = CameraController(camera, ResolutionPreset.high);
      await cameraController?.initialize();
      update([AppConstant.onInitializeCamera]);
      Get.back(); // Stop Loading...
    } else {
      Utils.showLog("Please Try After Complete Video Recording...");
    }
  }

  Future<void> onStartRecording() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
        onRestartAudio();
        await cameraController?.startVideoRecording();
        Get.back(); // Stop Loading...
        if (cameraController!.value.isRecordingVideo) {
          onChangeRecordingEvent(ApiParams.start);
          Utils.showLog("Video Recording Starting....");
        }
      }
    } catch (e) {
      onPauseAudio();
      onChangeRecordingEvent(ApiParams.stop);
      Utils.showLog("Recording Starting Error => $e");
    }
  }

  Future<void> onPauseRecording() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
        onPauseAudio();
        await cameraController!.pauseVideoRecording();
        Get.back(); // Stop Loading...
        if (cameraController!.value.isRecordingPaused) {
          onChangeRecordingEvent(ApiParams.pause);
          Utils.showLog("Video Recording Pausing....");
        }
      }
    } catch (e) {
      onChangeRecordingEvent(ApiParams.stop);
      Utils.showLog("Recording Pausing Error => $e");
    }
  }

  Future<void> onResumeRecording() async {
    try {
      if (cameraController != null && cameraController!.value.isInitialized) {
        Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
        onResumeAudio();
        await cameraController!.resumeVideoRecording();
        Get.back(); // Stop Loading...
        if (cameraController!.value.isRecordingPaused) {
          onChangeRecordingEvent(ApiParams.start);
          Utils.showLog("Video Recording Resume....");
        }
      }
    } catch (e) {
      onPauseAudio();
      onChangeRecordingEvent(ApiParams.stop);
      Utils.showLog("Video Recording Resume Error => $e");
    }
  }

  Future<String?> onStopRecording() async {
    XFile? videoUrl;
    if (Get.currentRoute == AppRoutes.createReelsPage) {
      try {
        if (isFlashOn) {
          onSwitchFlash();
        }
        Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
        onPauseAudio();
        videoUrl = await cameraController!.stopVideoRecording();
        Get.back(); // Stop Loading...
        onChangeRecordingEvent(ApiParams.stop);
        Utils.showLog("Recording Video Path => ${videoUrl.path}");
        return videoUrl.path;
      } catch (e) {
        onChangeRecordingEvent(ApiParams.stop);
        Utils.showLog("Recording Stop Failed !! => $e");
        return null;
      }
    } else {
      onChangeRecordingEvent(ApiParams.stop);
      Utils.showLog("User Back To Create Reels Page....");
      return null;
    }
  }

  Future<void> onClickRecordingButton() async {
    if (isRecording == ApiParams.stop) {
      onChangeRecordingEvent(ApiParams.start);
      onChangeTimer();
      onStartRecording();
    } else if (isRecording == ApiParams.start) {
      onChangeRecordingEvent(ApiParams.pause);
      onChangeTimer();
      onPauseRecording();
    } else if (isRecording == ApiParams.pause) {
      onChangeRecordingEvent(ApiParams.start);
      onChangeTimer();
      onResumeRecording();
    }
  }

  // >>>>> >>>>> >>>>> Effect Controller Method <<<<< <<<<< <<<<<

  Future<void> onInitializeEffect() async {
    try {
      Utils.showLog("Effect Controller Initializing...");

      initializeResult = await deepArController.initialize(
        androidLicenseKey: Utils.effectAndroidLicenseKey,
        iosLicenseKey: Utils.effectIosLicenseKey,
        resolution: Resolution.medium,
      );

      isFrontCamera = true;
      update([AppConstant.onInitializeEffect]);

      Utils.showLog("Effect Controller Initialize => $initializeResult");
    } catch (e) {
      Utils.showLog("Effect Controller Initialize Failed => $e");
    }
  }

  Future<void> onDisposeEffect() async {
    deepArController.destroy();
    deepArController = DeepArControllerPlus();
    initializeResult = null;
    update([AppConstant.onInitializeEffect]);
    Utils.showLog("Effect Controller Dispose Success");
  }

  Future<void> onSwitchEffectFlash() async {
    if (isFrontCamera == false) {
      if (isFlashOn) {
        isFlashOn = false;
        await deepArController.toggleFlash();
      } else {
        isFlashOn = true;
        await deepArController.toggleFlash();
      }
      update([AppConstant.onSwitchEffectFlash]);
    }
  }

  Future<void> onSwitchEffectCamera() async {
    if (isRecording == ApiParams.stop) {
      Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
      if (isFlashOn) {
        onSwitchEffectFlash();
      }

      try {
        await deepArController.flipCamera();
        isFrontCamera = !isFrontCamera;
      } catch (e) {
        Utils.showLog("Effect Flip Camera Failed !! =>$e");
      }

      Get.back(); // Stop Loading...
    } else {
      Utils.showLog("Please Try After Complete Video Recording...");
    }
  }

  Future<void> onToggleEffect() async {
    isShowEffects = !isShowEffects;
    update([AppConstant.onToggleEffect]);
  }

  Future<void> onChangeEffect(int index) async {
    try {
      selectedEffectIndex = index;
      update([AppConstant.onChangeEffect]);
      await deepArController.switchEffect(effectsCollection[selectedEffectIndex]);
    } catch (e) {
      Utils.showLog("Switch Effect Failed => $e");
    }
  }

  Future<void> onClearEffect(int index) async {
    try {
      if (selectedEffectIndex != 0) {
        selectedEffectIndex = index;
        onDisposeEffect();
        onInitializeEffect();
        update([AppConstant.onChangeEffect]);
      }
    } catch (e) {
      Utils.showLog("Clear Effect Failed => $e");
    }
  }

  Future<void> onStartEffectRecording() async {
    try {
      if (initializeResult?.success == true) {
        if (isShowEffects) {
          onToggleEffect();
        }
        onRestartAudio();
        await deepArController.startVideoRecording();
        onChangeRecordingEvent(ApiParams.start);
        Utils.showLog("Video Recording Starting....");
      }
    } catch (e) {
      onPauseAudio();
      onChangeRecordingEvent(ApiParams.stop);
      Utils.showLog("Recording Starting Error => $e");
    }
  }

  Future<String?> onStopEffectRecording() async {
    XFile? videoUrl;
    if (Get.currentRoute == AppRoutes.createReelsPage) {
      try {
        if (isFlashOn) {
          onSwitchEffectFlash();
        }
        Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...

        onPauseAudio();
        final file = await deepArController.stopVideoRecording();
        videoUrl = XFile(file.path);

        Get.back(); // Stop Loading...

        onChangeRecordingEvent(ApiParams.stop);
        Utils.showLog("Recording Video Path => ${videoUrl.path}");

        return videoUrl.path;
      } catch (e) {
        onChangeRecordingEvent(ApiParams.stop);
        Utils.showLog("Recording Stop Failed !! => $e");
        return null;
      }
    } else {
      onChangeRecordingEvent(ApiParams.stop);
      Utils.showLog("User Back To Create Reels Page....");
      return null;
    }
  }

  Future<void> onLongPressStart(LongPressStartDetails details) async {
    onChangeRecordingEvent(ApiParams.start);
    onChangeTimer();
    onStartEffectRecording();
  }

  Future<void> onLongPressEnd(LongPressEndDetails details) async {
    onChangeRecordingEvent(ApiParams.stop);
    onChangeTimer();
    final videoPath = await onStopEffectRecording();
    if (videoPath != null) {
      onPreviewVideo(videoPath);
    }
  }

  //  >>>>> >>>>> >>>>>  Video Duration Method <<<<< <<<<< <<<<<

  Future<void> onChangeTimer() async {
    if (isRecording == ApiParams.start) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          if (isRecording == ApiParams.start && countTime <= selectedDuration) {
            countTime++;
            update([AppConstant.onChangeTimer, AppConstant.onChangeRecordingEvent]);
            if (countTime == selectedDuration) {
              {
                countTime = 0;
                timer.cancel();
                onChangeRecordingEvent(ApiParams.stop);
                final videoPath = isUseEffects ? await onStopEffectRecording() : await onStopRecording();
                if (videoPath != null) {
                  onPreviewVideo(videoPath);
                }
              }
            }
          }
        },
      );
    } else if (isRecording == ApiParams.pause) {
      timer?.cancel();
      update([AppConstant.onChangeTimer, AppConstant.onChangeRecordingEvent]);
    } else {
      countTime = 0;
      timer?.cancel();
      onChangeRecordingEvent(ApiParams.stop);
      update([AppConstant.onChangeTimer, AppConstant.onChangeRecordingEvent]);
    }
  }

  Future<void> onChangeRecordingDuration(int index) async {
    selectedDuration = recordingDurations[index];
    update([AppConstant.onChangeRecordingDuration]);
  }

  Future<void> onChangeRecordingEvent(String type) async {
    isRecording = type;
    update([AppConstant.onChangeRecordingEvent]);
  }

  //  >>>>> >>>>> >>>>>  Preview Video Method <<<<< <<<<< <<<<<

  Future<String?> onRemoveAudio(String videoPath) async {
    final String videoWithoutAudioPath = '${(await getTemporaryDirectory()).path}/RM_${DateTime.now().millisecondsSinceEpoch}.mp4';
    // final ffmpegRemoveAudioCommand = '-i $videoPath -c copy -an $videoWithoutAudioPath';
    // final sessionRemoveAudio = await FFmpegKit.executeAsync(ffmpegRemoveAudioCommand);
    // final returnCodeRemoveAudio = await sessionRemoveAudio.getReturnCode();
    Utils.showLog("Remove Audio Path => $videoWithoutAudioPath");
    // Utils.showLog("Return Code => $returnCodeRemoveAudio");
    return videoWithoutAudioPath;
  }

  Future<String?> onMergeAudioWithVideo(String videoPath, String audioPath) async {
    final String path = '${(await getTemporaryDirectory()).path}/FV_${DateTime.now().millisecondsSinceEpoch}.mp4';

    videoTime = (await CustomVideoTime.onGet(videoPath) ?? 0).toDouble();

    final soundTime = (await onGetSoundTime(audioPath) ?? 0);

    if (soundTime != 0 && videoTime != null && videoTime != 0) {
      Utils.showLog("Audio Time => $soundTime Video Time => $videoTime");

      // final minTime = (videoTime! < soundTime) ? videoTime : soundTime;

      // final command = '-i $videoPath -i $audioPath -t $minTime -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 $path';
      // final sessionRemoveAudio = await FFmpegKit.executeAsync(command);
      // final returnCodeRemoveAudio = await sessionRemoveAudio.getReturnCode();

      await RetrytechPlugin().applyFilterAndAudioToVideo(inputPath: videoPath, outputPath: path, audioPath: audioPath);

      Utils.showLog("Merge Video Path => $path");
      // Utils.showLog("Return Code => $returnCodeRemoveAudio");
      return path;
    } else {
      return null;
    }
  }

  Future<void> onClickPreviewButton() async {
    Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
    onChangeRecordingEvent(ApiParams.stop);
    onChangeTimer();
    final videoPath = await onStopRecording();
    Get.back(); // Stop Loading...
    if (videoPath != null) {
      onPreviewVideo(videoPath);
    }
  }

  Future<void> onPreviewVideo(String videoPath) async {
    Get.dialog(barrierDismissible: false, const LoadingWidget()); // Start Loading...
    videoImage = await CustomThumbnail.onGet(videoPath);
    if (selectedSound != null) {
      Utils.showLog("Removing Audio From Video...");

      Utils.showToast(text: EnumLocal.txtPleaseWaitSomeTime.name.tr);

      // final removeVideoPath = await onRemoveAudio(videoPath);
      // await 2.seconds.delay();

      // if (removeVideoPath != null) {
      final mergeVideoPath = await onMergeAudioWithVideo(videoPath, selectedSound?[ApiParams.link]);
      await 5.seconds.delay();
      Get.back(); // Stop Loading...

      if (mergeVideoPath != null && videoTime != null && videoImage != null) {
        Utils.showLog("Video Path => $mergeVideoPath");
        Utils.showLog("Video Image => $videoImage");
        Utils.showLog("Video Time => $videoTime");

        Get.offAndToNamed(
          AppRoutes.previewCreatedReelsPage,
          arguments: {
            ApiParams.video: mergeVideoPath,
            ApiParams.image: videoImage,
            ApiParams.time: videoTime?.toInt(),
            ApiParams.songId: selectedSound?[ApiParams.id_] ?? "",
          },
        );
      } else {
        Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Get Video Image/Video Time Failed !!");
      }
      // }
      // else {
      //   Get.back(); // Stop Loading...
      // }
    } else {
      videoTime = (await CustomVideoTime.onGet(videoPath) ?? 0).toDouble();
      Get.back(); // Stop Loading...

      if (videoTime != null && videoImage != null) {
        Utils.showLog("Video Path => $videoPath");
        Utils.showLog("Video Image => $videoImage");
        Utils.showLog("Video Time => $videoTime");

        Get.offAndToNamed(
          AppRoutes.previewCreatedReelsPage,
          arguments: {
            ApiParams.video: videoPath,
            ApiParams.image: videoImage,
            ApiParams.time: videoTime?.toInt(),
            ApiParams.songId: "",
          },
        );
      } else {
        Utils.showToast(text: EnumLocal.txtSomeThingWentWrong.name.tr);
        Utils.showLog("Get Video Image/Video Time Failed !!");
      }
    }
  }

  //  >>>>> >>>>> >>>>>  Music Bottom Sheet <<<<< <<<<< <<<<<

  final AudioPlayer _audioPlayer = AudioPlayer();

  Map? selectedSound;

  int selectedTabIndex = 0;
  TextEditingController searchController = TextEditingController();
  final List soundTabPages = [const DiscoverTabUi(), const FavouriteTabUi()];

  bool isLoadingSound = true;
  List<SongData> mainSoundCollection = [];
  FetchSongModel? fetchSongModel;

  bool isLoadingFavoriteSound = true;
  List<FavoriteSongs> favoriteSoundCollection = [];
  FetchFavoriteSoundModel? fetchFavoriteSoundModel;
  ScrollController favoriteSoundController = ScrollController();

  bool isSearching = false;
  SearchSoundModel? searchSoundModel;
  List<SearchData> searchSounds = [];
  bool isSearchLoading = false;

  RxBool isPlaying = false.obs;
  RxString selectedSongId = "".obs;
  AudioPlayer audioPlayerForCheckMusic = AudioPlayer();

  void onClickPlayButton(String id, String songUrl) async {
    if (selectedSongId.value == id) {
      if (isPlaying.value) {
        isPlaying.value = false;
        audioPlayerForCheckMusic.pause();
      } else {
        isPlaying.value = true;
        await audioPlayerForCheckMusic.release();
        await audioPlayerForCheckMusic.setSource(UrlSource(songUrl));
        audioPlayerForCheckMusic.resume();
      }
    } else {
      selectedSongId.value = id;
      isPlaying.value = true;
      if (selectedSongId != "") {
        await audioPlayerForCheckMusic.release();
      }
      audioPlayerForCheckMusic.play(UrlSource(songUrl));
    }
  }

  Future<void> onChangeTabBar(int index) async {
    selectedTabIndex = index;
    if (index == 0) {
      initAllSound();
    } else if (index == 1) {
      initFavoriteSound();
    }
    update([AppConstant.onChangeTabBar]);
  }

  void onChangeSearchEvent() {
    if (searchController.text.trim().isEmpty) {
      isSearching = false;
      update([AppConstant.onChangeSearchEvent]);
    } else if (searchController.text.trim().length == 1) {
      isSearching = true;
      update([AppConstant.onChangeSearchEvent]);
    }
  }

  Future<void> onSearchSound() async {
    onChangeSearchEvent();
    if (searchController.text.trim().isNotEmpty) {
      Utils.showLog("Search Sound Method Calling...");

      isSearchLoading = true;
      update([AppConstant.onSearchSound]);

      final uid = FirebaseUid.onGet() ?? "";
      final token = await FirebaseAccessToken.onGet() ?? "";

      searchSoundModel = await SearchSoundApi.callApi(token: token, uid: uid, searchString: searchController.text);

      if (searchSoundModel?.searchData != null) {
        searchSounds.clear();
        searchSounds.addAll(searchSoundModel?.searchData ?? []);
        isSearchLoading = false;
        update([AppConstant.onSearchSound]);
      }
    }
  }

  Future<void> initAllSound() async {
    mainSoundCollection.clear();

    onGetAllSound();
  }

  Future<void> onGetAllSound() async {
    if (mainSoundCollection.isEmpty) {
      isLoadingSound = true;
      update([AppConstant.onGetAllSound]);
    }

    fetchSongModel = null;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchSongModel = await FetchSongApi.callApi(token: token, uid: uid);

    isLoadingSound = false;
    mainSoundCollection.addAll(fetchSongModel?.data ?? []);

    Utils.showLog("All Sound Length => ${mainSoundCollection.length}");

    update([AppConstant.onGetAllSound]);
  }

  Future<void> initFavoriteSound() async {
    favoriteSoundCollection.clear();
    FetchFavoriteSongApi.startPagination = 0;
    onGetFavoriteSound();
  }

  Future<void> onGetFavoriteSound() async {
    if (favoriteSoundCollection.isEmpty) {
      isLoadingFavoriteSound = true;
      update([AppConstant.onGetFavoriteSound]);
    }

    fetchFavoriteSoundModel = null;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchFavoriteSoundModel = await FetchFavoriteSongApi.callApi(token: token, uid: uid);

    if (fetchFavoriteSoundModel?.songs != null) {
      isLoadingFavoriteSound = false;

      favoriteSoundCollection.addAll(fetchFavoriteSoundModel?.songs ?? []);

      Utils.showLog("Favorite Sound Length => ${favoriteSoundCollection.length}");
    }
    update([AppConstant.onGetFavoriteSound]);
  }

  Future<void> onChangeSound(Map sound) async {
    if (selectedSound?[ApiParams.id_] == sound[ApiParams.id_]) {
      selectedSound = null;
    } else {
      selectedSound = {
        ApiParams.id_: sound[ApiParams.id_],
        ApiParams.name: sound[ApiParams.name],
        ApiParams.image: sound[ApiParams.image],
        ApiParams.link: sound[ApiParams.link],
      };
      initAudio(sound[ApiParams.link]);
    }
    update([AppConstant.onChangeSound]);
  }

  Future<double?> onGetSoundTime(String audioPath) async {
    await _audioPlayer.setSourceUrl(audioPath);
    Duration? audioDuration = await _audioPlayer.getDuration();
    final audioTime = audioDuration?.inSeconds.toDouble();
    Utils.showLog("Selected Audio Time => $audioTime");
    return audioTime;
  }

  // >>>>> >>>>> >>>>> Play Sound Variable <<<<< <<<<< <<<<<

  AudioPlayer audioPlayer = AudioPlayer();

  void initAudio(String audio) async {
    try {
      await audioPlayer.setSource(UrlSource(audio));
    } catch (e) {
      Utils.showLog("Audio Play Failed !! => $e");
    }
  }

  void onResumeAudio() {
    if (selectedSound != null) {
      try {
        audioPlayer.resume();
      } catch (e) {
        Utils.showLog("Audio Resume Error => $e");
      }
    }
  }

  void onRestartAudio() {
    if (selectedSound != null) {
      try {
        audioPlayer.seek(Duration(milliseconds: 0));
        audioPlayer.resume();
      } catch (e) {
        Utils.showLog("Audio Restart Error => $e");
      }
    }
  }

  void onPauseAudio() {
    if (selectedSound != null) {
      try {
        audioPlayer.pause();
      } catch (e) {
        Utils.showLog("Audio Pause Error => $e");
      }
    }
  }
}
