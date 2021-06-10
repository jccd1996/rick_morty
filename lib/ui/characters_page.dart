import 'package:flutter/material.dart';
import 'package:models/result.dart';
import 'package:models/result_character.dart';
import 'package:rick_morty/blocs/characters_bloc.dart';
import 'package:rick_morty/ui/base_state.dart';
import 'package:rick_morty/ui/test_page.dart';

import 'episodes_page.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends BaseState<CharactersPage, CharactersBloc> {
  var switchValue = true;
  @override
  void initState() {
    super.initState();
    bloc!.streamCharacter();
    bloc!.getCharacters().then((value) {
      if (value.status != Status.success) {
        _showDialog(value.error?.message ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty'),
        leading: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
          stream: bloc!.loading,
          initialData: false,
          builder: (context, snapshotLoading) {
            return StreamBuilder<List<ResultsCharacter>>(
                stream: bloc!.characters,
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return SizedBox.shrink();
                  }
                  return ListView(
                    children: [
                      if (!snapshotLoading.data!)
                        ...snapshot.data!
                            .map((e) => _CharacterName(
                                  name: e.name!,
                                ))
                            .toList(),
                      if (snapshotLoading.data!)
                        const _CircularProgressIndicator(),
                      OutlinedButton(
                        onPressed: () {
                          bloc!.getCharacters();
                        },
                        child: Text(
                          'Get characters',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          bloc!.cleanList();
                        },
                        child: Text(
                          'Clean',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EpisodesPage()));
                        },
                        child: Text(
                          'Episodes Page',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestPage()));
                        },
                        child: Text(
                          'Test page',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Switch.adaptive(
                            value: switchValue,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                });
          }),
    );
  }

  void _showDialog(String mensaje) {
    var dialog = AlertDialog(
      title: Text('Titulo'),
      content: Text(mensaje),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}

class _CharacterName extends StatelessWidget {
  final String? name;

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
    Key? key,
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
