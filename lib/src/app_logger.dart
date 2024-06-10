import 'dart:async';
import 'package:app_logger/app_logger.dart';
import 'package:app_logger/src/logger/exception_logger.dart';
import 'package:flutter/foundation.dart';
import 'configuration/configuration.dart';

typedef AppRunner = FutureOr<void> Function();

typedef AppLoggerCallBack = void Function(LogModel logModel);

typedef ErrorCallBack = void Function(Object error, StackTrace stack);

class AppLogger {
  static AppLogger? _instance;

  static AppLogger get instance => _instance ??= AppLogger._();

  /// Holds package settings
  Configuration configuration = Configuration();

  /// BaseUrl
  late String baseUrl;

  /// Header
  Map<String, dynamic>? headers;

  /// If is not null, the function is called when a log is taken. If it is null, a post request is sent to the endpoint given in baseUrl.
  late final AppLoggerCallBack callBackFun;

  /// Runs when an error occurs
  late final ErrorCallBack? onError;

  AppLogger._();

  static Future<void> init(
    String baseUrl,
    bool httpLog,
    bool navigationLog,
    AppRunner appRunner, {
    Map<String, dynamic>? headers,
    ErrorCallBack? onError,
    AppLoggerCallBack? callBackFun,
  }) async {
    AppLogger.instance.baseUrl = baseUrl;
    AppLogger.instance.headers = headers;
    AppLogger.instance.configuration.httpLog = httpLog;
    AppLogger.instance.configuration.navigationLog = navigationLog;
    AppLogger.instance.onError = onError;
    AppLogger.instance.callBackFun = callBackFun ?? Logger().log;
    runZonedGuarded(
      () async {
        FlutterError.onError = ExceptionLogger.instance.onErrorCausedByFlutter;
        await appRunner();
      },
      ExceptionLogger.instance.onError,
    );
  }
}
