import 'package:background_json_parser/background_json_parser.dart';

import '../../app_logger.dart';
import '../cons/enum.dart';

class LogModel<T extends IBaseModel> extends IBaseModel<LogModel> {
  LogModel({
    required this.id,
    this.logTag,
    this.data,
    this.mapData,
  });

  LogType id;
  String? logTag;
  T? data;
  Map<String, dynamic>? mapData;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic>? _data = mapData ?? data?.toJson() ?? {};
    _data!['logTag'] = logTag;
    return {
      "type": AppLogger.instance.appId,
      "id": id.name,
      "data": [_data],
    };
  }

  @override
  LogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
