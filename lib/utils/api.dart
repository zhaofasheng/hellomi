// abstract class Api {
//   // >>>>> >>>>> >>>>> CREDENTIAL <<<<< <<<<< <<<<<
//
//   //static const baseUrl = "https://admin.halomi.la/";
//   static const baseUrl = "https://hlapi.halomi.la/";
//   //static const baseUrl = "http://admin.halolive.la/";
//   static const secretKey = "E>kzgA{o?}I&46[hmK^~5/+t06B";
//
//   //static String agencyLink = "https://agency.halomi.la/?id=";
//   static String agencyLink = "https://hlagency.halomi.la/?id=";
//   //static String agencyLink = "http://agency.halolive.la/?id=";
//
//   static String hostCenterLink = "https://hlhost.halomi.la/?id=";
//
//   // >>>>> >>>>> >>>>> ADMIN SETTING <<<<< <<<<< <<<<<
//   static const fetchSetting = "${baseUrl}api/client/setting/loadAppSettings";
//
//   static const fetchUserProfileImages = "${baseUrl}api/client/setting/getProfilePhotoList";
//
//   // >>>>> >>>>> >>>>> PROFILE PAGE <<<<< <<<<< <<<<<
//   static const fetchUserProfile = "${baseUrl}api/client/user/getUserInfo";
//   static const fetchOtherUserProfile = "${baseUrl}api/client/user/getTargetUserInfo?";
//
//   // >>>>> >>>>> >>>>> LOGIN PAGE <<<<< <<<<< <<<<<
//   static const fetchLoginUserProfile = "${baseUrl}api/client/user/fetchUserProfile";
//   static const checkUserNameExit = "${baseUrl}api/client/user/checkUserNameAvailability";
//   static const login = "${baseUrl}api/client/user/loginOrRegisterUser";
//   static const editProfile = "${baseUrl}api/client/user/updateUserProfile";
//   static const deleteUser = "${baseUrl}api/client/user/deactivateMyAccount";
//   static const validateUser = "${baseUrl}api/client/user/validateUserPresence?";
//   static const userExistsForReset = "${baseUrl}api/client/user/userExistsForReset?";
//
//   // >>>>> >>>>> >>>>> CONNECTION <<<<< <<<<< <<<<<
//   static const followUnfollow = "${baseUrl}api/client/followerFollowing/followUnfollow?";
//   static const fetchFriends = "${baseUrl}api/client/followerFollowing/getFriendsList?";
//   static const fetchUserConnection = "${baseUrl}api/client/followerFollowing/getUserConnections?";
//   static const fetchGetSocialLists = "${baseUrl}api/client/followerFollowing/social/lists?";
//   static const fetchVisitedProfilesAndVisitors = "${baseUrl}api/client/profileVisitor/fetchVisitedProfilesAndVisitors";
//   static const searchUserConnections = "${baseUrl}api/client/user/searchUsersByType?";
//   static const otherUserConnections = "${baseUrl}api/client/followerFollowing/fetchUserSocialConnections?";
//
//   // >>>>> >>>>> >>>>> HASHTAG <<<<< <<<<< <<<<<
//   static const fetchAllHashtag = "${baseUrl}api/client/hashTag/getHashtags";
//   static const fetchPopularHashtag = "${baseUrl}api/client/hashTag/getTopTrendingHashtags";
//
//   // >>>>> >>>>> >>>>> SEARCH PAGE <<<<< <<<<< <<<<<
//   static const searchUser = "${baseUrl}api/client/user/filterUsersBySearch?";
//
//   // >>>>> >>>>> >>>>> VIDEO PAGE <<<<< <<<<< <<<<<
//   static const fetchVideo = "${baseUrl}api/client/video/retrieveVideoCollection?";
//   static const fetchUserWiseVideo = "${baseUrl}api/client/video/userVideoLibrary?";
//   static const fetchSongWiseVideo = "${baseUrl}api/client/video/fetchSongVideos?";
//
//   static const likeVideo = "${baseUrl}api/client/likeHistory/toggleVideoLikeStatus?";
//   static const editVideo = "${baseUrl}api/client/video/modifyVideoDetails?";
//   static const shareVideo = "${baseUrl}api/client/video/boostVideoShares?";
//   static const deleteVideo = "${baseUrl}api/client/video/deleteUserVideo?";
//   static const uploadVideo = "${baseUrl}api/client/video/broadcastVideo";
//
//   // >>>>> >>>>> >>>>> COMMENT PAGE <<<<< <<<<< <<<<<
//   static const fetchComment = "${baseUrl}api/client/comment/fetchMediaComments?";
//   static const sendComment = "${baseUrl}api/client/comment/addCommentToMedia?";
//
//   // >>>>> >>>>> >>>>> POST PAGE <<<<< <<<<< <<<<<
//   static const fetchPost = "${baseUrl}api/client/post/getPostsList?";
//   static const fetchHashtagWisePost = "${baseUrl}api/client/hashTag/retrieveHashtagPosts?";
//   static const fetchUserWisePost = "${baseUrl}api/client/post/getUserPosts?";
//   static const fetchFollowPost = "${baseUrl}api/client/post/retrieveFollowerPosts?";
//
//   static const uploadPost = "${baseUrl}api/client/post/publishPost";
//   static const likePost = "${baseUrl}api/client/likeHistory/togglePostLikeStatus?";
//   static const sharePost = "${baseUrl}api/client/post/incrementPostShareCount?";
//   static const deletePost = "${baseUrl}api/client/post/removeUserPost?";
//   static const editPost = "${baseUrl}api/client/post/editUserPost?";
//
//   // >>>>> >>>>> >>>>> REPORT PAGE <<<<< <<<<< <<<<<
//   static const fetchReportReason = "${baseUrl}api/client/reportReason/fetchViolationReason";
//   static const sendReport = "${baseUrl}api/client/report/userSubmittedReport?";
//
//   // >>>>> >>>>> >>>>> CHAT PAGE <<<<< <<<<< <<<<<
//   static const fetchMessageUser = "${baseUrl}api/client/chatTopic/fetchChatList?";
//   static const fetchSearchMessageUser = "${baseUrl}api/client/chatTopic/findChatUserBySearch?";
//   static const fetchUserChat = "${baseUrl}api/client/chat/fetchChatHistory?";
//   static const sendFileToChat = "${baseUrl}api/client/chat/sendChatMessage?";
//
//   // >>>>> >>>>> >>>>> COIN PLAN PAGE <<<<< <<<<< <<<<<
//   static const fetchCoinPlan = "${baseUrl}api/client/coinPlan/listCoinPackages";
//
//   // >>>>> >>>>> >>>>> SONG PAGE <<<<< <<<<< <<<<<
//   static const fetchSong = "${baseUrl}api/client/song/fetchSongs?";
//   static const fetchFavoriteSong = "${baseUrl}api/client/song/retrieveFavoriteSongs?";
//   static const favoriteSong = "${baseUrl}api/client/song/handleUserFavoriteSong?";
//   static const searchSong = "${baseUrl}api/client/song/findSongs?";
//
//   // >>>>> >>>>> >>>>> VISIT PROFILE PAGE <<<<< <<<<< <<<<<
//   static const visitProfile = "${baseUrl}api/client/profileVisitor/recordProfileVisit?";
//   static const fetchMyProfileVisitedUser = "${baseUrl}api/client/profileVisitor/getProfileVisitors";
//   static const fetchVisitedProfileUser = "${baseUrl}api/client/profileVisitor/getVisitedProfiles";
//
//   // >>>>> >>>>> >>>>> LIVE PAGE <<<<< <<<<< <<<<<
//   static const startLiveStream = "${baseUrl}api/client/liveStreamer/startLiveStream?";
//   static const fetchLiveStream = "${baseUrl}api/client/liveStreamer/fetchLiveStreamers?";
//
//   // >>>>> >>>>> >>>>> GIFT PAGE <<<<< <<<<< <<<<<
//   static const fetchGift = "${baseUrl}api/client/gift/fetchGiftCollection?";
//   static const fetchGiftCategories = "${baseUrl}api/client/giftCategory/retrieveGiftCategories";
//
//   // >>>>> >>>>> >>>>> COIN PAGE <<<<< <<<<< <<<<<
//   static const createCoinPlanHistory = "${baseUrl}api/client/coinPlan/recordCoinPlanTransaction?";
//   static const fetchUserCoin = "${baseUrl}api/client/user/fetchUserCoinBalance";
//   static const fetchCoinHistory = "${baseUrl}api/client/history/getUserTransactionHistory?";
//
//   // >>>>> >>>>> >>>>> WITHDRAW PAGE <<<<< <<<<< <<<<<
//   static const submitPayoutRequest = "${baseUrl}api/client/payoutRequest/submitPayoutRequest";
//   static const fetchPayoutMethods = "${baseUrl}api/client/payoutMethod/fetchPayoutMethods";
//   static const retrieveUserPayouts = "${baseUrl}api/client/payoutRequest/retrieveUserPayouts?";
//
//   // >>>>> >>>>> >>>>> AUDIO ROOM PAGE <<<<< <<<<< <<<<<
//   static const createAudioRoom = "${baseUrl}api/client/liveStreamer/initializeLiveStream";
//   static const editAudioRoom = "${baseUrl}api/client/liveStreamer/updateAudioRoomInfo";
//   static const fetchAudioRoomJoinUser = "${baseUrl}api/client/liveStreamer/getAvailableUsersForInvite?";
//   static const fetchAudioRoomBlocUserList = "${baseUrl}api/client/liveStreamer/fetchBlockedUsersList?";
//   static const fetchAudioRoomSeatUsers = "${baseUrl}api/client/liveStreamer/fetchSeatedUsersList?";
//   static const fetchEmoji = "${baseUrl}api/client/reaction/getReactionEmojis";
//   static const fetchPurchaseTheme = "${baseUrl}api/client/purchasedItem/getUserPurchasedThemes?";
//
//   // >>>>> >>>>> >>>>> PK BATTLE PAGE <<<<< <<<<< <<<<<
//   static const fetchAvailableLiveUserForPk = "${baseUrl}api/client/liveStreamer/getAvailableLiveUsers";
//
//   // >>>>> >>>>> >>>>> RANKING PAGE <<<<< <<<<< <<<<<
//   static const fetchRankingRichUser = "${baseUrl}api/client/history/fetchTopCoinConsumers?";
//   static const fetchRankingGiftUser = "${baseUrl}api/client/history/fetchTopGiftStats?";
//
//   // >>>>> >>>>> >>>>> PREVIEW USER PROFILE PAGE <<<<< <<<<< <<<<<
//
//   static const fetchMyGiftGallery = "${baseUrl}api/client/history/getUserReceivedGiftHistory?";
//   static const fetchOtherUserGiftGallery = "${baseUrl}api/client/history/retrieveUserGiftHistory?";
//   static const fetchFansRanking = "${baseUrl}api/client/history/getFansRanking?";
//
//   // >>>>> >>>>> >>>>> STORE <<<<< <<<<< <<<<<
//   static const fetchRecommendations = "${baseUrl}api/client/purchasedItem/getRecommendations?";
//   static const fetchListStoreItems = "${baseUrl}api/client/purchasedItem/listStoreItems?";
//   static const executePurchaseItem = "${baseUrl}api/client/purchasedItem/executePurchaseItem?";
//
//   // >>>>> >>>>> >>>>> BACKPACK PAGE <<<<< <<<<< <<<<<
//   static const listUserPurchasedItems = "${baseUrl}api/client/purchasedItem/listUserPurchasedItems?";
//   static const wearOrTakeOffItem = "${baseUrl}api/client/purchasedItem/wearOrTakeOffItem?";
//
//   // >>>>> >>>>> >>>>> HELP PAGE <<<<< <<<<< <<<<<
//   static const help = "${baseUrl}api/client/help/submitUserHelp";
//
//   // >>>>> >>>>> >>>>> LEVEL PAGE <<<<< <<<<< <<<<<
//   static const fetchLevel = "${baseUrl}api/client/wealthLevel/retrieveWealthHierarchy";
//
//   // >>>>> >>>>> >>>>> REFERRAL PAGE <<<<< <<<<< <<<<<
//   static const fetchReferralSystem = "${baseUrl}api/client/referralSystem/fetchReferralSystems";
//   static const applyReferralCode = "${baseUrl}api/client/referral/submitReferralCode?";
//   static const fetchReferralHistory = "${baseUrl}api/client/referral/fetchReferralHistory";
//
//   static const validateAgency = "${baseUrl}api/client/hostApplication/validateAgencyOrUser?";
//   static const applyHostRequest = "${baseUrl}api/client/hostApplication/applyHostApplication?";
//
//   // >>>>> >>>>> >>>>> COIN TRADING PAGE  <<<<< <<<<< <<<<<
//   static const purchaseCoinFromCoinTrader = "${baseUrl}api/client/coinTrader/purchaseCoinFromCoinTrader?";
//   static const getFilteredUserList = "${baseUrl}api/client/user/getFilteredUserList?";
//   static const fetchCoinTraderProfile = "${baseUrl}api/client/coinTrader/fetchCoinTraderProfile";
//   static const historyOfCoinTraderToUser = "${baseUrl}api/client/coinTraderHistory/historyOfCoinTraderToUser?";
//
//   // >>>>> >>>>> >>>>> COIN TRADING PAGE  <<<<< <<<<< <<<<<
//   static const blockUnblockUser = "${baseUrl}api/client/block/manageUserBlockStatus?";
//   static const fetchBlockUser = "${baseUrl}api/client/block/listBlockedUsers";
//
//   static const toggleNotification = "${baseUrl}api/client/user/toggleNotificationPermission";
//
//   static const fetchLiveSummary = "${baseUrl}api/client/liveStreamer/getLiveSummaryDetails?";
//
//   static const fetchBanner = "${baseUrl}api/client/banner/retrieveBannerList?";
//
//   static const stopAudioRoomSession = "${baseUrl}api/client/liveStreamer/stopAudioSession?";
//   static const checkAudioSession = "${baseUrl}api/client/liveStreamer/exitAudioSession";
//   static const stripPayUri = "${baseUrl}api/client/payOrder/fetchCreateStripeOrder";
//   static const applyPayAuth = "${baseUrl}api/client/payNotification/iosPaymentCallbackV2";
//   static const newPayUri = "${baseUrl}api/client/payOrder/fetchCreateNewPayOrder";
// }


