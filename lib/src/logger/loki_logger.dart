import 'dart:async';
import 'package:dop_logger/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

/// Push Log to Loki
class LokiLogger {
  void log(LogModel lokiModel) {
    try {
      final url = DopLogger.instance.lokiUrl;
      final body = lokiModel.convertToJson();
      Dio()
          .post(
            url,
            data: body,
            options: Options(
              contentType: "application/json",
            ),
          )
          .ignore();
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}
