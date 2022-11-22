import 'package:background_json_parser/background_json_parser.dart';

class LogModel extends IBaseModel {
  LogModel({
    required this.streams,
  });

  StreamElement streams;

  @override
  Map<String, dynamic> toJson() => {
        "streams": [streams.toJson()],
      };

  @override
  fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class StreamElement {
  StreamElement({
    this.stream,
    this.values,
  });

  Map<String, String>? stream;
  String? values;

  Map<String, dynamic> toJson() => {
        "stream": stream,
        "values": [
          [
            (DateTime.now().microsecondsSinceEpoch * 1000).toString(),
            values,
          ]
        ],
      };
}