abstract class Api {
  // >>>>> >>>>> >>>>> CREDENTIAL <<<<< <<<<< <<<<<

  //static const baseUrl = "https://admin.halomi.la/";
  static const baseUrl = "https://hlapi.halomi.la/";
  //static const baseUrl = "http://admin.halolive.la/";
  static const secretKey = "E>kzgA{o?}I&46[hmK^~5/+t06B";

  //static String agencyLink = "https://agency.halomi.la/?id=";
  static String agencyLink = "https://hlagency.halomi.la/?id=";
  //static String agencyLink = "http://agency.halolive.la/?id=";

  static String hostCenterLink = "https://hlhost.halomi.la/?id=";

  // >>>>> >>>>> >>>>> ADMIN SETTING <<<<< <<<<< <<<<<
  static const fetchSetting = "${baseUrl}api/client/setting/load/app";

  static const fetchUserProfileImages = "${baseUrl}api/client/setting/profile/list";

  // >>>>> >>>>> >>>>> PROFILE PAGE <<<<< <<<<< <<<<<
  static const fetchUserProfile = "${baseUrl}api/client/user/info";
  static const fetchOtherUserProfile = "${baseUrl}api/client/user/target/info?";

  // >>>>> >>>>> >>>>> LOGIN PAGE <<<<< <<<<< <<<<<
  static const fetchLoginUserProfile = "${baseUrl}api/client/user/profile/fetch";
  static const checkUserNameExit = "${baseUrl}api/client/user/name/availability/check";
  static const login = "${baseUrl}api/client/user/login/register";
  static const editProfile = "${baseUrl}api/client/user/profile/update";
  static const deleteUser = "${baseUrl}api/client/user/account/deactivate";
  static const validateUser = "${baseUrl}api/client/user/presence/validate?";
  static const userExistsForReset = "${baseUrl}api/client/user/for/reset/exists?";

