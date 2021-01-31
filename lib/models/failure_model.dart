import 'dart:convert';

class Failure implements Exception {
  Failure(this._rawJson) {
    final Map<String, dynamic> json = jsonDecode(_rawJson);
    message = json['message'] as String;
    errorCode = json['error_code'] as int;
  }

  String message;
  int errorCode;
  final String _rawJson;
}
