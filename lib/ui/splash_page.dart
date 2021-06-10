import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty/data_source/data_base/config/app_database.dart';

import 'characters_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    AppDatabase().init();
    _animationController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CharactersPage()));
          });
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/plant_animation.json',
              controller: _animationController,
              onLoaded: (composition) {
                _animationController
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cargando...',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/animations/logo.json');
    return await LottieComposition.fromByteData(assetData);
  }
}
