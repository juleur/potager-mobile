import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../enums/language_enum.dart';
import './../../../management/flutter_secure_storage_provider.dart';

class ContentLanguageInterceptor extends Interceptor {
  ContentLanguageInterceptor(this._read);
  final Reader _read;

  @override
  Future<RequestOptions> onRequest(RequestOptions options) async {
    final Map<String, String> header = {};
    header['Content-Language'] =
        await _read(flutterSecureStorageProvider).read(key: 'lang') ??
            Language.francais.languageCode;
    return options;
  }
}
