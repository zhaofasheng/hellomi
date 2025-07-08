
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../firebase/authentication/firebase_access_token.dart';
import '../firebase/authentication/firebase_uid.dart';
import '../utils/api.dart';
import '../utils/api_params.dart';
import '../utils/net_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  late final Dio _dio;

  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // 不在这里添加 headers，避免 token 固定不更新
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await FirebaseAccessToken.onGet() ?? "";
        final uid = FirebaseUid.onGet() ?? "";

        options.headers.addAll({
          ApiParams.uidKey: uid,
          ApiParams.key: Api.secretKey,
          ApiParams.tokenKey: "${ApiParams.tokenStartPoint}$token",
        });

        NetLogger.logRequest(options);
        handler.next(options);
      },
      onResponse: (response, handler) {
        NetLogger.logResponse(response);
        handler.next(response);
      },
      onError: (DioException e, handler) {
        NetLogger.logError(e);
        handler.next(e);
      },
    ));
  }

  /// GET 请求
  Future<Response?> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  /// POST 请求
  Future<Response?> post(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(url, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      _handleError(e);
      return null;
    }
  }

  void _handleError(dynamic error) {
    if (error is DioException) {
      NetLogger.logError(error);
    } else {
      if (kDebugMode) {
        print("❌ 其他异常: $error");
      }
    }
  }
}