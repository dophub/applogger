import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show RouteSettings;
import '../app_info/app_info.dart';
import '../cons/enum.dart';
import '../dop_logger.dart';
import '../model/loki_model.dart';
import 'loki_logger.dart';

/// Log User Navigation by Loki
class NavigationLogger {
  static NavigationLogger? _instance;

  static NavigationLogger get instance => _instance ??= NavigationLogger();

  Future<void> log(RouteSettings settings) async {
    try {
      if (!DopLogger.instance.configuration.navigationLog) return;
      final packageInfo = await AppInfo.instance.getPackageInfo();
      final deviceInfo = await AppInfo.instance.getDeviceInfo();
      final lokiModel = LokiModel(
        streams: StreamElement(
          stream: {(packageInfo["appName"] as String) ?? "UndefinedApp": LogType.NAV.name},
          values: '{"user":${jsonEncode(DopLogger.instance.configuration.user.toJson())},'
              '"route":"${settings.name}","arguments":"${settings.arguments.toString()}",'
              '"app_info":${jsonEncode(packageInfo)},'
              '"device_info":${jsonEncode(deviceInfo)}}',
        ),
      );
      LokiLogger.instance.log(lokiModel);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}
