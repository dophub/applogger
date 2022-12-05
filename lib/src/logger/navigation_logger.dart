import 'package:app_logger/src/model/navigation_log_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show NavigatorObserver, Route;
import '../app_info/app_info.dart';
import '../cons/enum.dart';
import '../app_logger.dart';
import '../model/log_model.dart';

/// Log User Navigation by Loki
class NavigationLogger extends NavigatorObserver {
  final List<Route<dynamic>?> history = <Route<dynamic>?>[];

  static final NavigationLogger _instance = NavigationLogger();

  static NavigationLogger get instance => _instance;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _instance.history.removeLast();
    _log(NavigationEventEnum.didPop, route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _instance.history.add(route);
    _log(NavigationEventEnum.didPush, route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _instance.history.remove(route);
    _log(NavigationEventEnum.didRemove, route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    int oldRouteIndex = _instance.history.indexOf(oldRoute);
    _instance.history.replaceRange(oldRouteIndex, oldRouteIndex + 1, [newRoute]);
    _log(NavigationEventEnum.didReplace, newRoute, oldRoute);
  }

  Future<void> _log(
    NavigationEventEnum event,
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  ) async {
    try {
      if (!AppLogger.instance.configuration.navigationLog) return;
      String? routeName;
      String? arguments;
      String? previousRouteName;
      String? previousArguments;
      if (route != null) {
        routeName = route.settings.name;
        arguments = route.settings.arguments.toString();
      }
      if (previousRoute != null) {
        previousRouteName = previousRoute.settings.name;
        previousArguments = previousRoute.settings.arguments.toString();
      }
      final logModel = LogModel(
        type: LogType.NAV,
        values: NavigationLogModel(
          navEvent: event,
          appInfo: await AppInfo.instance(),
          route: routeName.toString(),
          arguments: arguments.toString(),
          previousRoute: previousRouteName.toString(),
          previousArguments: previousArguments.toString(),
        ),
      );
      AppLogger.instance.callBackFun(logModel);
    } catch (e) {
      debugPrint('App logger error: $e');
    }
  }
}
