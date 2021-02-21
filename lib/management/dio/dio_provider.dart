import 'package:flutter_riverpod/all.dart';
import 'package:dio/dio.dart';
import './../../management/dio/interceptors/errors_interceptors.dart';
import './interceptors/connectivity_retrier.dart';
import './interceptors/content_language_interceptors.dart';
import './interceptors/retry_connection_interceptors.dart';
import './interceptors/tokens_interceptors.dart';

final dioBlankProvider = Provider<Dio>((ref) => Dio());

final dioDefaultProvider = Provider<Dio>((ref) {
  final Dio dio = ref.watch(dioBlankProvider);
  dio.interceptors.add(ContentLanguageInterceptor(ref.read));
  dio.interceptors.add(ErrorsInterceptor(ref.read));
  return dio;
});

final dioFullProvider = Provider<Dio>((ref) {
  final Dio dio = ref.watch(dioBlankProvider);
  dio.interceptors.add(ContentLanguageInterceptor(ref.read));
  dio.interceptors.add(JWTInterceptor(ref.read));
  dio.interceptors.add(RefreshTokensInterceptor(ref.read));
  dio.interceptors.add(RetryOnConnectionChangeInterceptor(
    DioConnectivityRequestRetrier(ref.read),
  ));
  dio.interceptors.add(ErrorsInterceptor(ref.read));
  return dio;
});
