import 'package:flutter/material.dart';
import 'package:models/results.dart';
import 'package:rick_morty/blocs/characters_bloc.dart';
import 'package:rick_morty/data_source/data_base/config/app_database.dart';
import 'package:rick_morty/ui/base_state.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends BaseState<CharactersPage, CharactersBloc> {
  @override
  void initState() {
    super.initState();
    AppDatabase().init().then((value) {
      bloc.getCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Results>>(
          stream: bloc.character,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return SizedBox.shrink();
            }
            return ListView(
              children: [
                ...snapshot.data.map((e) => Text(e.name)).toList(),
                InkWell(
                  onTap: () {
                    bloc.getNewData();
                  },
                  child: Text(
                    'BOTON',
                  ),
                ),
                InkWell(
                  onTap: () {
                    bloc.getCharacters();
                  },
                  child: Text(
                    'traer',
                  ),
                ),
              ],
            );
          }),
    );
  }
}
