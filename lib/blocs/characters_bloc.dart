import 'dart:async';

import 'package:domain/character_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';
import 'package:models/results.dart';
import 'package:models/test_request.dart';
import 'package:rick_morty/blocs/provider/bloc.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CharactersBloc extends Bloc {
  final CharacterUseCase _characterUseCase;

  CharactersBloc(this._characterUseCase);

  StreamSubscription<CharacterResponse>? _characterStreamSubscription;
  final charactersSubject = BehaviorSubject<List<Results>>();
  final loadingSubject = BehaviorSubject<bool>();
  ValueStream<List<Results>> get characters => charactersSubject.stream;

  ValueStream<bool> get loading => loadingSubject.stream;

  Stream<CharacterResponse?> streamCharacter() {
    var stream = _characterUseCase.stream();
    _characterStreamSubscription = stream.listen((items) {
      charactersSubject.value = items?.results ?? [];
    }) as StreamSubscription<CharacterResponse>?;
    return stream;
  }

  Future<CharacterResponse> getCharacters() {
    loadingSubject.value = true;
    var testRequest = TestRequest(name: "Prueba endpoint");
    return _characterUseCase.get(testRequest).then((value) {
      print("NUNCA LLEGO");
      loadingSubject.value = false;
      return value;
    });
  }

  void cleanList() {
    charactersSubject.value = [];
  }

  @override
  void dispose() {
    charactersSubject.close();
    loadingSubject.close();
    _characterStreamSubscription?.cancel();
  }
}
