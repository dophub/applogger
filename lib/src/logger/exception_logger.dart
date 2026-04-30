import 'dart:developer';
import 'dart:io';
import 'package:app_logger/src/model/exception_log_model.dart';
import 'package:flutter/material.dart';
import '../app_info/app_info.dart';
import '../cons/enum.dart';
import '../app_logger.dart';
import '../model/log_model.dart';

/// Get Exception and log
class ExceptionLogger {
  static ExceptionLogger? _instance;

  static ExceptionLogger get instance => _instance ??= ExceptionLogger();

  Future<void> onError(Object error, StackTrace stack) async {
    try {
      AppLogger.instance.onError?.call(error, stack);

      final shortStack = _shortenStack(stack);

      log(
        "onError",
        error: "error: $error \nstack: $stack",
        name: 'AppLogger Error: ',
      );
      final model = LogModel(
        id: LogType.ERR,
        data: ExceptionLogModel(
          error: error.toString(),
          stack: shortStack,
          appInfo: await AppInfo.instance(),
          extra: {},
        ),
      );
      AppLogger.instance.callBackFun(model);
      if (AppLogger.instance.configuration.killAppOnError) exit(1);
    } catch (e) {
      debugPrint('App logger error: $e');
    }
  }

  Future<void> onErrorCausedByFlutter(FlutterErrorDetails details) async {
    try {
      FlutterError.presentError(details);

      final shortStack = _shortenStack(details.stack);

      final extra = <String, dynamic>{
        "exception": details.exception.toString(),
        "stack": shortStack,
        "library": details.library,
        "context": details.context?.toString(),
        "silent": details.silent,
      };

      if (details.informationCollector != null) {
        extra["information"] = details.informationCollector!().map((e) => e.toString()).toList();
      }

      final model = LogModel(
        id: LogType.APPERR,
        data: ExceptionLogModel(
          error: details.exception.toString(),
          stack: shortStack,
          appInfo: await AppInfo.instance(),
          extra: extra,
        ),
      );

      log(
        "Flutter Error",
        name: "AppLogger",
        error: extra,
      );

      AppLogger.instance.callBackFun(model);

      if (AppLogger.instance.configuration.killAppOnErrorCausedByFlutter) exit(1);
    } catch (e, s) {
      debugPrint('App logger error: $e\n$s');
    }
  }

  String _shortenStack(StackTrace? stack, {int maxLines = 5}) {
    if (stack == null) return "";

    final lines = stack.toString().split('\n');
    return lines.take(maxLines).join('\n');
  }
}