  // >>>>> >>>>> >>>>> CONNECTION <<<<< <<<<< <<<<<
  static const followUnfollow = "${baseUrl}api/client/followerFollowing/unfollow?";
  static const fetchFriends = "${baseUrl}api/client/followerFollowing/friends/list?";
  static const fetchUserConnection = "${baseUrl}api/client/followerFollowing/getUserConnections?";
  static const fetchGetSocialLists = "${baseUrl}api/client/followerFollowing/social/lists?";
  static const fetchVisitedProfilesAndVisitors = "${baseUrl}api/client/profileVisitor/visited/and/visitors";
  static const searchUserConnections = "${baseUrl}api/client/user/search/type?";
  static const otherUserConnections = "${baseUrl}api/client/followerFollowing/social/connections?";

  // >>>>> >>>>> >>>>> HASHTAG <<<<< <<<<< <<<<<
  static const fetchAllHashtag = "${baseUrl}api/client/hashTag/list";
  static const fetchPopularHashtag = "${baseUrl}api/client/hashTag/top/trending";

  // >>>>> >>>>> >>>>> SEARCH PAGE <<<<< <<<<< <<<<<
  static const searchUser = "${baseUrl}api/client/user/filter/search?";

  // >>>>> >>>>> >>>>> VIDEO PAGE <<<<< <<<<< <<<<<
  static const fetchVideo = "${baseUrl}api/client/video/collection/retrieve?";
  static const fetchUserWiseVideo = "${baseUrl}api/client/video/library?";
  static const fetchSongWiseVideo = "${baseUrl}api/client/video/song?";

