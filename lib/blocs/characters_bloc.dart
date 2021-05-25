import 'package:domain/character_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';
import 'package:models/results.dart';
import 'package:rick_morty/blocs/provider/bloc.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CharactersBloc extends Bloc {
  final CharacterUseCase _characterUseCase;

  CharactersBloc(this._characterUseCase);

  final charactersSubject = BehaviorSubject<List<Results>>();
  final loadingSubject = BehaviorSubject<bool>();
  ValueStream<List<Results>> get characters => charactersSubject.stream;

  ValueStream<bool> get loading => loadingSubject.stream;

  Future<CharacterResponse> getCharacters() {
    loadingSubject.value = true;
    return _characterUseCase.get().then((value) {
      charactersSubject.value = value.results;
      loadingSubject.value = false;
      return value;
    });
  }

  void cleanList() {
    charactersSubject.value = [];
  }

  @override
  void dispose() {
    charactersSubject?.close();
    loadingSubject?.close();
  }
}
