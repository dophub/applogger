import 'dart:async';
import 'package:app_logger/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

/// Push Log to Loki
class LokiLogger {
  void log(LogModel lokiModel) {
    try {
      final url = AppLogger.instance.lokiUrl;
      final headers = AppLogger.instance.lokiHeaders;
      final body = lokiModel.convertToJson();
      Dio()
          .post(
            url,
            data: body,
            options: Options(
              contentType: "application/json",
              headers: headers,
            ),
          )
          .ignore();
    } catch (e) {
      debugPrint('App logger error: $e');
    }
  }
}