  static const likeVideo = "${baseUrl}api/client/likeHistory/video/like/status?";
  static const editVideo = "${baseUrl}api/client/video/modify/details?";
  static const shareVideo = "${baseUrl}api/client/video/boost/shares?";
  static const deleteVideo = "${baseUrl}api/client/video/delete?";
  static const uploadVideo = "${baseUrl}api/client/video/broadcast";

  // >>>>> >>>>> >>>>> COMMENT PAGE <<<<< <<<<< <<<<<
  static const fetchComment = "${baseUrl}api/client/comment/fetch/media?";
  static const sendComment = "${baseUrl}api/client/comment/add/media?";

  // >>>>> >>>>> >>>>> POST PAGE <<<<< <<<<< <<<<<
  static const fetchPost = "${baseUrl}api/client/post/list?";
  static const fetchHashtagWisePost = "${baseUrl}api/client/hashTag/retrieve?";
  static const fetchUserWisePost = "${baseUrl}api/client/post/user?";
  static const fetchFollowPost = "${baseUrl}api/client/post/follower/retrieve?";

  static const uploadPost = "${baseUrl}api/client/post/publish";
  static const likePost = "${baseUrl}api/client/likeHistory/post/like/status?";
  static const sharePost = "${baseUrl}api/client/post/increment/share/count?";
  static const deletePost = "${baseUrl}api/client/post/user/remove?";
  static const editPost = "${baseUrl}api/client/post/user/edit?";

