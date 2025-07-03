import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tingle/common/function/show_received_banner.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/notification/notification_services.dart';
import 'package:tingle/routes/app_pages.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/platform_device_id.dart';
import 'package:tingle/utils/utils.dart';
import 'branch_io/branch_io_services.dart';
import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
import 'page/splash_screen_page/binding/splash_screen_binding.dart';
import 'page/splash_screen_page/view/splash_screen_view.dart';
import 'utils/internet_connection.dart';


void main() async {
  Utils.showLog("App Start... Check 1");

  WidgetsFlutterBinding.ensureInitialized();

  Utils.showLog("App Start... Check 2");
  await BranchIoServices.onInitializeBranchIo();

  Utils.showLog("App Start... Check 3");

  await Future.delayed(const Duration(milliseconds: 500)); // THIS USE TO IOS WHITE SCREEN

  InternetConnection.init();
  await Firebase.initializeApp();
  await GetStorage.init();

  Utils.showLog("App Start... Check 4");

  NotificationServices.init();
  NotificationServices.firebaseInit();
  NotificationServices.requestNotificationPermission();
  FirebaseMessaging.onBackgroundMessage(NotificationServices.onShowBackgroundNotification);

  Utils.showLog("App Start... Check 5");

  await onSecureScreen();

  final identity = await PlatformDeviceId.getDeviceId;
  String? fcmToken;

  // 第一次尝试获取 FCM Token
  try {
    final connectivityResultList = await Connectivity().checkConnectivity();
    if (connectivityResultList.isNotEmpty &&
        connectivityResultList.first != ConnectivityResult.none) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      Utils.showLog("✅ 首次尝试 FCM Token 成功: $fcmToken");
    } else {
      Utils.showLog("⚠️ 无网络，等待网络恢复后重试获取 FCM Token");
    }
  } catch (e) {
    Utils.showLog("❌ 首次尝试获取 FCM Token 异常: $e");
  }

  // 如果第一次获取失败，监听网络变化，首次连网后再获取
  if (fcmToken == null) {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
      if (results.isNotEmpty &&
          results.first != ConnectivityResult.none &&
          fcmToken == null) {
        try {
          fcmToken = await FirebaseMessaging.instance.getToken();
          Utils.showLog("✅ 网络恢复后 FCM Token 获取成功: $fcmToken");

          if (identity != null && fcmToken != null) {
            await Database.init(identity, fcmToken!);
          }
        } catch (e) {
          Utils.showLog("❌ 网络恢复后获取 FCM Token 异常: $e");
        }
      }
    });
  } else {
    if (identity != null) {
      await Database.init(identity, fcmToken);
    }
  }

  Utils.showLog("App Start... Check 7");

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final StreamController purchaseStreamController = StreamController<PurchaseDetails>.broadcast();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    Utils.showLog("App Start... Check 8");
    Utils.isAppOpen.value = true;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    Utils.isAppOpen.value = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Utils.isAppOpen.value = true;
      Utils.showLog("User Back To App...");
    }
    if (state == AppLifecycleState.inactive) {
      Utils.isAppOpen.value = false;
      Utils.showLog("User Try To Exit...");
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          Get.updateLocale(locale);
        });
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Utils.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      getPages: AppPages.list,
      initialRoute: AppRoutes.initial,
      translations: AppLanguages(),
      fallbackLocale: const Locale(AppConstant.languageEn, AppConstant.countryCodeEn),
      locale: const Locale(AppConstant.languageEn),
      unknownRoute: GetPage(
        name: AppRoutes.splashScreenPage,
        page: () => const SplashScreenView(),
        binding: SplashScreenBinding(),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0), // 禁止系统字体缩放影响布局
          ),
          child: Stack(
            children: [
              child ?? const SizedBox(), // 主页面内容
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ShowReceivedBanner.onShowSenderDetails(), // 顶部悬浮 Banner
              ),
            ],
          ),
        );
      },
    );
  }
}

// ********************************************************************************************************************************************

Future<void> onSecureScreen() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

//*************************************** DO NOT REMOVE THIS CODE ****************************************

// 😘Good morning, Have a nice day!😘 ❤️ Best place of mountain adventure....

/* DEMO STATIC VALUE */

class DisplayOverlay {
  static RxDouble topPosition = 100.0.obs;
  static RxDouble leftPosition = 100.0.obs;

  static double circleSize = 70;

  static RxBool isShowOverlay = false.obs;

  static void onToggleOverlay({bool? value}) {
    isShowOverlay.value = value ?? !isShowOverlay.value;
    Utils.showLog("*******************$value");
  }

  static Widget onShowOverlayWidget({required BuildContext context}) {
    return Obx(
      () => Visibility(
        visible: isShowOverlay.value,
        child: Positioned(
          left: leftPosition.value,
          top: topPosition.value,
          child: GestureDetector(
            onPanUpdate: (details) {
              double newX = leftPosition.value + details.delta.dx;
              double newY = topPosition.value + details.delta.dy;

              leftPosition.value = newX.clamp(0.0, Get.width - circleSize);

              topPosition.value = newY.clamp(MediaQuery.of(context).viewPadding.top, Get.height - (circleSize + Get.bottomBarHeight));
            },
            child: Container(
              height: circleSize,
              width: circleSize,
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () => Utils.showLog("9999999999999999"),
                      child: Container(
                        height: circleSize - 20,
                        width: circleSize - 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withValues(alpha: 0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: CircleAudioRoomWidget(circleSize: circleSize - 20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => onToggleOverlay(),
                      child: Container(
                        height: 30,
                        width: 30,
                        color: AppColor.transparent,
                        alignment: Alignment.center,
                        child: Container(
                          height: 15,
                          width: 15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.black,
                          ),
                          child: Image.asset(
                            AppAssets.icClose,
                            width: 10,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleAudioRoomWidget extends StatefulWidget {
  const CircleAudioRoomWidget({super.key, required this.circleSize});

  final double circleSize;

  @override
  State<CircleAudioRoomWidget> createState() => _CircleAudioRoomWidgetState();
}

class _CircleAudioRoomWidgetState extends State<CircleAudioRoomWidget> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    Utils.isCurrentlyVideoPage.value = true;

    onInitAnimation();

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();

    super.dispose();
  }

  void onInitAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    if (animationController != null) {
      animation = Tween(begin: 0.0, end: 1.0).animate(animationController!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.transparent,
        height: widget.circleSize,
        width: widget.circleSize,
        child: animation != null
            ? Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  RotationTransition(turns: animation!, child: Image.asset(AppAssets.icMusicDish)),
                  RotationTransition(
                    turns: animation!,
                    child: Container(
                      width: widget.circleSize - 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: PreviewProfileImageWidget(
                        image: Database.fetchLoginUserProfile()?.user?.image,
                        isShowPlaceHolder: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: -4,
                    child: Image.asset(AppAssets.icAudioRoomIcon, color: AppColor.white, width: 20),
                  ),
                ],
              )
            : Offstage());
  }
}

//  Init Comment
