// ignore_for_file: deprecated_member_use, avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:refresh_token_flutter/repo/dio_config.dart';
import 'package:refresh_token_flutter/models/token_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepo {
  late IApi client;
  AuthRepo({required this.client});
  final storage = FlutterSecureStorage();

  Future<bool> login(String email) async {
    try {
      var emailData = {'email': email};
      final response = await client.post('/login', emailData, {});
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        await storage.write(key: 'savedEmail', value: email);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<TokenModel> submitCode({required int code}) async {
    var tokenResponse;
    try {
      var savedEmail = await storage.read(key: 'savedEmail');
      var submitCodeData = {'email': savedEmail, 'code': code};
      final response = await client.post('/confirm_code', submitCodeData, {});
      return TokenModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return tokenResponse;
    }
  }

  Future<String> getUserId() async {
    try {
      var response = await client.get('/auth', {});
      return response.data['user_id'].toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> persistToken(
      {required String accessToken, required String refreshToken}) async {
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'accessToken');
    storage.delete(key: 'refreshToken');
    storage.delete(key: 'savedEmail');
    storage.deleteAll();
  }

  Future<bool> hasToken() async {
    var accessToken = await storage.read(key: 'accessToken');
    var refreshToken = await storage.read(key: 'refreshToken');

    if (accessToken != null && refreshToken != null) {
      return true;
    } else {
      return false;
    }
  }
}
