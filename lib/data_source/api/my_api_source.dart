import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rick_morty/connectivity/connectivity.dart';

import 'api_source.dart';

@singleton
class MyApiSource with ApiSource {
  final String _baseUrl;
  final http.Client _client;
  final Connectivity _connectivity;

  MyApiSource(
    this._baseUrl,
    this._client,
    this._connectivity,
  );

  @override
  String get baseUrl => _baseUrl;

  @override
  http.Client get client => _client;

  @override
  Connectivity get connectivity => _connectivity;

  @override
  Map<String, String> getHeaders(Map<String, String> headers) {
    headers = headers ?? {};
    return headers;
  }
}
