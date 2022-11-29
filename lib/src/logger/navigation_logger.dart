import 'package:dop_logger/src/model/navigation_log_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show RouteSettings;
import '../app_info/app_info.dart';
import '../cons/enum.dart';
import '../dop_logger.dart';
import '../model/log_model.dart';

/// Log User Navigation by Loki
class NavigationLogger {
  static NavigationLogger? _instance;

  static NavigationLogger get instance => _instance ??= NavigationLogger();

  Future<void> log(RouteSettings settings) async {
    try {
      if (!DopLogger.instance.configuration.navigationLog) return;
      final logModel = LogModel(
        type: LogType.NAV,
        values: NavigationLogModel(
          appInfo: await AppInfo.instance(),
          route: settings.name.toString(),
          arguments: settings.arguments.toString(),
        ),
      );
      DopLogger.instance.callBackFun(logModel);
    } catch (e) {
      debugPrint('loki logger error: $e');
    }
  }
}
