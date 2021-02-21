import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import './../enums/user_status_enum.dart';
import './../management/authentication/user_status_provider.dart';
import './../management/dio/dio_provider.dart';
import './../management/user_service_provider.dart';
import './../models/tokens_model.dart';

const String domain = 'http://localhost:9377';

const String loginPath = '$domain/a/login';
const String registerPath = '$domain/a/new_user';

const String refreshTokensPath = '$domain/a/refresh_jwt';

const String resetPWdPath = '$domain/a/reset_pwd/send/:email';
const String resetPwdConfirmPath = '$domain/a/reset_pwd/confirm';

const String verifyAccountPath = '$domain/a/verify_account/send';
const String verifyAccountConfirmPath = '$domain/a/verify_account/confirm/';

class LoginRepository {
  LoginRepository(this._read);
  final Reader _read;

  Future<bool> login(String identifiant, String password) async {
    final String body =
        jsonEncode({'identifiant': identifiant, 'password': password});

    final response =
        await _read(dioDefaultProvider).post<dynamic>(loginPath, data: body);

    if (response.statusCode == 200) {
      final Tokens tokens = Tokens.fromJson(response.data);
      await _read(userServiceProvider).updateTokens(tokens);
      _read(userStatusStateProvider).state = UserStatus.loggedIn;
      return true;
    }
    return false;
  }

  Future<bool> forgottenPassword(String email) async {
    final String body = jsonEncode({'email': email});
    final response =
        await _read(dioDefaultProvider).post<dynamic>(resetPWdPath, data: body);
    if (response.statusCode == 200) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> forgottenPasswordConfirm(String email, int code) async {
    final String body = jsonEncode({'email': email, 'code': code});
    final response = await _read(dioDefaultProvider)
        .post<dynamic>(resetPwdConfirmPath, data: body);
    if (response.statusCode == 200) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> verifyAccount() async {
    final response =
        await _read(dioFullProvider).get<dynamic>(verifyAccountPath);
    if (response.statusCode == 200) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  // la vérification se fait par mail

  Future<bool> newUser(String username, String email, String password) async {
    final String body = jsonEncode(
        {'username': username, 'email': email, 'password': password});

    try {
      final dynamic response = await _read(dioDefaultProvider)
          .post<dynamic>(registerPath, data: body);
      final Tokens tokens = response.data as Tokens;
      await _read(userServiceProvider).updateTokens(tokens);
      _read(userStatusStateProvider).state = UserStatus.loggedIn;
      return true;
    } on DioError {
      return false;
    }
  }
}
