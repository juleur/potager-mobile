import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/all.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:potager/models/failure_model.dart';
import './../../../enums/user_status_enum.dart';
import './../../../management/authentication/user_status_provider.dart';
import './../../../management/dialog/flushbar_state_notifier.dart';
import './../../../management/dio/dio_provider.dart';
import './../../../management/user_service_provider.dart';
import './../../../models/tokens_model.dart';
import './../../../models/user_storage.dart';
import './../exception/message_exception.dart';

const String path = 'http://localhost:9377/a/refresh_jwt';

class JWTInterceptor extends Interceptor {
  JWTInterceptor(this._read);

  final Reader _read;
  CancelToken cancelToken = CancelToken();

  @override
  Future<RequestOptions> onRequest(RequestOptions options) async {
    final UserStorage userStorage =
        await _read(userServiceProvider).currentUser;

    // refresh Token si expiré
    if (JwtDecoder.isExpired(userStorage.jwt)) {
      _read(dioBlankProvider).interceptors.responseLock.lock();
      _read(dioBlankProvider).interceptors.responseLock.lock();
      try {
        final Tokens tokens = await _getNewTokens(userStorage.refreshToken);
        await _read(userServiceProvider).updateTokens(tokens);
        userStorage.jwt = tokens.jwt;
      } on MessageException catch (e) {
        // _read(dioBlankProvider).close();
        _read(messageStateProvider).state = e.message;
        _read(userStatusStateProvider).state = UserStatus.notloggedIn;
      }
      _read(dioBlankProvider).interceptors.requestLock.unlock();
      _read(dioBlankProvider).interceptors.responseLock.unlock();
    }
    final Map<String, String> header = {};
    header['Authorization'] = 'Bearer ${userStorage.jwt}';
    options.headers.addAll(header);
    return options;
  }
}

class RefreshTokensInterceptor extends Interceptor {
  RefreshTokensInterceptor(this._read);
  final Reader _read;

  @override
  Future<dynamic> onError(DioError err) async {
    final Failure response = Failure(err.response.toString());
    if (err.response.statusCode == 401 && response.errorCode == 42) {
      final RequestOptions options = err.response.request;
      final UserStorage userStorage =
          await _read(userServiceProvider).currentUser;

      _read(dioBlankProvider).interceptors.requestLock.lock();
      _read(dioBlankProvider).interceptors.responseLock.lock();
      try {
        final Tokens tokens = await _getNewTokens(userStorage.refreshToken);
        await _read(userServiceProvider).updateTokens(tokens);
        userStorage.jwt = tokens.jwt;
      } on MessageException catch (e) {
        _read(messageStateProvider).state = e.message;
        _read(userStatusStateProvider).state = UserStatus.notloggedIn;
      }
      options.headers['Authorization'] = 'Bearer ${userStorage.jwt}';

      _read(dioBlankProvider).interceptors.requestLock.unlock();
      _read(dioBlankProvider).interceptors.responseLock.unlock();

      return _read(dioDefaultProvider)
          .request<dynamic>(options.path, options: options);
    }
    print(response.errorCode == 41);
    if (err.response.statusCode == 401 && response.errorCode == 41) {
      _read(messageStateProvider).state = response.message;
      await _read(userServiceProvider).delete;
      _read(userStatusStateProvider).state = UserStatus.notloggedIn;
      return err;
    }
    return err;
  }
}

Future<Tokens> _getNewTokens(String refreshToken) async {
  final Map<String, String> header = {};
  header['X-Refresh-Token'] = refreshToken;
  final dynamic response = await http.get(path, headers: header);
  if (response.statusCode == 200) {
    final Map<String, dynamic> rawJson = jsonDecode(response.body);
    final Tokens tokens = Tokens.fromJson(rawJson);
    return tokens;
  } else {
    throw MessageException(response.body);
  }
}
