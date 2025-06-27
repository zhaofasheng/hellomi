import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:tingle/notification/notification_services.dart';
import 'package:tingle/page/upload_video_page/model/upload_video_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class UploadVideoApi {
  static int _uploadNotificationId = 0;
  static final Dio _dio = Dio();

  static Future<UploadVideoModel?> callApi({required UploadVideoParameterModel parameter}) async {
    _uploadNotificationId = Random().nextInt(10000);
    Utils.showLog("Upload Video API Calling...");

    try {
      // Prepare form data
      final formData = FormData.fromMap({
        ApiParams.videoTime: parameter.videoTime,
        ApiParams.caption: parameter.caption,
        ApiParams.hashTagId: parameter.hashTagId,
        ApiParams.mentionedUserIds: parameter.mentionedUserIds,
        ApiParams.songId: parameter.songId,
        ApiParams.videoImage: await MultipartFile.fromFile(
          parameter.videoImage,
          filename: 'video_image.jpg',
        ),
        ApiParams.videoUrl: await MultipartFile.fromFile(
          parameter.videoUrl,
          filename: 'video.mp4',
        ),
      });

      // Set headers
      final headers = {
        ApiParams.key: Api.secretKey,
        ApiParams.tokenKey: ApiParams.tokenStartPoint + parameter.token,
        ApiParams.uidKey: parameter.uid,
      };

      // Show initial notification
      await _showProgressNotification(0, 'Preparing upload...');

      // Make the request
      final response = await _dio.post(
        Api.uploadVideo,
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

        // Simply update the existing notification to show completion
        await _showCompletionNotification();

        Utils.showLog("Upload completed successfully!");
        return UploadVideoModel.fromJson(jsonResult);
      } else {
        await _showErrorNotification('Upload failed with status code ${response.statusCode}');
        Utils.showLog("Upload failed with status code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      await _showErrorNotification('Error: ${e.toString()}');
      Utils.showLog("Error occurred: ${e.toString()}");
      return null;
    }
  }

  static Future<void> _showProgressNotification(int progress, String message) async {
    try {
      await NotificationServices.showUploadProgressNotification(
        notificationId: _uploadNotificationId,
        title: 'Uploading Video',
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
      // Update the existing notification instead of creating a new one
      await NotificationServices.showUploadProgressNotification(
        notificationId: _uploadNotificationId,
        title: 'Upload Complete',
        body: 'Video uploaded successfully!',
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

// class UploadVideoApi {
//   static int _uploadNotificationId = 0;
//   static final Dio _dio = Dio();
//
//   static Future<UploadVideoModel?> callApi({required UploadVideoParameterModel parameter}) async {
//     _uploadNotificationId = Random().nextInt(10000);
//     Utils.showLog("Upload Video API Calling...");
//
//     try {
//       // Prepare form data
//       final formData = FormData.fromMap({
//         ApiParams.videoTime: parameter.videoTime,
//         ApiParams.caption: parameter.caption,
//         ApiParams.hashTagId: parameter.hashTagId,
//         ApiParams.mentionedUserIds: parameter.mentionedUserIds,
//         ApiParams.songId: parameter.songId,
//         ApiParams.videoImage: await MultipartFile.fromFile(
//           parameter.videoImage,
//           filename: 'video_image.jpg',
//         ),
//         ApiParams.videoUrl: await MultipartFile.fromFile(
//           parameter.videoUrl,
//           filename: 'video.mp4',
//         ),
//       });
//
//       // Set headers
//       final headers = {
//         ApiParams.key: Api.secretKey,
//         ApiParams.tokenKey: ApiParams.tokenStartPoint + parameter.token,
//         ApiParams.uidKey: parameter.uid,
//       };
//
//       // Show initial notification
//       await _showProgressNotification(0, 'Preparing upload...');
//
//       // Make the request
//       final response = await _dio.post(
//         Api.uploadVideo,
//         data: formData,
//         options: Options(headers: headers),
//         onSendProgress: (int sent, int total) async {
//           final progress = ((sent / total) * 100).toInt();
//           await _showProgressNotification(progress, '$progress% uploaded');
//           Utils.showLog("Upload Progress: $progress% ($sent/$total bytes)");
//         },
//       );
//
//       // Handle successful response
//       if (response.statusCode == 200) {
//         final jsonResult = response.data;
//
//         // Add small delay to ensure previous notification operations complete
//         await Future.delayed(const Duration(milliseconds: 300));
//
//         // Cancel old notification safely
//         await _cancelNotificationSafely();
//
//         // Show completion notification
//         await _showCompletionNotification();
//
//         Utils.showLog("Upload completed successfully!");
//         return UploadVideoModel.fromJson(jsonResult);
//       } else {
//         await _showErrorNotification('Upload failed with status code ${response.statusCode}');
//         Utils.showLog("Upload failed with status code ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       await _showErrorNotification('Error: ${e.toString()}');
//       Utils.showLog("Error occurred: ${e.toString()}");
//       return null;
//     }
//   }
//
//   static Future<void> _showProgressNotification(int progress, String message) async {
//     try {
//       await NotificationServices.showUploadProgressNotification(
//         notificationId: _uploadNotificationId,
//         title: 'Uploading Video',
//         body: message,
//         progress: progress,
//         isCompleted: false,
//       );
//     } catch (e) {
//       Utils.showLog("Error showing progress notification: $e");
//     }
//   }
//
//   static Future<void> _cancelNotificationSafely() async {
//     try {
//       await NotificationServices.cancelUploadNotification(_uploadNotificationId);
//     } catch (e) {
//       Utils.showLog("Error cancelling notification: $e");
//     }
//   }
//
//   static Future<void> _showCompletionNotification() async {
//     try {
//       await NotificationServices.showUploadProgressNotification(
//         notificationId: _uploadNotificationId + 1,
//         title: 'Upload Complete',
//         body: 'Video uploaded successfully!',
//         progress: 100,
//         isCompleted: true,
//       );
//     } catch (e) {
//       Utils.showLog("Error showing completion notification: $e");
//     }
//   }
//
//   static Future<void> _showErrorNotification(String error) async {
//     try {
//       await NotificationServices.showUploadProgressNotification(
//         notificationId: _uploadNotificationId,
//         title: 'Upload Failed',
//         body: error,
//         progress: 0,
//         isCompleted: true,
//       );
//     } catch (e) {
//       Utils.showLog("Error showing error notification: $e");
//     }
//   }
// }

//**************************************************************************
// class UploadVideoApi {
//   static int _uploadNotificationId = 0;
//   static final Dio _dio = Dio();
//
//   static Future<UploadVideoModel?> callApi({required UploadVideoParameterModel parameter}) async {
//     _uploadNotificationId = Random().nextInt(10000);
//     Utils.showLog("Upload Video API Calling...");
//
//     try {
//       // Prepare form data
//       final formData = FormData.fromMap({
//         ApiParams.videoTime: parameter.videoTime,
//         ApiParams.caption: parameter.caption,
//         ApiParams.hashTagId: parameter.hashTagId,
//         ApiParams.mentionedUserIds: parameter.mentionedUserIds,
//         ApiParams.songId: parameter.songId,
//         ApiParams.videoImage: await MultipartFile.fromFile(
//           parameter.videoImage,
//           filename: 'video_image.jpg',
//         ),
//         ApiParams.videoUrl: await MultipartFile.fromFile(
//           parameter.videoUrl,
//           filename: 'video.mp4',
//         ),
//       });
//
//       // Set headers
//       final headers = {
//         ApiParams.key: Api.secretKey,
//         ApiParams.tokenKey: ApiParams.tokenStartPoint + parameter.token,
//         ApiParams.uidKey: parameter.uid,
//       };
//
//       // Show initial notification
//       await NotificationServices.showUploadProgressNotification(
//         notificationId: _uploadNotificationId,
//         title: 'Uploading Video',
//         body: 'Preparing upload...',
//         progress: 0,
//         isCompleted: false,
//       );
//       Utils.showLog("Upload Progress: 0%");
//
//       // Make the request
//       final response = await _dio.post(
//         Api.uploadVideo,
//         data: formData,
//         options: Options(headers: headers),
//         onSendProgress: (int sent, int total) async {
//           final progress = ((sent / total) * 100).toInt();
//
//           // Update notification
//           await NotificationServices.showUploadProgressNotification(
//             notificationId: _uploadNotificationId,
//             title: 'Uploading Video',
//             body: '$progress% uploaded',
//             progress: progress,
//             isCompleted: false,
//           );
//
//           Utils.showLog("Upload Progress: $progress% ($sent/$total bytes)");
//         },
//       );
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
//           body: 'Video uploaded successfully!',
//           progress: 100,
//           isCompleted: true,
//         );
//
//         Utils.showLog("Upload Progress: 100% - Upload completed successfully!");
//
//         return UploadVideoModel.fromJson(jsonResult);
//       } else {
//         // Handle failed response
//         await NotificationServices.showUploadProgressNotification(
//           notificationId: _uploadNotificationId,
//           title: 'Upload Failed',
//           body: 'Error uploading video',
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

class UploadVideoParameterModel {
  final SendPort? sendPort;
  final String uid;
  final String token;
  final String videoUrl;
  final String videoImage;
  final String videoTime;
  final String caption;
  final String hashTagId;
  final String mentionedUserIds;
  final String songId;
  final String successToast;
  final String failedToast;

  UploadVideoParameterModel(
    this.sendPort,
    this.uid,
    this.token,
    this.videoUrl,
    this.videoImage,
    this.videoTime,
    this.caption,
    this.hashTagId,
    this.mentionedUserIds,
    this.songId,
    this.successToast,
    this.failedToast,
  );

  Map<String, dynamic> toMap() {
    return {
      'sendPort': sendPort,
      'uid': uid,
      'token': token,
      'videoUrl': videoUrl,
      'videoImage': videoImage,
      'videoTime': videoTime,
      'caption': caption,
      'hashTagId': hashTagId,
      'mentionedUserIds': mentionedUserIds,
      'songId': songId,
      'successToast': successToast,
      'failedToast': failedToast,
    };
  }

  static UploadVideoParameterModel fromMap(Map<String, dynamic> map) {
    return UploadVideoParameterModel(
      map['sendPort'],
      map['uid'],
      map['token'],
      map['videoUrl'],
      map['videoImage'],
      map['videoTime'],
      map['caption'],
      map['hashTagId'],
      map['mentionedUserIds'],
      map['songId'],
      map['successToast'],
      map['failedToast'],
    );
  }
}

// TODO WITHOUT PROGRESS UPLOAD VIDEO API

// class UploadVideoApi {
//   static Future<UploadVideoModel?> callApi({required UploadVideoParameterModel parameter}) async {
//     Utils.showLog("Upload Video Api Calling...");
//
//     try {
//       final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + parameter.token, ApiParams.uidKey: parameter.uid};
//
//       var request = http.MultipartRequest('POST', Uri.parse(Api.uploadVideo));
//       request.fields.addAll({
//         ApiParams.videoTime: parameter.videoTime,
//         ApiParams.caption: parameter.caption,
//         ApiParams.hashTagId: parameter.hashTagId,
//         ApiParams.mentionedUserIds: parameter.mentionedUserIds,
//         ApiParams.songId: parameter.songId,
//       });
//       request.files.add(await http.MultipartFile.fromPath(ApiParams.videoImage, parameter.videoImage));
//
//       request.files.add(await http.MultipartFile.fromPath(ApiParams.videoUrl, parameter.videoUrl));
//
//       request.headers.addAll(headers);
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final jsonResult = jsonDecode(responseBody);
//         Utils.showLog("Upload Video Api Response => $jsonResult");
//         return UploadVideoModel.fromJson(jsonResult);
//       } else {
//         Utils.showLog("Upload Video Api Response Error");
//         return null;
//       }
//     } catch (e) {
//       Utils.showLog("Upload Video Api Error => $e");
//       return null;
//     }
//   }
// }
