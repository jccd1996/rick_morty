import 'package:flutter/material.dart';
import 'package:rick_morty/blocs/provider/bloc.dart';
import 'package:rick_morty/blocs/provider/provider.dart';
import 'package:rick_morty/di/injection.dart';

abstract class BaseState<T extends StatefulWidget, K extends Bloc>
    extends State<T> {
  K bloc;
  @override
  void initState() {
    super.initState();
    bloc = Provider.of<K>(() => getIt.get<K>());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.dispose<K>();
    super.dispose();
  }
}
