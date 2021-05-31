import 'package:flutter/material.dart';
import 'package:rick_morty/data_source/data_base/config/app_database.dart';
import 'package:rick_morty/ui/characters_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    AppDatabase().init();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CharactersPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Rick y morty App'),
      ),
    );
  }
}
