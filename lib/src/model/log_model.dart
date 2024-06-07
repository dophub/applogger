import 'package:background_json_parser/background_json_parser.dart';

import '../cons/enum.dart';

class LogModel<T extends IBaseModel> extends IBaseModel<LogModel> {
  LogModel({
    required this.type,
    this.values,
    this.mapValues,
  });

  LogType type;
  T? values;
  Map<String, dynamic>? mapValues;

  @override
  Map<String, dynamic> toJson() => {
        "type": type.name,
        "values": mapValues ?? values?.toJson(),
      };

  @override
  LogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
