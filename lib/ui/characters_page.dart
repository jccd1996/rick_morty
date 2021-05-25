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
  String camilo;
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
      appBar: AppBar(
        title: Text('Rick and Morty'),
      ),
      body: StreamBuilder<bool>(
          stream: bloc.loading,
          initialData: false,
          builder: (context, snapshotLoading) {
            return StreamBuilder<List<Results>>(
                stream: bloc.characters,
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return SizedBox.shrink();
                  }
                  return ListView(
                    children: [
                      if (!snapshotLoading.data)
                        ...snapshot.data
                            .map((e) => _CharacterName(
                                  name: e.name,
                                ))
                            .toList(),
                      if (snapshotLoading.data)
                        const _CircularProgressIndicator(),
                      OutlinedButton(
                        onPressed: () {
                          bloc.getCharacters();
                        },
                        child: Text(
                          'Get characters',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          bloc.cleanList();
                        },
                        child: Text(
                          'Clean',
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}

class _CharacterName extends StatelessWidget {
  final String name;

  const _CharacterName({
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name ?? ''),
    );
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  const _CircularProgressIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
