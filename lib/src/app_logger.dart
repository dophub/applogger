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

  /// Paket ayarlarını tutar
  Configuration configuration = Configuration();

  /// Laki BaseUrl
  late String lokiUrl;

  /// log yapıldığı zaman çağırılan fonksiyon eğer null ise loki ye log alır
  late final AppLoggerCallBack callBackFun;

  /// Hata oluştuğu zaman çalışır
  late final ErrorCallBack? onError;

  AppLogger._();

  static Future<void> init(
    String lokiUrl,
    bool httpLog,
    bool navigationLog,
    AppRunner appRunner, {
    ErrorCallBack? onError,
    AppLoggerCallBack? callBackFun,
  }) async {
    AppLogger.instance.lokiUrl = lokiUrl;
    AppLogger.instance.configuration.httpLog = httpLog;
    AppLogger.instance.configuration.navigationLog = navigationLog;
    AppLogger.instance.onError = onError;
    AppLogger.instance.callBackFun = callBackFun ?? LokiLogger().log;
    runZonedGuarded(
      () async {
        FlutterError.onError = ExceptionLogger.instance.onErrorCausedByFlutter;
        await appRunner();
      },
      ExceptionLogger.instance.onError,
    );
  }
}
