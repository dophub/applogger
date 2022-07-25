import 'dart:convert' show jsonEncode;
import 'package:dop_logger/src/app_info/app_info.dart';
import 'package:flutter/foundation.dart';

import '../../dop_logger.dart';
import '../cons/enum.dart';
import '../model/loki_model.dart';

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
      LokiLogger.instance.log(
        LokiModel(
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
    debugPrint(
        '┌─ Http Request ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
    debugPrint(' Api Request Url: $url');
    debugPrint(' Header: $header');
    debugPrint(' Request: $requestBody');
    debugPrint(
        '──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
    debugPrint(' Status Code: $statusCode');
    debugPrint(' Response: $responseBody');
    debugPrint(
        '└─ Http End ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────');
  }
}
