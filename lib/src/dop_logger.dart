import 'dart:async';
import 'package:dop_logger/src/logger/exception_logger.dart';
import 'package:flutter/foundation.dart';
import 'configuration/configuration.dart';

typedef AppRunner = FutureOr<void> Function();

class DopLogger {
  static DopLogger? _instance;

  static DopLogger get instance => _instance ??= DopLogger();

  /// Paket ayarlarını tutar
  Configuration configuration = Configuration();

  /// Laki BaseUrl
  late String lokiUrl;

  static Future<void> init(
    String lokiUrl,
    bool httpLog,
    bool navigationLog,
    AppRunner appRunner,
  ) async {
    DopLogger.instance.lokiUrl = lokiUrl;
    DopLogger.instance.configuration.httpLog = httpLog;
    DopLogger.instance.configuration.navigationLog = navigationLog;
    runZonedGuarded(
      () async {
        FlutterError.onError = ExceptionLogger.instance.onErrorCausedByFlutter;
        await appRunner();
      },
      ExceptionLogger.instance.onError,
    );
  }
}
