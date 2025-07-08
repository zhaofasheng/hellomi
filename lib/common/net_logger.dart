import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';


class NetLogger {
  static const String _tag = '网络日志';
  static const int _chunkSize = 800;

  /// 打印请求日志
  static void logRequest(RequestOptions options) {
    if (!kDebugMode) return;

    final lines = <String>[
      '▶️ 请求方法：${options.method}',
      '📍 请求地址：${options.uri}',
      '🧾 请求头：${jsonEncode(options.headers)}',
    ];

    if (options.queryParameters.isNotEmpty) {
      lines.add('❓ Query参数：${jsonEncode(options.queryParameters)}');
    }

    if (options.data != null) {
      lines.add('📝 请求体：');
      lines.addAll(_formatJsonLines(options.data));
    }

    _printBox('请求日志', lines);
  }

  /// 打印响应日志
  static void logResponse(Response response) {
    if (!kDebugMode) return;

    final lines = <String>[
      '🏁 请求地址：${response.requestOptions.uri}',
      '📄 响应状态码：${response.statusCode}',
      '📃 响应数据：',
      ..._formatJsonLines(response.data),
    ];

    _printBox('响应日志', lines);
  }

  /// 打印错误日志
  static void logError(DioException e) {
    if (!kDebugMode) return;

    final lines = <String>[
      '📍 请求地址：${e.requestOptions.uri}',
      '🚫 错误信息：${e.message}',
    ];

    if (e.response != null) {
      lines.add('📄 状态码：${e.response?.statusCode}');
      lines.add('📃 错误数据：');
      lines.addAll(_formatJsonLines(e.response?.data));
    }

    _printBox('错误日志', lines);
  }

  /// 打印自定义日志（支持分段和 JSON 美化）
  static void logCustom(String title, dynamic content) {
    if (!kDebugMode) return;

    final lines = <String>[
      if (content is String) ..._chunkString(content, _chunkSize),
      if (content is Map || content is List || content is Object) ..._formatJsonLines(content),
    ];

    _printBox(title, lines);
  }

  /// 美化打印一个区块（加虚线框）
  static void _printBox(String title, List<String> contentLines) {
    const border = '──────────────────────────────────────────────';
    _log('╭─ $title $border');
    for (final line in contentLines) {
      _log('│ $line');
    }
    _log('╰$border\n');
  }

  /// 打印日志（带 TAG）
  static void _log(String msg) {
    if (kDebugMode) print('$_tag $msg');
  }

  /// 将 JSON 格式化并按段分割为字符串列表
  static List<String> _formatJsonLines(dynamic data) {
    final lines = <String>[];
    try {
      String jsonStr;
      if (data is String) {
        jsonStr = const JsonEncoder.withIndent('  ').convert(json.decode(data));
      } else {
        jsonStr = const JsonEncoder.withIndent('  ').convert(data);
      }

      final chunks = _chunkString(jsonStr, _chunkSize);
      lines.addAll(chunks);
    } catch (e) {
      lines.add('⚠️ JSON 解析失败，原始数据：$data');
    }
    return lines;
  }

  /// 将字符串按指定长度分段
  static List<String> _chunkString(String str, int chunkSize) {
    final chunks = <String>[];
    for (var i = 0; i < str.length; i += chunkSize) {
      final end = (i + chunkSize < str.length) ? i + chunkSize : str.length;
      chunks.add(str.substring(i, end));
    }
    return chunks;
  }
}