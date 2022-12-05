import 'dart:html';

import 'package:background_json_parser/background_json_parser.dart';

import '../../app_logger.dart';
import '../app_info/app_info.dart';
import '../cons/enum.dart';

class NavigationLogModel extends IBaseModel<NavigationLogModel> {
  NavigationLogModel({
    required this.navEvent,
    required this.route,
    required this.arguments,
    required this.appInfo,
    required this.previousRoute,
    required this.previousArguments,
  });

  final NavigationEventEnum navEvent;
  final String route;
  final String arguments;
  final String previousRoute;
  final String previousArguments;
  final AppInfo appInfo;

  @override
  Map<String, dynamic> toJson() => {
        "event": navEvent.name,
        "user": AppLogger.instance.configuration.user.toJson(),
        "route": route,
        "arguments": arguments,
        "previous_route": previousRoute,
        "previous_arguments": previousArguments,
        "device_info": appInfo.toMap(),
      };

  @override
  NavigationLogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
