import 'dart:convert' show jsonEncode;
import 'package:dop_logger/src/app_info/app_info.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

import '../../dop_logger.dart';
import '../cons/enum.dart';
import '../model/log_model.dart';

/// Log Http by Loki
class HttpLogger {
  static HttpLogger? _instance;

  static HttpLogger get instance => _instance ??= HttpLogger();

  Future<void> log({
    required String url,
    required int statusCode,
    required Map<String, String>? header,
    required Map<String, dynamic> requestBody,
    required String responseBody,
  }) async {
    try {
      httpConsolePrint(url, statusCode, header, requestBody, responseBody);
      if (!DopLogger.instance.configuration.httpLog) return;
      final packageInfo = await AppInfo.instance.getPackageInfo();
      final deviceInfo = await AppInfo.instance.getDeviceInfo();
      DopLogger.instance.callBackFun(
        LogModel(
          streams: StreamElement(
            stream: {packageInfo["appName"] ?? "UndefinedApp": LogType.API.name},
            values: '{"user":${jsonEncode(DopLogger.instance.configuration.user.toJson())},'
                '"url":"$url","header":${jsonEncode(header)},'
                '"request_body":${jsonEncode(requestBody)},'
                '"response_status":"$statusCode",'
                '"response":$responseBody,'
                '"app_info":${jsonEncode(packageInfo)},'
                '"device_info":${jsonEncode(deviceInfo)}}',
          ),
        ),
      );
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }

  void httpConsolePrint(
    String url,
    int statusCode,
    Map<String, String>? header,
    Map<String, dynamic> requestBody,
    String responseBody,
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
