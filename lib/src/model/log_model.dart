import 'package:background_json_parser/background_json_parser.dart';

import '../cons/enum.dart';

class LogModel<T extends IBaseModel> extends IBaseModel<LogModel> {
  LogModel({
    required this.type,
    required this.values,
  });

  LogType? type;
  T? values;

  @override
  Map<String, dynamic> toJson() => {
        "type": type!.name,
        "values": values!.convertToJson(),
      };

  @override
  LogModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
