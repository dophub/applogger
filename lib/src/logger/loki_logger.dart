import 'dart:async';
import 'package:dop_logger/dop_logger.dart';
import 'package:dop_logger/src/dop_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:dop_logger/src/model/loki_model.dart';
import 'package:dio/dio.dart';

/// Push Log to Loki
class LokiLogger {
  static LokiLogger? _instance;

  static LokiLogger get instance => _instance ??= LokiLogger();

  Future<void> log(LokiModel lokiModel) async {
    try {
      final url = DopLogger.instance.lokiUrl;
      final body = lokiModel.convertToJson();
      unawaited(
        Dio().post(
          url,
          data: body,
          options: Options(contentType: "application/json"),
        ),
      );
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}
