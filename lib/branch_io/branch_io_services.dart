import 'dart:async';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/utils.dart';

class BranchIoServices {
  static BranchUniversalObject? branchUniversalObject;
  static BranchContentMetaData branchContentMetaData = BranchContentMetaData();
  static BranchLinkProperties branchLinkProperties = BranchLinkProperties();

  static const String videoKey = "video";
  static const String postKey = "post";
  static const String profileKey = "profile";
  static const String referralKey = "referral";

  static String eventId = "";
  static String eventType = "";
  static String referralCode = "";

  static bool isNavigationComplete = false;

  // Call In Main...
  static Future<void> onInitializeBranchIo() async {
    try {
      await FlutterBranchSdk.init(enableLogging: true).then(
        (value) {
          FlutterBranchSdk.validateSDKIntegration();
          Utils.showLog("Branch Io Initialize Success");
        },
      );
    } catch (e) {
      Utils.showLog("Initialize Branch Io Failed !! => $e");
    }
  }

  // Use To Create Link...
  static Future<String?> onCreateBranchIoLink({
    required String pageRoutes,
    required String id,
    required String name,
    required String image,
    required String userId,
    String? referralCode,
  }) async {
    Utils.showLog("Create Branch Io Link Body => pageRoutes => $pageRoutes id => $id name => $name image => $image userId => $userId referralCode => $referralCode");

    try {
      BranchContentMetaData contentMetadata = BranchContentMetaData()
        ..addCustomMetadata("pageRoutes", pageRoutes)
        ..addCustomMetadata("id", id)
        ..addCustomMetadata("name", name)
        ..addCustomMetadata("image", image)
        ..addCustomMetadata("userId", userId);

      if (referralCode != null) contentMetadata.addCustomMetadata("referralCode", referralCode);

      BranchUniversalObject branchUniversalObject = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        title: name,
        imageUrl: image,
        contentDescription: "",
        publiclyIndex: true,
        locallyIndex: true,
        contentMetadata: contentMetadata,
      );

      BranchLinkProperties branchLinkProperties = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        tags: ['one', 'two', 'three'],
      );

      branchLinkProperties.addControlParam('url', 'http://www.google.com');
      branchLinkProperties.addControlParam('url2', 'http://flutter.dev');

      BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: branchUniversalObject, linkProperties: branchLinkProperties);

      if (response.success) {
        Utils.showLog("Generated Branch Io Link => ${response.result}");

        return response.result.toString();
      } else {
        Utils.showLog("Generating Branch Io Link Failed !! => ${response.errorCode} - ${response.errorMessage}");
        return null;
      }
    } catch (e) {
      Utils.showLog("Generated Branch Io Link Failed=> $e");
      return null;
    }
  }

  // Call In Splash Screen...
  static void onListenBranchIoLinks() async {
    FlutterBranchSdk.listSession().listen(
      (data) async {
        Utils.showLog("Branch Io Listen => $data");

        if (data.containsKey('+clicked_branch_link') && data['+clicked_branch_link'] == true) {
          isNavigationComplete = false;

          eventId = data["id"] ?? "";
          eventType = data['pageRoutes'] ?? "";
          referralCode = data['referralCode'] ?? "";

          onChangeRoutes(isBottomBarRoutes: false);
        }
      },
      onError: (error) {
        Utils.showLog('Branch Io Listen Error => ${error.toString()}');
      },
    );
  }

  // Call In Bottom Bar Controller...
  static Future<void> onChangeRoutes({required bool isBottomBarRoutes}) async {
    Utils.showLog("Branch Io Link => EventType => $eventType => EventId => $eventId => IsBottomBar => $isBottomBarRoutes");

    if (eventType.isEmpty || eventId.isEmpty) return;

    isBottomBarRoutes ? await 500.milliseconds.delay() : await 0.milliseconds.delay();

    bool isInitialize = Get.isRegistered<BottomBarController>();

    if (isInitialize && !isNavigationComplete) {
      Utils.showLog("Branch Io Link Navigation => EventType => $eventType => EventId => $eventId => IsBottomBar => $isBottomBarRoutes");

      isNavigationComplete = true;

      final bottomBarController = Get.find<BottomBarController>();

      switch (eventType) {
        case postKey:
          if (Get.isRegistered<BottomBarController>()) {
            bottomBarController.onChangeBottomBar(2);
          }
          break;
        case videoKey:
          if (Get.isRegistered<BottomBarController>()) {
            bottomBarController.onChangeBottomBar(2);
          }
          if (Get.isRegistered<FeedController>()) {
            final controller = Get.find<FeedController>();
            controller.onChangeTab(1);
          }
          break;

        case profileKey:
          if (Get.isRegistered<BottomBarController>()) {
            OtherUserProfileBottomSheet.show(context: Get.context!, userID: eventId);
          }
          break;
      }
    }
  }
}

