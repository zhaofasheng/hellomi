import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/feed_page/api/fetch_follow_post_api.dart';
import 'package:tingle/page/feed_page/api/fetch_hashtag_wise_post_api.dart';
import 'package:tingle/page/feed_page/api/fetch_popular_hashtag_api.dart';
import 'package:tingle/page/feed_page/api/fetch_post_api.dart';
import 'package:tingle/page/feed_page/api/fetch_video_api.dart';
import 'package:tingle/page/feed_page/model/fetch_popular_hashtag_model.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_page/model/fetch_video_model.dart';
import 'package:tingle/page/feed_page/tabs/feed_follow_tab_widget.dart';
import 'package:tingle/page/feed_page/tabs/feed_square_tab_widget.dart';
import 'package:tingle/page/feed_page/tabs/feed_video_tab_widget.dart';
import 'package:tingle/page/feed_page/widget/feed_square_moments_tab_widget.dart';
import 'package:tingle/page/feed_page/widget/feed_square_topics_tab_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FeedController extends GetxController {
  // *******************************************  MAIN TAB *******************************************
  int selectedTab = 0;

  List pages = [FeedSquareTabWidget(), FeedVideoTabWidget(), FeedFollowTabWidget()];

  // *******************************************  SQUARE TAB *******************************************

  ScrollController momentScrollController = ScrollController();

  // TAB BAR
  int selectedSquareTab = 0;

  List squarePages = [const FeedSquareMomentsTabWidget(), const FeedSquareTopicsTabWidget()];

  // MOMENTS TAB
  List<Post> moments = [];
  bool isLoadingMoment = false;
  FetchPostModel? fetchMomentModel;
  bool isPaginationMoment = false;

  // TOPICS TAB
  List<Post> topics = [];
  bool isLoadingTopic = false;
  FetchPostModel? fetchTopicModel;

  // POPULAR HASHTAG
  int selectedHashtagIndex = 0;
  bool isLoadingPopularHashtag = false;
  List<Hashtags> popularHashtag = [];
  FetchPopularHashtagModel? fetchPopularHashtagModel;

  // *******************************************  FOLLOW TAB *******************************************

  ScrollController followScrollController = ScrollController();

  bool isLoadingFollow = false;
  bool isPaginationFollow = false;

  List<Post> followPost = [];
  FetchPostModel? fetchPostModel;

  // *******************************************  VIDEO TAB *******************************************

  PageController pageController = PageController();

  int currentIndex = 0;

  List<VideoData> videos = [];
  bool isLoading = false;
  FetchVideoModel? fetchVideoModel;
  bool isLoadingPagination = false;

  // ******************************************* INIT *******************************************

  @override
  void onInit() {
    onGetPopularHashtag();
    momentScrollController.addListener(onMomentPagination);
    followScrollController.addListener(onFollowPagination);
    super.onInit();
  }

  Future<void> init() async {
    final bottomBarController = Get.find<BottomBarController>();
    if (Get.currentRoute == AppRoutes.bottomBarPage && bottomBarController.selectedTabIndex == 2) {
      onChangeTab(0);
    }
  }

  // *******************************************  MAIN TAB *******************************************

  Future<void> onChangeTab(int value) async {
    selectedTab = value;
    selectedTab == 1 ? Utils.onChangeExtendBody(true) : Utils.onChangeExtendBody(false);
    update([AppConstant.onChangeTab]);
    onGetTabWiseData();
  }

  Future<void> onGetTabWiseData() async {
    switch (selectedTab) {
      case 0:
        {
          onRefreshMoment();
        }
      case 1:
        {
          onRefreshVideos();
        }
      case 2:
        {
          onRefreshFollowPost();
        }
      default:
    }
  }

  // *******************************************  SQUARE TAB *******************************************

  // CHANGE SQUARE TAB BAR
  Future<void> onChangeSquareTab(int value) async {
    selectedSquareTab = value;
    update([AppConstant.onChangeSquareTab]);
  }

  // GET POPULAR HASHTAG

  Future<void> onGetPopularHashtag() async {
    isLoadingPopularHashtag = true;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchPopularHashtagModel = await FetchPopularHashtagApi.callApi(token: token, uid: uid);

    popularHashtag = fetchPopularHashtagModel?.hashtags ?? [];
    isLoadingPopularHashtag = false;

    update([AppConstant.onGetPopularHashtag]);
    await onGetTopics();
  }

  Future<void> onChangeHashtag(int index) async {
    selectedHashtagIndex = index;
    update([AppConstant.onChangeHashtag]);
    await onGetTopics();
  }

  // GET HASHTAG WISE MOMENT (POST)

  Future<void> onGetTopics() async {
    isLoadingTopic = true;
    update([AppConstant.onChangeHashtag]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchTopicModel = await FetchHashtagWisePostApi.callApi(uid: uid, token: token, hashTagId: popularHashtag.isNotEmpty ? popularHashtag[selectedHashtagIndex].id ?? "" : "");

    topics = (fetchTopicModel?.post ?? []);
    isLoadingTopic = false;
    update([AppConstant.onChangeHashtag]);
  }

  // GET ALL MOMENT (POST)

  Future<void> onRefreshMoment() async {
    isLoadingMoment = true;
    update([AppConstant.onGetMoment]);

    FetchPostApi.startPagination = 0;

    moments.clear();
    await onGetMoment();
  }

  Future<void> onGetMoment() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchMomentModel = await FetchPostApi.callApi(uid: uid, token: token, postId: BranchIoServices.eventId);

    moments.addAll(fetchMomentModel?.post ?? []);

    isLoadingMoment = false;
    update([AppConstant.onGetMoment]);

    Utils.showLog("Moments List Length => ${moments.length}");

    BranchIoServices.eventId = ""; // Refresh Time Not Show Same Post On Top
    BranchIoServices.eventType = ""; // Refresh Time Not Show Same Post On Top

    if (fetchMomentModel?.post?.isEmpty ?? true) {
      FetchPostApi.startPagination--;
    }
  }

  Future<void> onMomentPagination() async {
    if (momentScrollController.position.pixels == momentScrollController.position.maxScrollExtent && isPaginationMoment == false) {
      isPaginationMoment = true;
      update([AppConstant.onMomentPagination]);

      await onGetMoment();

      isPaginationMoment = false;
      update([AppConstant.onMomentPagination]);
    }
  }

  // *******************************************  FOLLOW TAB *******************************************

  Future<void> onRefreshFollowPost() async {
    FetchFollowPostApi.startPagination = 0;
    followPost.clear();
    isLoadingFollow = true;
    update([AppConstant.onGetFollowPost]);
    await onGetFollowPost();
  }

  Future<void> onGetFollowPost() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchPostModel = await FetchFollowPostApi.callApi(uid: uid, token: token);
    followPost.addAll(fetchPostModel?.post ?? []);

    isLoadingFollow = false;
    update([AppConstant.onGetFollowPost]);

    if (fetchPostModel?.post?.isEmpty ?? true) {
      FetchFollowPostApi.startPagination--;
    }
  }

  Future<void> onFollowPagination() async {
    if (followScrollController.position.pixels == followScrollController.position.maxScrollExtent && isPaginationFollow == false) {
      isPaginationFollow = true;
      update([AppConstant.onPagination]);
      await onGetFollowPost();
      isPaginationFollow = false;
      update([AppConstant.onPagination]);
    }
  }

  // *******************************************  VIDEO TAB *******************************************

  Future<void> onRefreshVideos() async {
    onChangePage(0);
    FetchVideoApi.startPagination = 0;
    videos.clear();
    isLoading = true;
    update([AppConstant.onGetVideo]);
    await onGetVideo();
  }

  Future<void> onGetVideo() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchVideoModel = await FetchVideoApi.callApi(uid: uid, token: token, videoId: BranchIoServices.eventId);
    videos.addAll(fetchVideoModel?.data ?? []);
    if (fetchVideoModel?.data?.isEmpty ?? true) {
      FetchVideoApi.startPagination--;
    }
    isLoading = false;
    update([AppConstant.onGetVideo]);
  }

  Future<void> onPaginationVideo(int value) async {
    if ((videos.length - 1) == value) {
      if (isLoadingPagination == false) {
        isLoadingPagination = true;
        update([AppConstant.onPagination]);
        await onGetVideo();
        isLoadingPagination = false;
        update([AppConstant.onPagination]);
      }
    }
  }

  Future<void> onChangePage(int index) async {
    currentIndex = index;
    update([AppConstant.onChangePage]);
  }
}