  // >>>>> >>>>> >>>>> REPORT PAGE <<<<< <<<<< <<<<<
  static const fetchReportReason = "${baseUrl}api/client/reportReason/violation";
  static const sendReport = "${baseUrl}api/client/report/submitted?";

  // >>>>> >>>>> >>>>> CHAT PAGE <<<<< <<<<< <<<<<
  static const fetchMessageUser = "${baseUrl}api/client/chatTopic/list?";
  static const fetchSearchMessageUser = "${baseUrl}api/client/chatTopic/find/search?";
  static const fetchUserChat = "${baseUrl}api/client/chat/fetch/history?";
  static const sendFileToChat = "${baseUrl}api/client/chat/send/message?";

  // >>>>> >>>>> >>>>> COIN PLAN PAGE <<<<< <<<<< <<<<<
  static const fetchCoinPlan = "${baseUrl}api/client/coinPlan/list";

  // >>>>> >>>>> >>>>> SONG PAGE <<<<< <<<<< <<<<<
  static const fetchSong = "${baseUrl}api/client/song/list?";
  static const fetchFavoriteSong = "${baseUrl}api/client/song/retrieve/favorite?";
  static const favoriteSong = "${baseUrl}api/client/song/handle/user/favorite?";
  static const searchSong = "${baseUrl}api/client/song/findSongs?";

