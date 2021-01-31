import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/dialog/flushbar_state_notifier.dart';
import './../../../models/failure_model.dart';

class ErrorsInterceptor extends Interceptor {
  ErrorsInterceptor(this._read);
  final Reader _read;

  @override
  Future<dynamic> onError(DioError err) async {
    final Failure response = Failure(err.response.toString());
    _read(messageStateProvider).state = response.message;
    return err;
  }
}
