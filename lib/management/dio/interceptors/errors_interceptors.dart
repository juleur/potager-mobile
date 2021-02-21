import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/dialog/flushbar_state_notifier.dart';
import './../../../management/translation/translation_provider.dart';
import './../../../models/failure_model.dart';

class ErrorsInterceptor extends Interceptor {
  ErrorsInterceptor(this._read);
  final Reader _read;

  @override
  Future<dynamic> onError(DioError err) async {
    // revoir plus tard lorsqu'il faudra gérer plusieurs type d'erreurs
    // error serveur injoignable
    if (err.type == DioErrorType.DEFAULT && err.error != null) {
      final translate = _read(translationStateNotifierProvider.state);
      _read(messageStateProvider).state = translate['server.unreachable'];
      return err;
    }

    final Failure response = Failure(err.response.toString());
    _read(messageStateProvider).state = response.message;
    return err;
  }
}
