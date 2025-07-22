import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';                  // 保留你的 GetX 主要功能
import 'package:dio/dio.dart' as dio;          // Dio 网络请求，带前缀避免冲突
import 'package:http_parser/http_parser.dart'; // 用于 MediaType 设置 Content-Type
import 'package:image_picker/image_picker.dart';

// 你项目里其他常用的导入，保持不变
import 'package:tingle/common/api/visit_profile_api.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_page/model/fetch_video_model.dart';
import 'package:tingle/page/preview_user_profile_page/api/fetch_user_wise_post_api.dart';
import 'package:tingle/page/preview_user_profile_page/api/fetch_user_wise_video_api.dart';
import 'package:tingle/page/profile_page/api/fetch_other_user_profile_api.dart';
import 'package:tingle/page/profile_page/api/fetch_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';
import '../../../common/api_service.dart';
import '../../../custom/function/custom_image_picker.dart';
import '../../../custom/widget/custom_image_picker_bottom_sheet_widget.dart';

class PreviewUserProfileController extends GetxController {
  // GET ARGUMENTS...
  String userId = "";

  bool isLoading = false;
  FetchUserProfileModel? fetchUserProfileModel;

  int selectedTabIndex = 0;
  bool isShowAppBar = false;
  ScrollController scrollController = ScrollController();

  ScrollController postScrollController = ScrollController();
  ScrollController videoScrollController = ScrollController();

  FetchPostModel? fetchPostModel;
  List<Post> userPosts = [];
  bool isLoadingPost = false;
  bool isPostPagination = false;

  FetchVideoModel? fetchVideoModel;
  List<VideoData> userVideos = [];
  bool isLoadingVideo = false;
  bool isVideoPagination = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      userId = Get.arguments;
    }

    scrollController.addListener(onScroll);
    postScrollController.addListener(onPostPagination);
    videoScrollController.addListener(onVideoPagination);

    init();
    super.onInit();
  }

  void onPickImage({required BuildContext context}) async {
    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
        if (imagePath != null) {
          uploadPickedImage(imagePath);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (imagePath != null) {
          uploadPickedImage(imagePath);
        }
      },
    );
  }


  Future<void> uploadPickedImage(String imagePath) async {
    final file = File(imagePath);
    final fileName = file.uri.pathSegments.last; // 取文件名

    // 获取文件扩展名（如 .jpg）
    final extension = file.path.split('.').last.toLowerCase();

    // 简单的扩展名 -> MIME 映射
    String? mimeType;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'webp':
        mimeType = 'image/webp';
        break;
      case 'gif':
        mimeType = 'image/gif';
        break;
      case 'heic':
        mimeType = 'image/heic';
        break;
      default:
        mimeType = 'application/octet-stream'; // 默认通用二进制
    }

    final formData = dio.FormData.fromMap({
      'image': await dio.MultipartFile.fromFile(
        imagePath,
        filename: fileName,
        contentType: MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
      ),
    });

    final response = await ApiService().post(Api.appupbackGroundUrl, data: formData);
    if (response != null) {
      print('✅ 上传成功: ${response.data}');
      update([AppConstant.onPickImage]);
    } else {
      print('❌ 上传失败');
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(onScroll);
    postScrollController.removeListener(onPostPagination);
    videoScrollController.removeListener(onVideoPagination);
    super.onClose();
  }

  void init() async {
    onGetProfile();
    onRefreshPost();
    onRefreshVideo();
    onVisitProfile();
  }

  void onVisitProfile() async {
    if (userId != Database.loginUserId) {
      final uid = FirebaseUid.onGet() ?? "";
      final token = await FirebaseAccessToken.onGet() ?? "";
      await VisitProfileApi.callApi(token: token, uid: uid, profileOwnerId: userId);
    }
  }

  void onScroll() {
    onToggleAppBar(scrollController.position.pixels != scrollController.position.minScrollExtent);
  }

  void onToggleAppBar(bool value) async {
    isShowAppBar = value;
    await 10.milliseconds.delay();
    update([AppConstant.onToggleAppBar]);
    Utils.onChangeStatusBar(brightness: isShowAppBar ? Brightness.dark : Brightness.light, delay: 0);
  }

  Future<void> onGetProfile() async {
    isLoading = true;
    update([AppConstant.onGetProfile]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchUserProfileModel = await FetchUserProfileApi.callApi(token: token, uid: uid);

    isLoading = false;
    update([AppConstant.onGetProfile]);
  }

  void onChangeTab(int value) {
    selectedTabIndex = value;
    update([AppConstant.onChangeTab]);
  }

  Future<void> onRefreshPost() async {
    isLoadingPost = true;
    userPosts.clear();
    update([AppConstant.onGetFeed]);
    FetchUserWisePostApi.startPagination = 0;
    await onFetchPost();
  }

  Future<void> onFetchPost() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchPostModel = await FetchUserWisePostApi.callApi(uid: uid, token: token, toUserId: userId);

    userPosts.addAll(fetchPostModel?.post ?? []);

    isLoadingPost = false;
    update([AppConstant.onFetchPost]);

    if (fetchPostModel?.post?.isEmpty ?? true) {
      FetchUserWisePostApi.startPagination--;
    }
  }

  void onPostPagination() async {
    if (postScrollController.position.pixels == postScrollController.position.maxScrollExtent && isPostPagination == false) {
      isPostPagination = true;
      update([AppConstant.onPagination]);
      await onFetchVideo();
      isPostPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  Future<void> onRefreshVideo() async {
    isLoadingVideo = true;
    userVideos.clear();
    update([AppConstant.onGetVideo]);
    FetchUserWiseVideoApi.startPagination = 0;
    await onFetchVideo();
  }

  Future<void> onFetchVideo() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchVideoModel = await FetchUserWiseVideoApi.callApi(uid: uid, token: token, toUserId: userId);
    userVideos.addAll(fetchVideoModel?.data ?? []);

    isLoadingVideo = false;
    update([AppConstant.onFetchVideo]);

    if (fetchVideoModel?.data?.isEmpty ?? true) {
      FetchUserWiseVideoApi.startPagination--;
    }
  }

  void onVideoPagination() async {
    if (videoScrollController.position.pixels == videoScrollController.position.maxScrollExtent && isVideoPagination == false) {
      isVideoPagination = true;
      update([AppConstant.onPagination]);
      await onFetchVideo();
      isVideoPagination = false;
      update([AppConstant.onPagination]);
    }
  }

  void onClickVideo(int index) async {
    Get.toNamed(
      AppRoutes.previewShortsVideoPage,
      arguments: {"index": index, "videos": userVideos},
    );
  }
}
