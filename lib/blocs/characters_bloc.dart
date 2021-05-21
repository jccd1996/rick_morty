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

  final characterSubject = BehaviorSubject<List<Results>>();
  ValueStream<List<Results>> get character => characterSubject.stream;

  Future<CharacterResponse> getCharacters() {
    return _characterUseCase.get().then((value) {
      characterSubject.value = value.results;
      return value;
    });
  }

  void getNewData() {
    _characterUseCase.getCharacters().then((value) {
      characterSubject.value = [];
    });
  }

  @override
  void dispose() {
    characterSubject?.close();
  }
}
