import 'package:flutter/material.dart';
import 'package:rick_morty/runner.dart';
import 'package:rick_morty/ui/splash_page.dart';

import 'app/app_settings.dart';
import 'app/application.dart';

void main() {
  var appSettings = AppSettings(
    baseUrl: "https://rickandmortyapi.com",
  );
  Application().appSettings = appSettings;
  runnerApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
