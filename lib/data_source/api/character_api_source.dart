import 'package:data/character_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/base_request.dart';
import 'package:models/character_response.dart';
import 'package:models/episode_response.dart';
import 'package:models/result.dart';
import 'package:models/test_request.dart';

import 'my_api_source.dart';

@Injectable(as: CharacterApiSource)
class CharacterApiSourceAdapter implements CharacterApiSource {
  final MyApiSource apiSource;

  CharacterApiSourceAdapter(this.apiSource);

  @override
  Future<Result<CharacterResponse>> get([BaseRequest? params]) async {
    var request = params as TestRequest;
    print("PRUEBA PARAMETROS: ${request.name}");
    var url = '${apiSource.baseUrl}/api/character/?';
    return apiSource.getApi(url, (value) => CharacterResponse.fromJson(value));
  }

  @override
  Future<Result<EpisodesResponse>> getEpisodes() {
    var url = '${apiSource.baseUrl}/api/episode';
    return apiSource.getApi(url, (value) => EpisodesResponse.fromJson(value));
  }
}
