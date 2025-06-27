import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/api/fetch_other_user_profile_api.dart';
import 'package:tingle/common/api/fetch_user_wise_post_api.dart';
import 'package:tingle/common/api/fetch_user_wise_video_api.dart';
import 'package:tingle/common/api/follow_unfollow_user_api.dart';
import 'package:tingle/common/model/fetch_other_user_profile_model.dart';
import 'package:tingle/common/shimmer/other_user_profile_shimmer_widget.dart';
import 'package:tingle/extra_pages/gift_gallery_page/api/fetch_fans_ranking_api.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/fans_ranking_page/model/fetch_fans_ranking_model.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/feed_page/model/fetch_video_model.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_follow_chat_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/widget/other_user_tab_bar_widget.dart';
import 'package:tingle/page/profile_page/api/fetch_other_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class OtherUserProfileBottomSheet {
  static bool isOpenBottomSheet = false;
  static FetchOtherUserProfileModel? fetchOtherUserProfileModel;
  static FetchUserProfileModel? fetchUserProfileModel;
  static List<List<DailyWeeklyMonthlyCommonModel>> fansRanking = [[], [], []]; // Daily, Weekly, Monthly
  static FetchFansRankingModel? fetchFansRankingModel;
  static final scrollController = ScrollController();
  static RxInt selectedTabIndex = 0.obs;
  static RxBool isLoading = true.obs;
  static RxBool isFollowed = false.obs;
  static List<Post> userPosts = [];
  static bool isLoadingPost = false;
  static bool isLoadingVideo = false;
  static bool isLoadingFansRanking = false;
  static bool isInitialized = false;
  static FetchVideoModel? fetchVideoModel;
  static List<VideoData> userVideos = [];
  static final uid = FirebaseUid.onGet() ?? "";

  static RxString userId = "".obs;

  static void onChangeBottomBar(int index) {
    if (index != selectedTabIndex.value) {
      selectedTabIndex.value = index;
    }
  }

  static Future<void> onGetFansRanking() async {
    FetchFansRankingApi.startPagination = 0;
    isLoadingFansRanking = true;
    fansRanking = [[], [], []];
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchFansRankingModel = await FetchFansRankingApi.callApi(uid: uid, token: token);
    fansRanking[0].addAll(fetchFansRankingModel?.data?.daily ?? []);
    fansRanking[1].addAll(fetchFansRankingModel?.data?.weekly ?? []);
    fansRanking[2].addAll(fetchFansRankingModel?.data?.monthly ?? []);

    isLoadingFansRanking = false;
    Utils.showLog("Daily => ${fansRanking[0].length}");
    Utils.showLog("Weekly => ${fansRanking[1].length}");
    Utils.showLog("Monthly => ${fansRanking[2].length}");

    if (fetchFansRankingModel?.data?.monthly?.isEmpty ?? true) {
      FetchFansRankingApi.startPagination--;
    }
  }

  static Future<void> fetchProfile() async {
    isLoading.value = true;
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchOtherUserProfileModel = await FetchOtherUserProfileInfoApi.callApi(uid: uid, token: token, toUserId: userId.value);

    fetchUserProfileModel = await FetchOtherUserProfileApi.callApi(token: token, uid: uid, toUserId: userId.value);

    isFollowed.value = fetchOtherUserProfileModel?.user?.isFollowed ?? false;
    isLoading.value = false;
  }

  static Future<void> onClickFollow() async {
    final token = await FirebaseAccessToken.onGet() ?? "";

    if (fetchOtherUserProfileModel?.user?.id != Database.loginUserId) {
      isFollowed.value = !isFollowed.value;
      await FollowUnfollowUserApi.callApi(token: token, uid: uid, toUserId: userId.value);
    }
  }

  // Fetch posts
  static Future<void> fetchPosts() async {
    isLoadingPost = true;
    final token = await FirebaseAccessToken.onGet() ?? "";
    final postModel = await FetchUserWisePostApi.callApi(uid: uid, token: token, toUserId: userId.value);
    userPosts = postModel?.post ?? [];

    isLoadingPost = false;
  }

  static Future<void> fetchVideo() async {
    isLoadingVideo = true;
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchVideoModel = await FetchUserWiseVideoApi.callApi(uid: uid, token: token, toUserId: userId.value);
    userVideos = fetchVideoModel?.data ?? [];

    if (fetchVideoModel?.data?.isEmpty ?? true) {
      FetchUserWiseVideoApi.startPagination--;
    }
    isLoadingVideo = false;
  }

  static Future<void> onTabBar(int index) async {
    selectedTabIndex.value = index;
  }

  static Future<void> loadInitialData() async {
    try {
      isLoading.value = true;

      await Future.wait([fetchProfile(), fetchPosts(), fetchVideo(), onGetFansRanking()]);
    } catch (e) {
      // Handle any errors that occurred during the API calls
      Utils.showLog("Error loading initial data: $e");
    } finally {
      // This will run whether successful or not
      isLoading.value = false;
    }
  }

  static void show({
    required BuildContext context,
    required String userID,
  }) async {
    isOpenBottomSheet = true;
    userId.value = userID;

    loadInitialData();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
            height: Get.height * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Obx(() {
              return (isLoading.value)
                  ? const OtherUserProfileShimmerWidget()
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  SingleChildScrollView(controller: scrollController, child: OtherUserProfileTabBarWidget()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        userID == Database.loginUserId ? 0.height : OtherUserFollowChatWidget()
                      ],
                    );
            }));
      },
    ).whenComplete(
      () => isOpenBottomSheet = false,
    );
  }
}
