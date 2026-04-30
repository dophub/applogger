[<img alt="alt_text" width="240px" src="https://cdn.buymeacoffee.com/buttons/default-orange.png" />](https://www.buymeacoffee.com/mustafahusF)

# app_logger

A package for log exception, http request and navigation

## Usage

add this line to pubspec.yaml

```yaml

dependencies:
  app_logger: ^0.0.7

```

import package

```dart

import 'package:app_logger/app_logger.dart';

```

We init the package
```dart
void main() {
  AppLogger.init(
    'https://example.com',
    true,
    true,
        () => runApp(const MyApp()),
  );
}
```

Then to change the configuration of the package
```dart
AppLogger.instance.configuration.setUser(
  AppLoggerUser(id: '123123213123', username: 'Mustafa'),
);
```

Navigation Logger
```dart
MaterialApp(
  navigatorObservers: [NavigationLogger.instance],
  onGenerateRoute: MyRouteFactory().main.onGenerateRoute,
);
```

Api Logger
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

## Parameters

| Parameter     | Descriptions                                                                                                                        |                                                            |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| baseUrl       | BaseUrl                                                                                                                             |                                                            |
| headers       | Header                                                                                                                              |                                                            |
| callBackFun   | If is not null, the function is called when a log is taken. If it is null, a post request is sent to the endpoint given in baseUrl. |                                                            |
| onError       | Runs when an error occurs                                                                                                           |                                                            |
| configuration |                                                                                                                                     |                                                            |
|               | httpLog                                                                                                                             | Http log status                                            |
|               | navigationLog                                                                                                                       | Navigation log status                                      |
|               | killAppOnError                                                                                                                      | Should the application close when an error occurs?         |
|               | killAppOnErrorCausedByFlutter                                                                                                       | Should Flutter close the application when an error occurs? |
|               | user                                                                                                                                | user                                                       |


