import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:models/result.dart';
import 'package:rick_morty/connectivity/connectivity.dart';

mixin ApiSource {
  String? get baseUrl;

  http.Client get client;

  Connectivity get connectivity;

  Map<String, String> getHeaders(Map<String, String> headers);

  Duration get timeout => Duration(seconds: 30);

  Future<Result<T>> _callApi<T>(
    Future<http.Response> caller,
    T Function(dynamic value) mapperFunction,
  ) async {
    try {
      if (!await connectivity.isConnected()) {
        return Result<T>.error(message: 'No internet');
      }
      var response = await caller;
      return await _manageResponse(response, mapperFunction);
    } catch (error) {
      log(error.toString(), name: 'error');
      return Result<T>.error(message: error.toString());
    }
  }

  Future<Result<T>> getApi<T>(
    String url,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
    bool sendHeaders = true,
  }) async {
    headers = getHeaders(headers ?? {});
    var caller = client
        .get(
          Uri.parse(url),
          headers: sendHeaders ? headers : null,
        )
        .timeout(timeout);
    return _callApi(caller, mapperFunction);
  }

  Future<Result<T>> deleteApi<T>(
    String url,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
  }) async {
    headers = getHeaders(headers ?? {});
    var caller =
        client.delete(Uri.parse(url), headers: headers).timeout(timeout);
    return _callApi(caller, mapperFunction);
  }

  Future<Result<T>> postApi<T>(
    String url,
    dynamic body,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
  }) async {
    headers = getHeaders(headers ?? {});
    var newBody = getRequestBody(body);
    log(newBody, name: 'requestBody');
    var caller = client
        .post(
          Uri.parse(url),
          body: newBody,
          headers: headers,
        )
        .timeout(timeout);
    return _callApi(caller, mapperFunction);
  }

  Future<Result<T>> putApi<T>(
    String url,
    dynamic body,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
  }) async {
    headers = getHeaders(headers ?? {});
    var bodyString = getRequestBody(body);
    log(bodyString, name: 'requestBody');
    var caller = client
        .put(Uri.parse(url), body: bodyString, headers: headers)
        .timeout(timeout);
    return _callApi(caller, mapperFunction);
  }

  Future<Result<T>> patchApi<T>(
    String url,
    Map<String, dynamic> body,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
  }) async {
    headers = getHeaders(headers ?? {});
    log(json.encode(body), name: 'requestBody');
    var caller = client
        .patch(Uri.parse(url), body: json.encode(body), headers: headers)
        .timeout(timeout);

    return _callApi(caller, mapperFunction);
  }

  Future<T> multipartApi<T>(String url, Map<String, String> fields,
      String filePath, T Function(dynamic value) mapperFunction,
      {Map<String, String>? headers}) async {
    try {
      if (!await connectivity.isConnected()) {
        //  throw AppException(description: L10nConstants.defaultError);
        throw Exception();
      }
      headers = getHeaders(headers ?? {});
      var multipart = http.MultipartRequest('POST', Uri.parse(url));
      multipart.headers.addAll(headers);
      multipart.fields.addAll(fields);
      multipart.files.add(await http.MultipartFile.fromPath('file', filePath));
      var response = await multipart.send();
      return await _manageStreamedResponse(response, mapperFunction);
    } on Exception catch (e) {
      log(e.toString(), name: 'error');
      rethrow;
    }
    /*on ApiException catch (e) {
      log(e.toString(), name: 'error');
      rethrow;
    } catch (ex) {
      log(ex.toString(), name: 'responseError', error: ex);
      throw AppException(description: L10nConstants.defaultError);
    }*/
  }

  dynamic getRequestBody(dynamic body) {
    if (body is String || body is Map) {
      return body;
    }
    return json.encode(body);
  }

  Future<Result<T>> _manageResponse<T>(
    http.Response response,
    T Function(dynamic value) mapperFunction,
  ) async {
    _showLogs(response);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Result<T>.success(mapperFunction(_getBody(response.bodyBytes)));
    } else {
      return _manageError<T>(response);
    }
  }

  Future<T> _manageStreamedResponse<T>(
    http.StreamedResponse response,
    T Function(dynamic value) mapperFunction,
  ) async {
    _showLogs(response);
    var body = await response.stream.transform(utf8.decoder).first;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return mapperFunction(_getBody(body));
    } else {
      // throw AppException(description: L10nConstants.defaultError);
      throw Exception();
    }
  }

  Result<T> _manageError<T>(http.Response response) {
    if (response.statusCode >= 500) {
      //throw AppException(description: L10nConstants.defaultError);
      return Result<T>.error(message: 'Error por defecto');
    } else {
      return _errorFromResponse(response);
    }
  }

  Result<T> _errorFromResponse<T>(http.Response response) {
    var body = _getBody(response.body);
    return Result<T>.error(message: 'Errores por codigo');
  }

  dynamic _getBody(dynamic body) {
    String bodyString;
    if (body is String) {
      bodyString = body;
    } else {
      bodyString = utf8.decode(body);
    }
    try {
      return json.decode(bodyString);
    } catch (_) {
      return bodyString;
    }
  }

  void _showLogs(http.BaseResponse response) {
    JsonDecoder decoder = JsonDecoder();
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    log(response.request!.url.toString(), name: 'url');
    log(response.request!.method, name: 'method');
    log(response.statusCode.toString(), name: 'statusCode');
    if (response is http.Response) {
      var object = decoder.convert(response.body);
      var prettyString = encoder.convert(object);
      log('''-----RESPONSE----
      $prettyString
      -----END RESPONSE----
      ''', name: 'responseBody');
    }
  }
}
