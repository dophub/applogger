import 'package:background_json_parser/background_json_parser.dart';

import '../../app_logger.dart';
import '../app_info/app_info.dart';

class ExceptionLogModel extends IBaseModel<ExceptionLogModel> {
  ExceptionLogModel({
    required this.stack,
    required this.error,
    required this.appInfo,
    required this.extra,
  });

  String stack;
  Object error;
  AppInfo appInfo;
  Map<String, dynamic> extra;

  @override
  Map<String, dynamic> toJson() {
    return {
      "user": AppLogger.instance.configuration.user.toJson(),
      "stack": stack,
      "error": error.toString(),
      "device_info": appInfo.toMap(),
      "extra": extra,
    };
  }

  @override
  ExceptionLogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
