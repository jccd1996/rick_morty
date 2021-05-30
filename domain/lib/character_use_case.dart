import 'package:domain/base/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';

import 'base/get_use_case.dart';
import 'base/stream_use_case.dart';

mixin CharacterRepository
    on RepositoryStream<CharacterResponse>, RepositoryGet<CharacterResponse> {}

mixin CharacterUseCase
    on StreamUseCase<CharacterResponse>, GetUseCase<CharacterResponse> {}

@Injectable(as: CharacterUseCase)
class CharacterUseCaseAdapter
    with
        StreamUseCaseAdapter<CharacterResponse>,
        GetUseCaseAdapter<CharacterResponse>
    implements CharacterUseCase {
  final CharacterRepository repository;

  CharacterUseCaseAdapter(this.repository);
}
