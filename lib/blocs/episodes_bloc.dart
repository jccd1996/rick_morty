import 'dart:async';

import 'package:domain/character_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/episode_response.dart';
import 'package:models/result.dart';
import 'package:models/results_episodes.dart';
import 'package:rick_morty/blocs/provider/bloc.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class EpisodesBloc extends Bloc {
  final CharacterUseCase _characterUseCase;

  EpisodesBloc(this._characterUseCase);

  final episodesSubject = BehaviorSubject<List<ResultsEpisodes>>();
  final loadingSubject = BehaviorSubject<bool>();

  ValueStream<List<ResultsEpisodes>> get episodes => episodesSubject.stream;

  ValueStream<bool> get loading => loadingSubject.stream;

  Future<Result<EpisodesResponse>> getEpisodes() {
    loadingSubject.value = true;
    return _characterUseCase.getEpisodes().then((value) {
      loadingSubject.value = false;
      if (value.status == Status.success) {
        episodesSubject.value = value.data?.results ?? [];
      }
      return value;
    });
  }

  @override
  void dispose() {
    episodesSubject.close();
    loadingSubject.close();
  }
}
