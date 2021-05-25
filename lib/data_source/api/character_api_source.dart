import 'package:data/character_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';

import 'my_api_source.dart';

@Injectable(as: CharacterApiSource)
class CharacterApiSourceAdapter implements CharacterApiSource {
  final MyApiSource apiSource;

  CharacterApiSourceAdapter(this.apiSource);

  @override
  Future<CharacterResponse> getCharacters() async {
    var url = '${apiSource.baseUrl}/api/character/?';
    return apiSource.getApi(url, (value) => CharacterResponse.fromJson(value));
  }

  @override
  Future<CharacterResponse> get([Map params]) async {
    var url = '${apiSource.baseUrl}/api/character/?';
    return apiSource.getApi(url, (value) => CharacterResponse.fromJson(value));
  }
}
