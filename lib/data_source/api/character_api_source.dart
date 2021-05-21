import 'dart:convert' as convert;
import 'dart:developer';

import 'package:data/character_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';

@Injectable(as: CharacterApiSource)
class CharacterApiSourceAdapter implements CharacterApiSource {
  @override
  Future<CharacterResponse> getCharacters() async {
    var url = 'https://rickandmortyapi.com/api/character/?';
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    log(response.statusCode.toString(), name: 'statusCode');
    log(response.body, name: 'responseBody');
    return CharacterResponse.fromJson(jsonResponse);
  }

  @override
  Future<CharacterResponse> get([Map params]) async {
    var url = 'https://rickandmortyapi.com/api/character/?';
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    log(response.statusCode.toString(), name: 'statusCode');
    log(response.body, name: 'responseBody');
    return CharacterResponse.fromJson(jsonResponse);
  }
}
