import 'package:background_json_parser/background_json_parser.dart';

import '../../app_logger.dart';
import '../app_info/app_info.dart';

class NavigationLogModel extends IBaseModel<NavigationLogModel> {
  NavigationLogModel({
    required this.route,
    required this.arguments,
    required this.appInfo,
  });

  String route;
  String arguments;
  AppInfo appInfo;

  @override
  Map<String, dynamic> toJson() => {
        "user": DopLogger.instance.configuration.user.toJson(),
        "route": route,
        "arguments": arguments,
        "app_info": appInfo,
        "device_info": appInfo.toMap(),
      };

  @override
  NavigationLogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
