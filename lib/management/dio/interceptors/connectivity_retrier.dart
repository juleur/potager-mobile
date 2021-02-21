import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/dio/connectivity_provider.dart';
import './../../../management/dio/dio_provider.dart';

class DioConnectivityRequestRetrier {
  DioConnectivityRequestRetrier(this._read);
  final Reader _read;

  Future<Response<dynamic>> scheduleRequestRetry(
      RequestOptions requestOptions) async {
    StreamSubscription<dynamic> streamSubscription;
    final responseCompleter = Completer<Response<dynamic>>();

    _read(connectivityProvider).onConnectivityChanged.listen((connResult) {
      if (connResult != ConnectivityResult.none) {
        streamSubscription.cancel();
        responseCompleter.complete(
          _read(dioDefaultProvider).request<Response<dynamic>>(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: requestOptions,
          ),
        );
      }
    });
    return responseCompleter.future;
  }
}
