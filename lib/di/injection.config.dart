// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data/character_repository.dart' as _i3;
import 'package:domain/character_use_case.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart' as _i2;
import 'package:rick_morty/app/application.dart';
import 'package:rick_morty/connectivity/connectivity_adapter.dart';
import 'package:rick_morty/data_source/api/my_api_source.dart';

import '../blocs/characters_bloc.dart' as _i6;
import '../data_source/api/character_api_source.dart' as _i4;
import '../data_source/data_base/character_db_source.dart' as _i5;
import '../data_source/data_base/config/app_database.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.CharacterApiSource>(
      () => _i4.CharacterApiSourceAdapter(MyApiSource(
            Application().appSettings.baseUrl,
            http.Client(),
            ConnectivityAdapter(),
          )));
  gh.factory<_i3.CharacterDbSource>(() => _i5.CharacterApiSourceAdapter());
  gh.factory<_i6.CharactersBloc>(
      () => _i6.CharactersBloc(get<_i7.CharacterUseCase>()));
  gh.singleton<_i8.AppDatabase>(_i8.AppDatabase());
  return get;
}
