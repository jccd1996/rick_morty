import 'package:flutter/material.dart';
import 'package:models/results_episodes.dart';
import 'package:rick_morty/blocs/episodes_bloc.dart';

import 'base_state.dart';

class EpisodesPage extends StatefulWidget {
  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends BaseState<EpisodesPage, EpisodesBloc> {
  @override
  void initState() {
    super.initState();
    bloc!.getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodes page'),
      ),
      body: StreamBuilder<bool>(
          stream: bloc!.loading,
          initialData: false,
          builder: (context, snapshotLoading) {
            if (snapshotLoading.data!) {
              return Center(
                child: Text('Cargando......'),
              );
            }

            return StreamBuilder<List<ResultsEpisodes>>(
                stream: bloc!.episodes,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: Text('Error'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _EpisodesItem(
                            name: snapshot.data![index].name ?? '');
                      });
                });
          }),
    );
  }
}

class _EpisodesItem extends StatelessWidget {
  final String? name;

  _EpisodesItem({this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name!),
    );
  }
}
