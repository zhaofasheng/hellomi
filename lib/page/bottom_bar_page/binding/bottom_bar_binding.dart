import 'package:get/get.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/fans_ranking_page/controller/fans_ranking_controller.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomBarController());

    Get.put(StreamController());
    Get.put(PartyController());
    Get.put(FeedController());
    Get.put(MessageController());
    Get.put(ProfileController());

    Get.put(FansRankingController());
  }
}
