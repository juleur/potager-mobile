import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import './../interceptors/connectivity_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor(this.requestRetrier);
  final DioConnectivityRequestRetrier requestRetrier;

  @override
  Future<dynamic> onError(DioError err) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.request);
      } on Exception {
        print('issou');
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}
