import 'dart:async';
import 'package:dop_logger/dop_logger.dart';
import 'package:dop_logger/src/logger/exception_logger.dart';
import 'package:flutter/foundation.dart';
import 'configuration/configuration.dart';
import 'model/log_model.dart';

typedef AppRunner = FutureOr<void> Function();

typedef AppLoggerCallBack = void Function(LogModel logModel);

class DopLogger {
  static DopLogger? _instance;

  static DopLogger get instance => _instance ??= DopLogger._();

  /// Paket ayarlarını tutar
  Configuration configuration = Configuration();

  /// Laki BaseUrl
  late String lokiUrl;

  /// log yapıldığı zaman çağırılan fonksiyon eğer null ise loki ye log alır
  late final AppLoggerCallBack callBackFun;

  DopLogger._();

  static Future<void> init(
    String lokiUrl,
    bool httpLog,
    bool navigationLog,
    AppRunner appRunner, [
    AppLoggerCallBack? callBackFun,
  ]) async {
    DopLogger.instance.lokiUrl = lokiUrl;
    DopLogger.instance.configuration.httpLog = httpLog;
    DopLogger.instance.configuration.navigationLog = navigationLog;
    DopLogger.instance.callBackFun = callBackFun ?? LokiLogger().log;
    runZonedGuarded(
      () async {
        FlutterError.onError = ExceptionLogger.instance.onErrorCausedByFlutter;
        await appRunner();
      },
      ExceptionLogger.instance.onError,
    );
  }
}
