import 'package:dop_logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  DopLogger.init(
    'https://loki.restoranisim.app',
    true,
    true,
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    DopLogger.instance.configuration.setUser(
      AppLoggerUser(id: '123123213123', username: 'Mustafa'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Logger'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: getRequest, child: const Text('Http Log')),
            ElevatedButton(onPressed: navigationLog, child: const Text('Navigation Log')),
          ],
        ),
      ),
    );
  }

  void navigationLog() {
    NavigationLogger.instance.log(
      const RouteSettings(
        name: 'AppLoggerDetailScreen',
        arguments: {'userName': 'Mto', 'userId': 1},
      ),
    );
  }

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
}
