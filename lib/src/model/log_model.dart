import 'package:background_json_parser/background_json_parser.dart';

import '../../app_logger.dart';
import '../cons/enum.dart';

class LogModel<T extends IBaseModel> extends IBaseModel<LogModel> {
  LogModel({
    required this.id,
    this.data,
    this.mapData,
  });

  LogType id;
  T? data;
  Map<String, dynamic>? mapData;

  @override
  Map<String, dynamic> toJson() => {
        "type": AppLogger.instance.appId,
        "id": id.name,
        "data": [mapData ?? data?.toJson()],
      };

  @override
  LogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
