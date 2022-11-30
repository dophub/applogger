import 'dart:convert' show jsonEncode;
import 'package:app_logger/src/app_info/app_info.dart';
import 'package:app_logger/src/model/http_log_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

import '../../app_logger.dart';
import '../cons/enum.dart';

/// Log Http by Loki
class HttpLogger {
  static HttpLogger? _instance;

  static HttpLogger get instance => _instance ??= HttpLogger();

  Future<void> log({
    required String url,
    required int statusCode,
    required Map<String, String> header,
    required Map<String, dynamic> requestBody,
    required Map<String, dynamic> responseBody,
  }) async {
    try {
      httpConsolePrint(url, statusCode, header, requestBody, responseBody);
      if (!AppLogger.instance.configuration.httpLog) return;
      final logModel = LogModel(
        type: LogType.API,
        values: HttpLogModel(
          appInfo: await AppInfo.instance(),
          url: url,
          header: header,
          requestBody: requestBody,
          responseStatus: statusCode.toString(),
          response: responseBody,
        ),
      );
      AppLogger.instance.callBackFun(logModel);
    } catch (e) {
      debugPrint('App logger error: $e');
    }
  }

  void httpConsolePrint(
    String url,
    int statusCode,
    Map<String, String>? header,
    Map<String, dynamic> requestBody,
    Map<String, dynamic> responseBody,
  ) {
    dev.log(
        '┌─ Http Request ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
    dev.log(' Api Request Url: $url');
    dev.log(' Header: $header');
    dev.log(' Request: $requestBody');
    dev.log(
        ' ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
    dev.log(' Status Code: $statusCode');
    dev.log(' Response: $responseBody');
    dev.log(
        '└─ Http End ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
  }
}
