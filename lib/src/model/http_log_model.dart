import 'package:background_json_parser/background_json_parser.dart';

import '../../app_logger.dart';
import '../app_info/app_info.dart';

class HttpLogModel extends IBaseModel<HttpLogModel> {
  HttpLogModel({
    required this.url,
    required this.header,
    required this.requestBody,
    required this.responseStatus,
    required this.response,
    required this.appInfo,
  });

  String url;
  String header;
  String requestBody;
  String responseStatus;
  String response;
  AppInfo appInfo;

  @override
  Map<String, dynamic> toJson() => {
        "user": AppLogger.instance.configuration.user.toJson(),
        "url": url,
        "header": header,
        "request_body": requestBody,
        "response_status": responseStatus,
        "response": response,
        "device_info": appInfo.toMap(),
      };

  @override
  HttpLogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
