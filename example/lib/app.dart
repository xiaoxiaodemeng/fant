import 'package:example/page/button.dart';
import 'package:flutter/material.dart';

import 'config/config.dart';

class ConfigApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppConfig config = AppConfig();

    return MaterialApp(
      title: config.name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Button(),
      ),
    );
  }
}
