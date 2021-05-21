import 'package:flutter/material.dart';
import 'package:rick_morty/runner.dart';
import 'package:rick_morty/ui/characters_page.dart';

void main() {
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
      home: CharactersPage(),
    );
  }
}
