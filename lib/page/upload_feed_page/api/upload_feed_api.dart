import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:tingle/notification/notification_services.dart';
import 'package:tingle/page/upload_feed_page/model/upload_feed_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class UploadFeedApi {
  static int _uploadNotificationId = 0;
  static final Dio _dio = Dio();

  static Future<UploadFeedModel?> callApi({
    required String uid,
    required String token,
    required List postImages,
    required String caption,
    required String hashTagId,
    required String mentionedUserIds,
  }) async {
    _uploadNotificationId = Random().nextInt(10000);
    Utils.showLog("Upload Feed API Calling...");

    try {
      // Prepare form data
      final formData = FormData.fromMap({
        ApiParams.caption: caption,
        ApiParams.hashTagId: hashTagId,
        ApiParams.mentionedUserIds: mentionedUserIds,
      });

      // Add all images to form data
      for (int i = 0; i < postImages.length; i++) {
        formData.files.add(MapEntry(
          ApiParams.postImage,
          await MultipartFile.fromFile(
            postImages[i],
            filename: 'post_image_$i.jpg',
          ),
        ));
      }

      // Set headers
      final headers = {
        ApiParams.key: Api.secretKey,
        ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
        ApiParams.uidKey: uid,
      };

      // Show initial notification
      await _showProgressNotification(0, 'Preparing upload...');

      // Make the request
      final response = await _dio.post(
        Api.uploadPost,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: (int sent, int total) async {
          final progress = ((sent / total) * 100).toInt();
          await _showProgressNotification(progress, '$progress% uploaded');
          Utils.showLog("Upload Progress: $progress% ($sent/$total bytes)");
        },
      );

      // Handle successful response
      if (response.statusCode == 200) {
        final jsonResult = response.data;

        // Instead of cancelling, just update the existing notification
        await _showCompletionNotification();

        Utils.showLog("Upload completed successfully!");
        return UploadFeedModel.fromJson(jsonResult);
      } else {
        // Handle failed response
        await _showErrorNotification('Error uploading post');
        Utils.showLog("Upload failed with status code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle errors
      await _showErrorNotification('Error: ${e.toString()}');
      Utils.showLog("Error occurred: ${e.toString()}");
      return null;
    }
  }

  static Future<void> _showProgressNotification(int progress, String message) async {
    try {
      await NotificationServices.showUploadProgressNotification(
        notificationId: _uploadNotificationId,
        title: 'Uploading Post',
        body: message,
        progress: progress,
        isCompleted: false,
      );
    } catch (e) {
      Utils.showLog("Error showing progress notification: $e");
    }
  }

  static Future<void> _showCompletionNotification() async {
    try {
      // Use the same notification ID to update the existing notification
      await NotificationServices.showUploadProgressNotification(
        notificationId: _uploadNotificationId,
        title: 'Upload Complete',
        body: 'Post uploaded successfully!',
        progress: 100,
        isCompleted: true,
      );
    } catch (e) {
      Utils.showLog("Error showing completion notification: $e");
    }
  }

  static Future<void> _showErrorNotification(String error) async {
    try {
      await NotificationServices.showUploadProgressNotification(
        notificationId: _uploadNotificationId,
        title: 'Upload Failed',
        body: error,
        progress: 0,
        isCompleted: true,
      );
    } catch (e) {
      Utils.showLog("Error showing error notification: $e");
    }
  }
}

// class UploadFeedApi {
//   static int _uploadNotificationId = 0;
//   static final Dio _dio = Dio();
//
//   static Future<UploadFeedModel?> callApi({
//     required String uid,
//     required String token,
//     required List postImages,
//     required String caption,
//     required String hashTagId,
//     required String mentionedUserIds,
//   }) async {
//     _uploadNotificationId = Random().nextInt(10000);
//     Utils.showLog("Upload Feed API Calling...");
//
//     try {
//       // Prepare form data
//       final formData = FormData.fromMap({
//         ApiParams.caption: caption,
//         ApiParams.hashTagId: hashTagId,
//         ApiParams.mentionedUserIds: mentionedUserIds,
//       });
//
//       // Add all images to form data
//       for (int i = 0; i < postImages.length; i++) {
//         formData.files.add(MapEntry(
//           ApiParams.postImage,
//           await MultipartFile.fromFile(
//             postImages[i],
//             filename: 'post_image_$i.jpg',
//           ),
//         ));
//       }
//
//       // Set headers
//       final headers = {
//         ApiParams.key: Api.secretKey,
//         ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
//         ApiParams.uidKey: uid,
//       };
//
//       // Show initial notification
//       await NotificationServices.showUploadProgressNotification(
//         notificationId: _uploadNotificationId,
//         title: 'Uploading Post',
//         body: 'Preparing upload...',
//         progress: 0,
//         isCompleted: false,
//       );
//       Utils.showLog("Upload Progress: 0%");
//
//       // Make the request
//       final response = await _dio.post(
//         Api.uploadPost,
//         data: formData,
//         options: Options(headers: headers),
//         onSendProgress: (int sent, int total) async {
//           final progress = ((sent / total) * 100).toInt();
//
//           // Update notification
//           await NotificationServices.showUploadProgressNotification(
//             notificationId: _uploadNotificationId,
//             title: 'Uploading Post',
//             body: '$progress% uploaded',
//             progress: progress,
//             isCompleted: false,
//           );
//
//           Utils.showLog("Upload Progress: $progress% ($sent/$total bytes)");
//         },
//       );
//
//       Utils.showLog("------------ ${response}");
//       Utils.showLog("***************** ${response.statusCode}");
//
//       // Handle successful response
//       if (response.statusCode == 200) {
//         final jsonResult = response.data;
//
//         await NotificationServices.cancelUploadNotification(_uploadNotificationId);
//
//         await NotificationServices.showUploadProgressNotification(
//           notificationId: _uploadNotificationId + 1, // New ID for completion
//           title: 'Upload Complete',
//           body: 'Post uploaded successfully!',
//           progress: 100,
//           isCompleted: true,
//         );
//
//         Utils.showLog("Upload Progress: 100% - Upload completed successfully!");
//
//         return UploadFeedModel.fromJson(jsonResult);
//       } else {
//         // Handle failed response
//         await NotificationServices.showUploadProgressNotification(
//           notificationId: _uploadNotificationId,
//           title: 'Upload Failed',
//           body: 'Error uploading post',
//           progress: 0,
//           isCompleted: true,
//         );
//         Utils.showLog("Upload Progress: 0% - Upload failed with status code ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       // Handle errors
//       await NotificationServices.showUploadProgressNotification(
//         notificationId: _uploadNotificationId,
//         title: 'Upload Failed',
//         body: 'Error: ${e.toString()}',
//         progress: 0,
//         isCompleted: true,
//       );
//       Utils.showLog("Upload Progress: 0% - Error occurred: ${e.toString()}");
//       return null;
//     }
//   }
// }

// TODO WITHOUT PROGRESS UPLOAD POST API

// class UploadFeedApi {
//   static Future<UploadFeedModel?> callApi({
//     required String uid,
//     required String token,
//     required List postImages,
//     required String caption,
//     required String hashTagId,
//     required String mentionedUserIds,
//   }) async {
//     Utils.showLog("Upload Feed Api Calling... $caption");
//
//     try {
//       final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};
//
//       var request = http.MultipartRequest('POST', Uri.parse(Api.uploadPost));
//
//       request.fields.addAll({
//         ApiParams.caption: caption,
//         ApiParams.hashTagId: hashTagId,
//         ApiParams.mentionedUserIds: mentionedUserIds,
//       });
//
//       Utils.showLog("Upload Feed Api Headers => $headers");
//
//       List<Future> images = [];
//
//       for (int i = 0; i < postImages.length; i++) {
//         images.add(
//           http.MultipartFile.fromPath(ApiParams.postImage, postImages[i]).then(
//             (value) => request.files.add(value),
//           ),
//         );
//       }
//
//       request.headers.addAll(headers);
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final jsonResult = jsonDecode(responseBody);
//         Utils.showLog("Upload Feed Api Response => $jsonResult");
//         return UploadFeedModel.fromJson(jsonResult);
//       } else {
//         Utils.showLog("Upload Feed Api Response Error");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Upload Feed Api Error => $e");
//       return null;
//     }
//   }
// }