  // >>>>> >>>>> >>>>> VISIT PROFILE PAGE <<<<< <<<<< <<<<<
  static const visitProfile = "${baseUrl}api/client/profileVisitor/record?";
  static const fetchMyProfileVisitedUser = "${baseUrl}api/client/profileVisitor/list";
  static const fetchVisitedProfileUser = "${baseUrl}api/client/profileVisitor/visited/profiles/list";

  // >>>>> >>>>> >>>>> LIVE PAGE <<<<< <<<<< <<<<<
  static const startLiveStream = "${baseUrl}api/client/liveStreamer/start?";
  static const fetchLiveStream = "${baseUrl}api/client/liveStreamer/fetch?";

  // >>>>> >>>>> >>>>> GIFT PAGE <<<<< <<<<< <<<<<
  static const fetchGift = "${baseUrl}api/client/gift/collection?";
  static const fetchGiftCategories = "${baseUrl}api/client/giftCategory/retrieve";

  // >>>>> >>>>> >>>>> COIN PAGE <<<<< <<<<< <<<<<
  static const createCoinPlanHistory = "${baseUrl}api/client/coinPlan/record/transaction?";
  static const fetchUserCoin = "${baseUrl}api/client/user/coin/balance/fetch";
  static const fetchCoinHistory = "${baseUrl}api/client/history/transaction/history?";

  // >>>>> >>>>> >>>>> WITHDRAW PAGE <<<<< <<<<< <<<<<
  static const submitPayoutRequest = "${baseUrl}api/client/payoutRequest/submit";
  static const fetchPayoutMethods = "${baseUrl}api/client/payoutMethod/fetch";
  static const retrieveUserPayouts = "${baseUrl}api/client/payoutRequest/retrieve?";

  // >>>>> >>>>> >>>>> AUDIO ROOM PAGE <<<<< <<<<< <<<<<
  static const createAudioRoom = "${baseUrl}api/client/liveStreamer/initialize";
  static const editAudioRoom = "${baseUrl}api/client/liveStreamer/update/room/info";
  static const fetchAudioRoomJoinUser = "${baseUrl}api/client/liveStreamer/available/for/invite?";
  static const fetchAudioRoomBlocUserList = "${baseUrl}api/client/liveStreamer/blocked/list?";
  static const fetchAudioRoomSeatUsers = "${baseUrl}api/client/liveStreamer/seated/list?";
  static const fetchEmoji = "${baseUrl}api/client/reaction/emojis";
  static const fetchPurchaseTheme = "${baseUrl}api/client/purchasedItem/user/themes?";

  // >>>>> >>>>> >>>>> PK BATTLE PAGE <<<<< <<<<< <<<<<
  static const fetchAvailableLiveUserForPk = "${baseUrl}api/client/liveStreamer/available";

