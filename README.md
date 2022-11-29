<!-- 
Loki ile loglama. 
-->

## Kullanımı

Paketi projeye eklemek için 'pubspec.yaml' dosyasına girip altaki kod bluğu ekliyoruz
```dart
  app_logger:
    git:
      url: https://github.com/dophub/applogger.git
      ref: prod-0726
```

Paketi import etmek için
```dart
import 'package:app_logger/app_logger.dart';
```

Paketi init ediyoruz
```dart
void main() {
  AppLogger.init(
    'https://lokiBaseUrl',
    true,
    true,
        () => runApp(const MyApp()),
  );
}
```

Daha sonra paketin conguration nini değiştirmek için
```dart
AppLogger.instance.configuration.setUser(
  AppLoggerUser(id: '123123213123', username: 'Mustafa'),
);
```

Navigation Logger için
```dart
void navigationLog() {
  NavigationLogger.instance.log(
    const RouteSettings(
      name: 'AppLoggerDetailScreen',
      arguments: {'userName': 'Mto', 'userId': 1},
    ),
  );
}
```

Api Logger için
```dart
Future<void> getRequest() async {
  final uri = Uri.https('jsonplaceholder.typicode.com', 'todos/1');
  final res = await http.get(
    uri,
    headers: {"content-type": "application/json"},
  );
  HttpLogger.instance.log(
    url: uri.toString(),
    statusCode: res.statusCode,
    header: {},
    requestBody: {},
    responseBody: res.body,
  );
}
```


/// Configuration içinde olan parametreler
/// kullanıcı bilgileri
* user

/// Http log status
* httpLog

/// Navigation log status
* navigationLog

/// Hata oluştuğunda uygulama kapansın mı
* killAppOnError

/// Flutter tarafından hata oluştuğunda uygulama kapansın mı
* killAppOnErrorCausedByFlutter