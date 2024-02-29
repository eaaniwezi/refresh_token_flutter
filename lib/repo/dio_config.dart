// ignore_for_file: deprecated_member_use, prefer_const_constructors, avoid_print, unnecessary_null_comparison, depend_on_referenced_packages, prefer_typing_uninitialized_variables, avoid_renaming_method_parameters

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:refresh_token_flutter/models/token_model.dart';

class IApiClass extends IApi {
  @override
  Future<Response<T>> delete<T>(String path) {
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> get<T>(
      String baseUrl, Map<String, dynamic>? queryParameters) {
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> patch<T>(
      String path, Map? data, Map<String, dynamic>? queryParameters) {
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> post<T>(
      String path, Map? data, Map<String, dynamic>? queryParameters) {
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> put<T>(
      String path, Map? data, Map<String, dynamic>? queryParameters) {
    throw UnimplementedError();
  }
}

abstract class IApi {
  Future<Response<T>> get<T>(
      String baseUrl, Map<String, dynamic>? queryParameters);
  Future<Response<T>> post<T>(String path, Map<dynamic, dynamic>? data,
      Map<String, dynamic>? queryParameters);
  Future<Response<T>> put<T>(String path, Map<dynamic, dynamic>? data,
      Map<String, dynamic>? queryParameters);
  Future<Response<T>> patch<T>(String path, Map<dynamic, dynamic>? data,
      Map<String, dynamic>? queryParameters);
  Future<Response<T>> delete<T>(String path);
}

class Api extends IApi {
  final Dio api = Dio();
  final _storage = const FlutterSecureStorage();

  Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final accessToken = await _storage.read(key: "accessToken");
      if (!options.path.contains('https')) {
        options.path =
            'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net${options.path}';
      }
      accessToken == null
          ? options.headers = {
              "Accept": "application/json",
              "Content-Type": 'application/json'
            }
          : options.headers['Auth'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      try {
        if ((error.response?.statusCode == 401 ||
            error.response?.data['message'] == "Unauthorized")) {
          await refreshTokens();
          return handler.resolve(await _retry(error.requestOptions));
        }
      } catch (e) {
        _storage.deleteAll();
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    return api.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  @override
  Future<Response<T>> get<T>(
      String path, Map<String, dynamic>? queryParameters) {
    return api.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> post<T>(String path, Map<dynamic, dynamic>? data,
      Map<String, dynamic>? queryParameters) {
    return api.post(path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> put<T>(String path, Map<dynamic, dynamic>? data,
      Map<String, dynamic>? queryParameters) {
    return api.put(path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> patch<T>(String path, Map<dynamic, dynamic>? data,
      Map<String, dynamic>? queryParameters) {
    return api.patch(path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> delete<T>(String path) {
    return api.delete(path);
  }

  Future<TokenModel> refreshTokens() async {
    var tokenResponse;
    try {
      var refreshToken = await _storage.read(key: 'refreshToken');
      var tokenData = {'token': refreshToken};
      final response = await api.post('/refresh_token', data: tokenData);
      return TokenModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return tokenResponse;
    }
  }
}
