import 'package:domain/character_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/blocs/provider/bloc.dart';

@injectable
class LocationBloc extends Bloc {
  final CharacterUseCase _characterUseCase;
  LocationBloc(this._characterUseCase);

  @override
  void dispose() {}
}
