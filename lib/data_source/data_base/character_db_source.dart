import 'package:data/character_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:models/character_response.dart';
import 'package:sembast/sembast.dart';

import 'base_db_source.dart';
import 'config/app_database.dart';

@Injectable(as: CharacterDbSource)
class CharacterApiSourceAdapter
    with
        DbSourceSaveAdapter<CharacterResponse>,
        DbSourceGetAdapter<CharacterResponse>
    implements CharacterDbSource {
  @override
  Database get db => AppDatabase().myDatabase;

  @override
  CharacterResponse mapper(Map<String, dynamic> record) {
    return CharacterResponse.fromJson(record);
  }
}
