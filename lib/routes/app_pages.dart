

import 'package:get/get.dart';
import 'package:tingle/page/about_us_page/binding/about_us_binding.dart';
import 'package:tingle/page/about_us_page/view/about_us_view.dart';
import 'package:tingle/page/agency_page/binding/agency_binding.dart';
import 'package:tingle/page/agency_page/view/agency_view.dart';
import 'package:tingle/page/audio_room_page/binding/audio_room_binding.dart';
import 'package:tingle/page/audio_room_page/view/audio_room_view.dart';
import 'package:tingle/page/audio_wise_videos_page/binding/audio_wise_videos_binding.dart';
import 'package:tingle/page/audio_wise_videos_page/view/audio_wise_videos_view.dart';
import 'package:tingle/page/backpack_page/binding/backpack_binding.dart';
import 'package:tingle/page/backpack_page/view/backpack_view.dart';
import 'package:tingle/page/banner_web_view_page/binding/banner_web_view_binding.dart';
import 'package:tingle/page/banner_web_view_page/controller/banner_web_view_controller.dart';
import 'package:tingle/page/banner_web_view_page/view/banner_web_view_view.dart';
import 'package:tingle/page/block_user_page/binding/block_user_binding.dart';
import 'package:tingle/page/block_user_page/view/block_user_view.dart';
import 'package:tingle/page/bottom_bar_page/binding/bottom_bar_binding.dart';
import 'package:tingle/page/bottom_bar_page/view/bottom_bar_view.dart';
import 'package:tingle/page/chat_page/binding/chat_binding.dart';
import 'package:tingle/page/chat_page/view/chat_view.dart';
import 'package:tingle/page/coin_history_page/binding/coin_history_binding.dart';
import 'package:tingle/page/coin_history_page/view/coin_history_view.dart';
import 'package:tingle/page/coin_seller_page/binding/coin_seller_binding.dart';
import 'package:tingle/page/coin_seller_page/view/coin_seller_view.dart';
import 'package:tingle/page/connection_page/binding/Search_connection_binding.dart';
import 'package:tingle/page/connection_page/binding/connection_binding.dart';
import 'package:tingle/page/connection_page/view/connection_search_view.dart';
import 'package:tingle/page/connection_page/view/connection_view.dart';
import 'package:tingle/page/create_audio_room_page/binding/create_audio_room_binding.dart';
import 'package:tingle/page/create_audio_room_page/view/create_audio_room_view.dart';
import 'package:tingle/page/create_reels_page/binding/create_reels_binding.dart';
import 'package:tingle/page/create_reels_page/view/create_reels_view.dart';
import 'package:tingle/page/edit_feed_page/binding/edit_feed_binding.dart';
import 'package:tingle/page/edit_feed_page/view/edit_feed_view.dart';
import 'package:tingle/page/edit_profile_page/binding/edit_profile_binding.dart';
import 'package:tingle/page/edit_profile_page/view/edit_profile_view.dart';
import 'package:tingle/page/edit_video_page/binding/edit_video_binding.dart';
import 'package:tingle/page/edit_video_page/view/edit_video_view.dart';
import 'package:tingle/page/fake_audio_room_page/binding/fake_audio_room_binding.dart';
import 'package:tingle/page/fake_audio_room_page/view/fake_audio_room_view.dart';
import 'package:tingle/page/fake_chat_page/binding/fake_chat_binding.dart';
import 'package:tingle/page/fake_chat_page/view/fake_chat_view.dart';
import 'package:tingle/page/fake_live_page/binding/fake_live_binding.dart';
import 'package:tingle/page/fake_live_page/view/fake_live_view.dart';
import 'package:tingle/page/fans_ranking_page/binding/fans_ranking_binding.dart';
import 'package:tingle/page/fans_ranking_page/view/fans_ranking_view.dart';
import 'package:tingle/page/feed_page/binding/feed_binding.dart';
import 'package:tingle/page/feed_page/view/feed_view.dart';
import 'package:tingle/page/fill_profile_page/binding/fill_profile_binding.dart';
import 'package:tingle/page/fill_profile_page/view/fill_profile_view.dart';
import 'package:tingle/page/go_live_page/binding/go_live_binding.dart';
import 'package:tingle/page/go_live_page/view/go_live_view.dart';
import 'package:tingle/page/help_page/binding/help_binding.dart';
import 'package:tingle/page/help_page/view/help_view.dart';
import 'package:tingle/page/host_center_page/binding/host_center_binding.dart';
import 'package:tingle/page/host_center_page/view/host_center_view.dart';
import 'package:tingle/page/host_request_page/view/host_request_view.dart';
import 'package:tingle/page/incoming_video_call_page/binding/incoming_video_call_binding.dart';
import 'package:tingle/page/incoming_video_call_page/view/incoming_video_call_view.dart';
import 'package:tingle/page/language_page/binding/language_binding.dart';
import 'package:tingle/page/language_page/view/language_view.dart';
import 'package:tingle/page/level_page/binding/level_binding.dart';
import 'package:tingle/page/level_page/view/level_view.dart';
import 'package:tingle/page/live_page/binding/live_binding.dart';
import 'package:tingle/page/live_page/view/live_view.dart';
import 'package:tingle/page/live_summary_page/binding/live_summary_binding.dart';
import 'package:tingle/page/live_summary_page/view/live_summary_view.dart';
import 'package:tingle/page/login_page/binding/login_binding.dart';
import 'package:tingle/page/login_page/view/login_view.dart';
import 'package:tingle/page/message_page/binding/message_binding.dart';
import 'package:tingle/page/message_page/view/message_view.dart';
import 'package:tingle/page/host_request_page/binding/host_request_binding.dart';
import 'package:tingle/page/my_qr_code_page/binding/my_qr_code_binding.dart';
import 'package:tingle/page/my_qr_code_page/view/my_qr_code_view.dart';
import 'package:tingle/page/on_boarding_page/binding/on_boarding_binding.dart';
import 'package:tingle/page/on_boarding_page/view/on_boarding_view.dart';
import 'package:tingle/page/other_user_connection_page/binding/other_user_connection_binding.dart';
import 'package:tingle/page/other_user_connection_page/view/other_user_connection_view.dart';
import 'package:tingle/page/party_page/binding/party_binding.dart';
import 'package:tingle/page/party_page/view/party_view.dart';
import 'package:tingle/page/preview_created_reels_page/binding/preview_created_reels_binding.dart';
import 'package:tingle/page/preview_created_reels_page/view/preview_created_reels_view.dart';
import 'package:tingle/page/preview_shorts_video_page/binding/preview_shorts_video_binding.dart';
import 'package:tingle/page/preview_shorts_video_page/view/preview_shorts_video_view.dart';
import 'package:tingle/page/preview_upload_video_page/binding/preview_upload_video_binding.dart';
import 'package:tingle/page/preview_upload_video_page/view/preview_upload_video_view.dart';
import 'package:tingle/page/preview_user_profile_page/binding/preview_user_profile_binding.dart';
import 'package:tingle/page/preview_user_profile_page/view/preview_user_profile_view.dart';
import 'package:tingle/page/privacy_policy_page/binding/privacy_policy_binding.dart';
import 'package:tingle/page/privacy_policy_page/view/privacy_policy_view.dart';
import 'package:tingle/page/profile_feed_moment_page/binding/profile_moment_binding.dart';
import 'package:tingle/page/profile_feed_moment_page/view/profile_moment_view.dart';
import 'package:tingle/page/profile_page/binding/profile_binding.dart';
import 'package:tingle/page/profile_page/view/profile_view.dart';
import 'package:tingle/page/ranking_page/binding/ranking_binding.dart';
import 'package:tingle/page/ranking_page/view/ranking_view.dart';
import 'package:tingle/page/recharge_coin_page/binding/recharge_coin_binding.dart';
import 'package:tingle/page/recharge_coin_page/view/recharge_coin_view.dart';
import 'package:tingle/page/referral_page/binding/referral_binding.dart';
import 'package:tingle/page/referral_page/view/referral_view.dart';
import 'package:tingle/page/scan_qr_code_page/binding/scan_qr_code_binding.dart';
import 'package:tingle/page/scan_qr_code_page/view/scan_qr_code_view.dart';
import 'package:tingle/page/search_message_user_page/binding/search_message_user_binding.dart';
import 'package:tingle/page/search_message_user_page/view/search_message_user_view.dart';
import 'package:tingle/page/search_page/binding/search_binding.dart';
import 'package:tingle/page/search_page/view/search_view.dart';
import 'package:tingle/page/setting_page/binding/setting_binding.dart';
import 'package:tingle/page/setting_page/view/setting_view.dart';
import 'package:tingle/page/splash_banner_page/binding/splash_banner_binding.dart';
import 'package:tingle/page/splash_banner_page/view/splash_banner_view.dart';
import 'package:tingle/page/splash_screen_page/binding/splash_screen_binding.dart';
import 'package:tingle/page/splash_screen_page/view/splash_screen_view.dart';
import 'package:tingle/page/store_page/binding/store_binding.dart';
import 'package:tingle/page/store_page/view/store_view.dart';
import 'package:tingle/page/stream_page/binding/stream_binding.dart';
import 'package:tingle/page/stream_page/view/stream_view.dart';
import 'package:tingle/page/terms_of_use_page/binding/terms_of_use_binding.dart';
import 'package:tingle/page/terms_of_use_page/view/terms_of_use_view.dart';
import 'package:tingle/page/theme_outfit_page/binding/theme_outfit_binding.dart';
import 'package:tingle/page/theme_outfit_page/view/theme_outfit_view.dart';
import 'package:tingle/page/theme_page/binding/theme_binding.dart';
import 'package:tingle/page/theme_page/view/avtar_fame_view.dart';
import 'package:tingle/page/theme_page/view/car_theme_view.dart';
import 'package:tingle/page/theme_page/view/party_theme_view.dart';
import 'package:tingle/page/upload_feed_page/binding/upload_feed_binding.dart';
import 'package:tingle/page/upload_feed_page/view/upload_feed_view.dart';
import 'package:tingle/page/upload_video_page/binding/upload_video_binding.dart';
import 'package:tingle/page/upload_video_page/view/upload_video_view.dart';
import 'package:tingle/page/video_call_page/binding/video_call_binding.dart';
import 'package:tingle/page/video_call_page/view/video_call_view.dart';
import 'package:tingle/page/video_call_ringing_page/binding/video_call_ringing_binding.dart';
import 'package:tingle/page/video_call_ringing_page/view/video_call_ringing_view.dart';
import 'package:tingle/page/withdraw_page/binding/withdraw_binding.dart';
import 'package:tingle/page/withdraw_page/view/withdraw_view.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [

    GetPage(
      name: AppRoutes.splashScreenPage,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.onBoardingPage,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.fillProfilePage,
      page: () => const FillProfileView(),
      binding: FillProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfilePage,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomBarPage,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.reelsPage,
      page: () => const PartyView(),
      binding: PartyBinding(),
    ),
    GetPage(
      name: AppRoutes.streamPage,
      page: () => const StreamView(),
      binding: StreamBinding(),
    ),
    GetPage(
      name: AppRoutes.feedPage,
      page: () => const FeedView(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: AppRoutes.messagePage,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.uploadFeedPage,
      page: () => const UploadFeedView(),
      binding: UploadFeedBinding(),
    ),
    GetPage(
      name: AppRoutes.uploadVideoPage,
      page: () => const UploadVideoView(),
      binding: UploadVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.previewUploadVideoPage,
      page: () => const PreviewUploadVideoView(),
      binding: PreviewUploadVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.chatPage,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.audioRoomPage,
      page: () => const AudioRoomView(),
      binding: AudioRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeAudioRoomPage,
      page: () => const FakeAudioRoomView(),
      binding: FakeAudioRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.searchPage,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.searchMessageUserPage,
      page: () => const SearchMessageUserView(),
      binding: SearchMessageUserBinding(),
    ),
    GetPage(
      name: AppRoutes.incomingVideoCallPage,
      page: () => const IncomingVideoCallView(),
      binding: IncomingVideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCallPage,
      page: () => const VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCallRingingPage,
      page: () => const VideoCallRingingView(),
      binding: VideoCallRingingBinding(),
    ),
    GetPage(
      name: AppRoutes.editFeedPage,
      page: () => const EditFeedView(),
      binding: EditFeedBinding(),
    ),
    GetPage(
      name: AppRoutes.editVideoPage,
      page: () => const EditVideoView(),
      binding: EditVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.previewUserProfilePage,
      page: () => const PreviewUserProfileView(),
      binding: PreviewUserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.previewShortsVideoPage,
      page: () => const PreviewShortsVideoView(),
      binding: PreviewShortsVideoBinding(),
    ),
    GetPage(
      name: AppRoutes.connectionPage,
      page: () => const ConnectionView(),
      binding: ConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.searchConnectionPage,
      page: () => const SearchConnectionView(),
      binding: SearchConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.rechargeCoinPage,
      page: () => const RechargeCoinView(),
      binding: RechargeCoinBinding(),
    ),
    GetPage(
      name: AppRoutes.createReelsPage,
      page: () => const CreateReelsView(),
      binding: CreateReelsBinding(),
    ),
    GetPage(
      name: AppRoutes.previewCreatedReelsPage,
      page: () => const PreviewCreatedReelsView(),
      binding: PreviewCreatedReelsBinding(),
    ),
    GetPage(
      name: AppRoutes.audioWiseVideosPage,
      page: () => const AudioWiseVideosView(),
      binding: AudioWiseVideosBinding(),
    ),
    GetPage(
      name: AppRoutes.coinHistoryPage,
      page: () => const CoinHistoryView(),
      binding: CoinHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.livePage,
      page: () => const LiveView(),
      binding: LiveBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeLivePage,
      page: () => const FakeLiveView(),
      binding: FakeLiveBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeChatPage,
      page: () => const FakeChatView(),
      binding: FakeChatBinding(),
    ),
    GetPage(
      name: AppRoutes.chatPage,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.goLivePage,
      page: () => const GoLiveView(),
      binding: GoLiveBinding(),
    ),
    GetPage(
      name: AppRoutes.storePage,
      page: () => const StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: AppRoutes.rideFramePage,
      page: () => RideThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: AppRoutes.avtarFramePage,
      page: () => AvtarThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: AppRoutes.partyFramePage,
      page: () => PartyThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: AppRoutes.backpackPage,
      page: () => BackpackView(),
      binding: BackpackBinding(),
    ),
    GetPage(
      name: AppRoutes.themeOutfitPage,
      page: () => ThemeOutfitView(),
      binding: ThemeOutfitBinding(),
    ),
    GetPage(
      name: AppRoutes.createAudioRoomPage,
      page: () => CreateAudioRoomView(),
      binding: CreateAudioRoomBinding(),
    ),
    GetPage(
      name: AppRoutes.rankingPage,
      page: () => RankingView(),
      binding: RankingBinding(),
    ),
    GetPage(
      name: AppRoutes.helpPage,
      page: () => const HelpView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: AppRoutes.fansRankingPage,
      page: () => const FansRankingView(),
      binding: FansRankingBinding(),
    ),
    GetPage(
      name: AppRoutes.profileMomentPage,
      page: () => const ProfileMomentView(),
      binding: ProfileMomentBinding(),
    ),
    GetPage(
      name: AppRoutes.otherUserConnectionPage,
      page: () => const OtherUserConnectionView(),
      binding: OtherUserConnectionBinding(),
    ),
    GetPage(
      name: AppRoutes.settingPage,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.levelPage,
      page: () => const LevelView(),
      binding: LevelBinding(),
    ),
    GetPage(
      name: AppRoutes.referralPage,
      page: () => const ReferralView(),
      binding: ReferralBinding(),
    ),
    GetPage(
      name: AppRoutes.languagePage,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: AppRoutes.privacyPolicyPage,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: AppRoutes.termsOfUsePage,
      page: () => const TermsOfUseView(),
      binding: TermsOfUseBinding(),
    ),
    GetPage(
      name: AppRoutes.withdrawPage,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),
    GetPage(
      name: AppRoutes.myQrCodePage,
      page: () => const MyQrCodeView(),
      binding: MyQrCodeBinding(),
    ),
    GetPage(
      name: AppRoutes.scanQrCodePage,
      page: () => const ScanQrCodeView(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: AppRoutes.hostRequestPage,
      page: () => const HostRequestView(),
      binding: HostRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.aboutUsPage,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: AppRoutes.agencyPage,
      page: () => const AgencyView(),
      binding: AgencyBinding(),
    ),
    GetPage(
      name: AppRoutes.coinSellerPage,
      page: () => const CoinSellerView(),
      binding: CoinSellerBinding(),
    ),
    GetPage(
      name: AppRoutes.blockUserPage,
      page: () => BlockUserView(),
      binding: BlockUserBinding(),
    ),
    GetPage(
      name: AppRoutes.hostCenterPage,
      page: () => HostCenterView(),
      binding: HostCenterBinding(),
    ),
    GetPage(
      name: AppRoutes.liveSummaryPage,
      page: () => LiveSummaryView(),
      binding: LiveSummaryBinding(),
    ),
    GetPage(
      name: AppRoutes.splashBannerPage,
      page: () => SplashBannerView(),
      binding: SplashBannerBinding(),
    ),
    GetPage(
      name: AppRoutes.bannerWebViewPage,
      page: () => BannerWebViewView(),
      binding: BannerWebViewBinding(),
    ),

];
}