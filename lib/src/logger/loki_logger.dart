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
      final url = '${DopLogger.instance.lokiUrl}/loki/api/v1/push';
      final res = await Dio().post(
        url,
        data: lokiModel.convertToJson(),
        options: Options(contentType: "application/json"),
      );
      debugPrint(res.data);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}