// class BranchIoServices {
//   static const String videoKey = "video";
//   static const String postKey = "post";
//   static const String profileKey = "profile";
//   static const String referralKey = "referral";
//
//   static String eventId = "";
//   static String eventType = "";
//
//   static BranchContentMetaData branchContentMetaData = BranchContentMetaData();
//   static BranchUniversalObject? branchUniversalObject;
//   static BranchLinkProperties branchLinkProperties = BranchLinkProperties();
//
//   static const String _pageRoutesKey = "pageRoutes";
//   static const String _idKey = "id";
//   static const String _nameKey = "name";
//   static const String _userIdKey = "userId";
//   static const String _imageKey = "image";
//
//   // This is Use to Splash Screen...
//   static void onListenBranchIoLinks() async {
//     StreamController<String> streamController = StreamController<String>();
//     FlutterBranchSdk.initSession().listen(
//       (data) {
//         streamController.sink.add((data.toString()));
//
//         if (data.containsKey('+clicked_branch_link') && data['+clicked_branch_link'] == true) {
//           eventId = data[_idKey];
//           eventType = data[_pageRoutesKey];
//
//           Utils.showLog('Click To Branch Io Link => $eventType');
//         }
//       },
//       onError: (e) {
//         Utils.showLog("Branch Io Listen Failed => $e");
//       },
//     );
//     // Utils.showLog("Stream Subscription => $streamController");
//   }
//
//   static Future<void> onCreateBranchIoLink({
//     required String pageRoutes,
//     required String id,
//     required String name,
//     required String image,
//     required String userId,
//   }) async {
//     String imageUrl = image;
//
//     if (!image.startsWith('http')) {
//       imageUrl = Api.baseUrl + image;
//     }
//
//     branchContentMetaData = BranchContentMetaData()
//       ..addCustomMetadata(_pageRoutesKey, pageRoutes)
//       ..addCustomMetadata(_idKey, id)
//       ..addCustomMetadata(_nameKey, name)
//       ..addCustomMetadata(_imageKey, imageUrl)
//       ..addCustomMetadata(_userIdKey, userId);
//
//     branchUniversalObject = BranchUniversalObject(
//       canonicalIdentifier: 'flutter/branch',
//       canonicalUrl: 'https://flutter.dev',
//       title: name,
//       imageUrl: imageUrl,
//       contentDescription: name,
//       contentMetadata: branchContentMetaData,
//       keywords: ['Plugin', 'Branch', 'Flutter'],
//       publiclyIndex: true,
//       locallyIndex: true,
//       expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch,
//     );
//
//     branchLinkProperties = BranchLinkProperties(
//       channel: 'facebook',
//       feature: 'sharing',
//       stage: 'new share',
//       campaign: 'campaign',
//       tags: ['one', 'two', 'three'],
//     )
//       ..addControlParam('\$uri_redirect_mode', '1')
//       ..addControlParam('\$ios_nativelink', true)
//       ..addControlParam('\$match_duration', 7200)
//       ..addControlParam('\$always_deeplink', true)
//       ..addControlParam('\$android_redirect_timeout', 750)
//       ..addControlParam('referring_user_id', 'user_id');
//   }
//
//   static Future<String?> onGenerateLink() async {
//     try {
//       BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: branchUniversalObject!, linkProperties: branchLinkProperties);
//       if (response.success) {
//         Utils.showLog("Generated Branch Io Link => ${response.result}");
//         return response.result.toString();
//       } else {
//         Utils.showLog("Generating Branch Io Link Failed => $response");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Generating Branch Io Link Failed => $e");
//       return null;
//     }
//   }
//
//   static Future<void> onChangeRoutes() async {
//     if (eventType.isEmpty || eventId.isEmpty) return;
//
//     bool isInitialize = Get.isRegistered<BottomBarController>();
//     final bottomBarController = isInitialize ? Get.find<BottomBarController>() : Get.put(BottomBarController());
//
//     await 500.milliseconds.delay();
//
//     switch (eventType) {
//       case postKey:
//         bottomBarController.onChangeBottomBar(2);
//         break;
//       case videoKey:
//         bottomBarController.onChangeBottomBar(2);
//         if (Get.isRegistered<FeedController>()) {
//           final controller = Get.find<FeedController>();
//           controller.onChangeTab(1);
//         }
//         break;
//     }
//   }
// }
