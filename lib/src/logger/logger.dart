import 'dart:async';
import 'package:app_logger/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

/// Push Log
class Logger {
  void log(LogModel model) {
    try {
      final url = AppLogger.instance.baseUrl;
      final headers = AppLogger.instance.headers;
      final body = model.convertToJson();
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
