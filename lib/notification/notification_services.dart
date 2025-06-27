import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class NotificationServices {
  static Callback callback = () {};

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // This Method Call in Main...
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_notification');

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: initializationSettingsDarwin);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        callback.call();
      },
    );

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Notification",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      playSound: true,
      channel.id,
      channel.name,
      channelDescription: "your channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      enableVibration: true,
      icon: "@mipmap/ic_notification",
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      Random.secure().nextInt(100000),
      message.notification?.title.toString(),
      message.notification?.body.toString(),
      notificationDetails,
    );
  }

  static Future<void> firebaseInit() async {
    // This Method Call in Main...
    FirebaseMessaging.onMessage.listen(
      (message) {
        Utils.showLog("Local Notification => Is Show Notification => ${Database.isShowNotification} => Is App Open => }");
        Utils.showLog("Notification => ${message.data}");
        Utils.showLog("Notification Title => ${message.notification?.title.toString()}");
        Utils.showLog("Notification Body => ${message.notification?.body.toString()}");

        Utils.showLog("******* ${Get.currentRoute}");

        if (AppRoutes.chatPage == Get.currentRoute && message.data[ApiParams.type] == "CHAT") {
          Utils.showLog("This Is Chat Page Notification Muted");
        } else {
          if (Database.isShowNotification) showNotification(message);
        }

        if (Database.isShowNotification) {
          callback = () async {
            try {
              onChangeRoutes(message.data["type"]);
            } catch (e) {
              Utils.showLog("Notification Change Routes Failed => $e");
            }
          };
        }
      },
    );
  }

  static Future<void> onShowBackgroundNotification(RemoteMessage message) async {
    Utils.showLog("Background Notification => Is Show Notification => ${Database.isShowNotification} => Is App Open =>  => ${message.messageId}");
  }

  static Future<void> showUploadProgressNotification({
    required int notificationId,
    required String title,
    required String body,
    required int progress,
    required bool isCompleted,
  }) async {
    const String channelId = 'upload_progress';
    const String channelName = 'Upload Progress';

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Video Upload Process',
      importance: Importance.max,
      audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
      category: AndroidNotificationCategory.event,
      enableVibration: true,
      ticker: "Test",
      visibility: NotificationVisibility.public,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      progress: progress.clamp(0, 100),
      maxProgress: 100,
      ongoing: !isCompleted,
      autoCancel: isCompleted,
      playSound: true,
      icon: '@mipmap/ic_notification',
    );

    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.aiff', // iOS sound file
      subtitle: 'Upload Progress', // Subtitle
      threadIdentifier: 'video-upload', // Thread ID
      badgeNumber: isCompleted ? 1 : null, // Badge when complete
      attachments: null,
      interruptionLevel: isCompleted ? InterruptionLevel.timeSensitive : InterruptionLevel.passive,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> cancelUploadNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  static Future<void> requestNotificationPermission() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void onChangeRoutes(String type) async {
    switch (type) {
      case "REFERRAL_REWARD":
        {
          if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
          await 200.milliseconds.delay();
          Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 2});
        }
      case "FOLLOW":
        {
          if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
          await 200.milliseconds.delay();
          Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 2});
        }
      case "CHAT":
        {
          if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
          await 200.milliseconds.delay();
          final controller = Get.find<BottomBarController>();
          controller.onChangeBottomBar(3); // Go To Chat Page...
        }
      case "LIVE":
        {
          if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
          await 200.milliseconds.delay();
          final controller = Get.find<BottomBarController>();
          controller.onChangeBottomBar(0); // Go To Chat Page...
        }
      case "POSTLIKE":
        {
          if (Get.currentRoute != AppRoutes.previewUserProfilePage) {
            if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
            await 200.milliseconds.delay();
            Get.toNamed(AppRoutes.previewUserProfilePage, arguments: Database.loginUserId);
            await 100.milliseconds.delay();
            if (Get.isRegistered<PreviewUserProfileController>()) {
              final controller = Get.find<PreviewUserProfileController>();
              controller.onChangeTab(1);
            }
          }
        }
      case "POSTCOMMENT":
        {
          if (Get.currentRoute != AppRoutes.previewUserProfilePage) {
            if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
            await 200.milliseconds.delay();
            Get.toNamed(AppRoutes.previewUserProfilePage, arguments: Database.loginUserId);
            await 100.milliseconds.delay();
            if (Get.isRegistered<PreviewUserProfileController>()) {
              final controller = Get.find<PreviewUserProfileController>();
              controller.onChangeTab(1);
            }
          }
        }
      case "VIDEOLIKE":
        {
          if (Get.currentRoute != AppRoutes.previewUserProfilePage) {
            if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
            await 200.milliseconds.delay();
            Get.toNamed(AppRoutes.previewUserProfilePage, arguments: Database.loginUserId);
            await 100.milliseconds.delay();
            if (Get.isRegistered<PreviewUserProfileController>()) {
              final controller = Get.find<PreviewUserProfileController>();
              controller.onChangeTab(2);
            }
          }
        }
      case "VIDEOCOMMENT":
        {
          if (Get.currentRoute != AppRoutes.previewUserProfilePage) {
            if (Get.currentRoute != AppRoutes.bottomBarPage) Get.offAllNamed(AppRoutes.bottomBarPage);
            await 200.milliseconds.delay();
            Get.toNamed(AppRoutes.previewUserProfilePage, arguments: Database.loginUserId);
            await 100.milliseconds.delay();
            if (Get.isRegistered<PreviewUserProfileController>()) {
              final controller = Get.find<PreviewUserProfileController>();
              controller.onChangeTab(2);
            }
          }
        }
      case "REPORT_SUBMISSION":
      default:
    }
  }
}