  // >>>>> >>>>> >>>>> RANKING PAGE <<<<< <<<<< <<<<<
  static const fetchRankingRichUser = "${baseUrl}api/client/history/top/coin/consumers?";
  static const fetchRankingGiftUser = "${baseUrl}api/client/history/top/gift/stats?";

  // >>>>> >>>>> >>>>> PREVIEW USER PROFILE PAGE <<<<< <<<<< <<<<<

  static const fetchMyGiftGallery = "${baseUrl}api/client/history/received/gift/history?";
  static const fetchOtherUserGiftGallery = "${baseUrl}api/client/history/retrieve/gift/history?";
  static const fetchFansRanking = "${baseUrl}api/client/history/fans/ranking?";

  // >>>>> >>>>> >>>>> STORE <<<<< <<<<< <<<<<
  static const fetchRecommendations = "${baseUrl}api/client/purchasedItem/recommendations?";
  static const fetchListStoreItems = "${baseUrl}api/client/purchasedItem/list?";
  static const executePurchaseItem = "${baseUrl}api/client/purchasedItem/execute/item?";

  // >>>>> >>>>> >>>>> BACKPACK PAGE <<<<< <<<<< <<<<<
  static const listUserPurchasedItems = "${baseUrl}api/client/purchasedItem/list/user/items?";
  static const wearOrTakeOffItem = "${baseUrl}api/client/purchasedItem/wear/item?";

  // >>>>> >>>>> >>>>> HELP PAGE <<<<< <<<<< <<<<<
  static const help = "${baseUrl}api/client/help/submit";

  // >>>>> >>>>> >>>>> LEVEL PAGE <<<<< <<<<< <<<<<
  static const fetchLevel = "${baseUrl}api/client/wealthLevel/retrieve/hierarchy";

  // >>>>> >>>>> >>>>> REFERRAL PAGE <<<<< <<<<< <<<<<
  static const fetchReferralSystem = "${baseUrl}api/client/referralSystem/fetch";
  static const applyReferralCode = "${baseUrl}api/client/referral/submit/code?";
  static const fetchReferralHistory = "${baseUrl}api/client/referral/fetch/history";

  static const validateAgency = "${baseUrl}api/client/hostApplication/validate?";
  static const applyHostRequest = "${baseUrl}api/client/hostApplication/apply?";

  // >>>>> >>>>> >>>>> COIN TRADING PAGE  <<<<< <<<<< <<<<<
  static const purchaseCoinFromCoinTrader = "${baseUrl}api/client/coinTrader/purchase/coin/from?";
  static const getFilteredUserList = "${baseUrl}api/client/user/filtered/list?";
  static const fetchCoinTraderProfile = "${baseUrl}api/client/coinTrader/fetch/profile";
  static const historyOfCoinTraderToUser = "${baseUrl}api/client/coinTraderHistory/history?";

  // >>>>> >>>>> >>>>> COIN TRADING PAGE  <<<<< <<<<< <<<<<
  static const blockUnblockUser = "${baseUrl}api/client/block/manage/status?";
  static const fetchBlockUser = "${baseUrl}api/client/block/list";

  static const toggleNotification = "${baseUrl}api/client/user/permission/toggle";

  static const fetchLiveSummary = "${baseUrl}api/client/liveStreamer/details?";

  static const fetchBanner = "${baseUrl}api/client/banner/retrieve/list?";

  static const stopAudioRoomSession = "${baseUrl}api/client/liveStreamer/stop/session?";
  static const checkAudioSession = "${baseUrl}api/client/liveStreamer/exit/session";
  static const stripPayUri = "${baseUrl}api/client/payOrder/fetchCreateStripeOrder";
  static const applyPayAuth = "${baseUrl}api/client/payNotification/iosPaymentCallbackV2";
  static const newPayUri = "${baseUrl}api/client/payOrder/fetchCreateNewPayOrder";
}
