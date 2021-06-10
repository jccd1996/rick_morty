import 'package:flutter/material.dart';
import 'package:rick_morty/blocs/location_bloc.dart';

import 'base_state.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends BaseState<LocationPage, LocationBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: Center(
        child: Text('Locations'),
      ),
    );
  }
}
