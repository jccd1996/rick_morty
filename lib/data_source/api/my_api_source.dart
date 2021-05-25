import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rick_morty/app/application.dart';
import 'package:rick_morty/connectivity/connectivity.dart';
import 'package:rick_morty/connectivity/connectivity_adapter.dart';

import 'api_source.dart';

@singleton
@injectable
class MyApiSource with ApiSource {
  @override
  String get baseUrl => Application().appSettings.baseUrl;

  @override
  http.Client get client => http.Client();

  @override
  Connectivity get connectivity => ConnectivityAdapter();

  @override
  Map<String, String> getHeaders(Map<String, String> headers) {
    headers = headers ?? {};
    return headers;
  }
}
