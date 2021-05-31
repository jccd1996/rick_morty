import 'package:domain/character_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';
import 'package:models/episode_response.dart';
import 'package:models/result.dart';

import 'base/base_source.dart';
import 'base/repository_get.dart';
import 'base/repository_stream.dart';

mixin CharacterApiSource on ApiSourceGet<CharacterResponse> {
  Future<Result<EpisodesResponse>> getEpisodes();
}
mixin CharacterDbSource
    on DbSourceSave<CharacterResponse>, DbSourceGet<CharacterResponse> {}

@Injectable(as: CharacterRepository)
class CharacterRepositoryAdapter
    with
        StorageRepositoryStreamAdapter<CharacterResponse>,
        StorageRepositoryGetAdapter<CharacterResponse>
    implements CharacterRepository {
  final CharacterApiSource apiSource;
  final CharacterDbSource dbSource;

  CharacterRepositoryAdapter(this.apiSource, this.dbSource);

  @override
  Future<Result<EpisodesResponse>> getEpisodes() {
    return apiSource.getEpisodes();
  }
}
