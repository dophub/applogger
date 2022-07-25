import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../app_info/app_info.dart';
import '../cons/enum.dart';
import '../dop_logger.dart';
import '../model/loki_model.dart';
import 'loki_logger.dart';

/// Get Exception and log it to loki
class ExceptionLogger {
  static ExceptionLogger? _instance;

  static ExceptionLogger get instance => _instance ??= ExceptionLogger();

  Future<void> onError(error, stack) async {
    try {
      final packageInfo = await AppInfo.instance.getPackageInfo();
      final deviceInfo = await AppInfo.instance.getDeviceInfo();
      final lokiModel = LokiModel(
        streams: StreamElement(
          stream: {packageInfo["appName"] ?? "UndefinedApp": LogType.ERR.name},
          values:
              '{"user":${jsonEncode(DopLogger.instance.configuration.user.toJson())},"error":"$error","stack":"$stack","app_info":${jsonEncode(packageInfo)},"device_info":${jsonEncode(deviceInfo)}}',
        ),
      );
      LokiLogger.instance.log(lokiModel);
      if (DopLogger.instance.configuration.killAppOnError) exit(1);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }

  Future<void> onErrorCausedByFlutter(FlutterErrorDetails details) async {
    try {
      final packageInfo = await AppInfo.instance.getPackageInfo();
      final deviceInfo = await AppInfo.instance.getDeviceInfo();
      final lokiModel = LokiModel(
        streams: StreamElement(
          stream: {packageInfo["appName"] ?? "UndefinedApp": LogType.APPERR.name},
          values:
              '{"user":${jsonEncode(DopLogger.instance.configuration.user.toJson())},"error":"Error caused by flutter","stack":"${details.exception}" ,"app_info":${jsonEncode(packageInfo)},"device_info":${jsonEncode(deviceInfo)}}',
        ),
      );
      LokiLogger.instance.log(lokiModel);
      if (DopLogger.instance.configuration.killAppOnErrorCausedByFlutter) exit(1);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}