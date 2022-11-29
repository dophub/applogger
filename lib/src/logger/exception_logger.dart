import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dop_logger/src/model/exception_log_model.dart';
import 'package:flutter/material.dart';
import '../app_info/app_info.dart';
import '../cons/enum.dart';
import '../dop_logger.dart';
import '../model/log_model.dart';

/// Get Exception and log it to loki
class ExceptionLogger {
  static ExceptionLogger? _instance;

  static ExceptionLogger get instance => _instance ??= ExceptionLogger();

  Future<void> onError(error, stack) async {
    try {
      log(
        "onErrorCausedByFlutter",
        error: "error: $error \nstack: $stack",
        name: 'DopLoggerError: ',
      );
      final lokiModel = LogModel(
        type: LogType.ERR,
        values: ExceptionLogModel(
          error: error.toString(),
          stack: jsonEncode(stack.toString()),
          appInfo: await AppInfo.instance(),
        ),
      );
      DopLogger.instance.callBackFun(lokiModel);
      if (DopLogger.instance.configuration.killAppOnError) exit(1);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }

  Future<void> onErrorCausedByFlutter(FlutterErrorDetails details) async {
    try {
      log(
        "onErrorCausedByFlutter",
        error: 'exception: ${details.exception} \nstack: ${details.stack}',
        name: 'DopLoggerError: ',
      );
      final lokiModel = LogModel(
        type: LogType.APPERR,
        values: ExceptionLogModel(
          error: "Error caused by flutter stack: ${jsonEncode(details.exception.toString())}",
          stack: jsonEncode(details.exception.toString()),
          appInfo: await AppInfo.instance(),
        ),
      );
      DopLogger.instance.callBackFun(lokiModel);
      if (DopLogger.instance.configuration.killAppOnErrorCausedByFlutter) exit(1);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}
