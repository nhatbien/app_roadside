import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper/type_def.dart';
import 'response/err_response.dart';

Object? _toEncodable(Object? nonEncodable) =>
    nonEncodable is DateTime ? nonEncodable.toIso8601String() : nonEncodable;

abstract class AppHttpClient {
  Future<dynamic> getJson(Uri url, {Map<String, dynamic>? headers});

  Future<dynamic> postMultipart(
    String url,
    List<int> bytes, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    String? filename,
  });

  Future<dynamic> postJson(
    Uri url, {
    Map<String, String>? headers,
    Map<String, Object?>? body,
  });

  Future<dynamic> putJson(
    Uri url, {
    Map<String, String>? headers,
    Map<String, Object?>? body,
  });

  Future<dynamic> deleteJson(
    Uri url, {
    Map<String, String>? headers,
  });
}

class ClientDio implements AppHttpClient {
  final Dio _dio;

  ClientDio(this._dio);

  @override
  Future<Response> getJson(Uri url, {Map<String, dynamic>? headers}) async {
    final response = await _dio.fetch(RequestOptions(
      method: "GET",
      baseUrl: url.origin,
      path: url.path,
      queryParameters: url.queryParameters,
      headers: headers,
    ));
    return response;
  }

  @override
  Future<Response> postMultipart(
    String url,
    List<int> bytes, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    String? filename,
  }) async {
    final request = await _dio.post(
      url,
      data: FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes,
            filename: filename ?? 'file_${DateTime.now().toIso8601String()}'),
        ...?fields,
      }),
      options: Options(
        headers: {
          ...?headers,
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
        },
      ),
    );
    print("ok");
    return request;
  }

  @override
  Future<Response> postJson(
    Uri url, {
    Map<String, String>? headers,
    Map<String, Object?>? body,
  }) async {
    final response = await _dio.fetch(RequestOptions(
      method: 'POST',
      baseUrl: url.origin,
      path: url.path,
      queryParameters: url.queryParameters,
      data: body != null ? jsonEncode(body, toEncodable: _toEncodable) : null,
    ));
    return response;
  }

  @override
  Future<Response> putJson(
    Uri url, {
    Map<String, String>? headers,
    Map<String, Object?>? body,
  }) {
    final response = _dio.fetch(RequestOptions(
      method: 'PUT',
      baseUrl: url.origin,
      path: url.path,
      queryParameters: url.queryParameters,
      headers: {
        ...?headers,
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
      data: body != null ? jsonEncode(body, toEncodable: _toEncodable) : null,
    ));
    return response;
  }

  @override
  Future<Response> deleteJson(
    Uri url, {
    Map<String, String>? headers,
  }) {
    final response = _dio.fetch(RequestOptions(
      method: 'DELETE',
      baseUrl: url.origin,
      path: url.path,
      queryParameters: url.queryParameters,
      headers: {
        ...?headers,
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      },
    ));
    return response;
  }
}

/* 
class AuthHttpClient extends AppHttpClient {
  final Dio _client;
  final Duration _timeout;

  final Function0<Future<void>> _onSignOut;
  final Function0<Future<String?>> _getToken;

  AuthHttpClient(
    this._client,
    this._timeout,
    this._onSignOut,
    this._getToken,
  );

  Future<Response> send(RequestOptions request) async {
    final token = await _getToken();

    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return _client.fetch(request).timeout(_timeout).then(_handleResponse);
  }

  Future<Response> _handleResponse(Response response) async {
    if (response.statusCode == HttpStatus.unauthorized ||
        response.statusCode == HttpStatus.forbidden) {
      await _onSignOut();
      _logger
          ?.logResponse('Response code is 401 or 403. Removed token. Logout');
    }

    return response;
  }
}
 */