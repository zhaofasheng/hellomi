import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/api/fetch_gift_category_api.dart';
import 'package:tingle/common/function/banner_services.dart';
import 'package:tingle/common/function/country_services.dart';
import 'package:tingle/common/model/fetch_banner_model.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/page/feed_page/view/feed_view.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/page/message_page/view/message_view.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/party_page/view/party_view.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/profile_page/view/profile_view.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/view/stream_view.dart';
import 'package:tingle/socket/socket_services.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/internet_connection.dart';
import 'package:tingle/utils/utils.dart';

class BottomBarController extends GetxController {
  PreloadPageController preloadPageController = PreloadPageController();

  int selectedTabIndex = 0;



  List bottomBarPages = [
    const StreamView(),
    const PartyView(),
    const FeedView(),
    const MessageView(),
    const ProfileView(),
  ];

  @override
  void onInit() {
    init();

    super.onInit();
  }

  void init() async {
    SocketServices.onConnect();
    FetchGiftCategoryApi.onGetGiftCategory();
    CountryService.onGetCountries();

    await BannerServices.onGetTypeWiseBanner(bannerType: 1); // Gift Banner
    await BannerServices.onGetTypeWiseBanner(bannerType: 4); // Game Banner
    BannerServices.onInit();
    onInitPayment();

    BranchIoServices.onChangeRoutes(isBottomBarRoutes: true);
  }

  void onChangeBottomBar(int index) {
    Utils.showLog("onChangeBottomBar => $index");
    Utils.showLog("onChangeBottomBar => $selectedTabIndex");
    if (index != selectedTabIndex) {
      Utils.showLog("onChangeBottomBar => Enter");
      selectedTabIndex = index;
      update([AppConstant.onChangeBottomBar]);
      onGetTabWiseData();
    }
  }

  void onGetTabWiseData() {
    Utils.showLog("onGetTabWiseData => $selectedTabIndex");
    switch (selectedTabIndex) {
      case 0:
        {
          final controller = Get.find<StreamController>();
          controller.init();
        }
      case 1:
        {
          final controller = Get.find<PartyController>();
          controller.init();
        }
      case 2:
        {
          final controller = Get.find<FeedController>();
          controller.init();
        }
      case 3:
        {
          final controller = Get.find<MessageController>();
          controller.init();
        }
      case 4:
        {
          final controller = Get.find<ProfileController>();
          controller.init();
        }

      default:
    }
  }

  // ******************************************************************************************************************************************************

  Future<void> onInitPayment() async {
    if (InternetConnection.isConnect.value) {
      Stripe.publishableKey = Utils.stripeTestPublicKey;
      await Stripe.instance.applySettings();
    }
  }
}