//

//
// static Future<void> showUploadProgressNotification({
// required int notificationId,
// required String title,
// required String body,
// required int progress,
// required bool isCompleted,
// }) async {
// try {
// // Android Configuration
// const String channelId = 'upload_progress';
// const String channelName = 'Upload Progress';
//
// // Create Android Notification Channel (only needed once)
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
// channelId,
// channelName,
// importance: Importance.max,
// playSound: true,
// sound: RawResourceAndroidNotificationSound('notification_sound'),
// enableVibration: true,
// // vibrationPattern: Int64List.fromList([0, 250, 250, 250]),
// description: 'Video Upload Progress Notifications',
// );
//
// await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//
// // Android Notification Details
// final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
// channelId,
// channelName,
// channelDescription: 'Video Upload Process',
// importance: Importance.max,
// priority: Priority.high,
// playSound: isCompleted, // Only play sound when completed
// sound: isCompleted ? const RawResourceAndroidNotificationSound('notification_sound') : null,
// enableVibration: isCompleted, // Only vibrate when completed
// onlyAlertOnce: !isCompleted, // Only alert once during progress
// showProgress: !isCompleted, // Show progress bar only during upload
// progress: progress.clamp(0, 100),
// maxProgress: 100,
// ongoing: !isCompleted, // Ongoing during upload
// autoCancel: isCompleted, // Auto cancel when completed
// icon: '@mipmap/ic_notification',
// color: AppColor.primary,
// colorized: true,
// styleInformation: isCompleted
// ? BigTextStyleInformation(body) // Show big text when complete
//     : null,
// );
//
// // iOS Notification Details
// final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
// presentAlert: true, // Always show alert
// presentBadge: true,
// presentSound: isCompleted, // Play sound only when complete
// sound: 'notification_sound.aiff', // iOS sound file
// subtitle: 'Upload Progress', // Subtitle
// threadIdentifier: 'video-upload', // Thread ID
// badgeNumber: isCompleted ? 1 : null, // Badge when complete
// attachments: null,
// interruptionLevel: isCompleted ? InterruptionLevel.timeSensitive : InterruptionLevel.passive,
// );
//
// final NotificationDetails notificationDetails = NotificationDetails(
// android: androidNotificationDetails,
// iOS: darwinNotificationDetails,
// );
//
// // Show notification
// await _flutterLocalNotificationsPlugin.show(
// notificationId,
// title,
// body,
// notificationDetails,
// );
//
// // For iOS foreground notifications
// if (isCompleted) {
// await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
// alert: true,
// badge: true,
// sound: true,
// );
// }
// } catch (e) {
// debugPrint('Error showing notification: $e');
// }
// }
