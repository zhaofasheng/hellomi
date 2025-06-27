import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:tingle/common/function/banner_services.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class SplashBannerController extends GetxController {
  String bannerImage = "";

  int autoSkipCount = 5;

  Timer? timer;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> init() async {
    bannerImage = onGetRandomImage();

    onChangeTime();
    Utils.showLog("Random Banner Image => $bannerImage");
  }

  String onGetRandomImage() {
    if (BannerServices.splashBannerList.isNotEmpty) {
      final int index = Random().nextInt(BannerServices.splashBannerList.length);
      return BannerServices.splashBannerList[index].imageUrl ?? "";
    } else {
      return "";
    }
  }

  void onChangeTime() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (T) {
        if (autoSkipCount > 1) {
          autoSkipCount--;
          update([AppConstant.onChangeTime]);
        } else {
          timer?.cancel();
          Get.offAllNamed(AppRoutes.bottomBarPage);
        }
      },
    );
  }
}
