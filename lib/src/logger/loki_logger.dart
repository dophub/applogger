import 'dart:async';
import 'package:dop_logger/dop_logger.dart';
import 'package:dop_logger/src/dop_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:dop_logger/src/model/log_model.dart';
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
