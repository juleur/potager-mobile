import 'dart:convert';

class MessageException implements Exception {
  MessageException(this._rawJson) {
    final Map<String, dynamic> json = jsonDecode(_rawJson);
    message = json['message'] as String;
    statusCode = json['error_code'] as int;
  }
  String message;
  int statusCode;
  final String _rawJson;
}
