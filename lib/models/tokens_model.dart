import 'package:meta/meta.dart';

class Tokens {
  Tokens({@required this.jwt, @required this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      jwt: json['jwt'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  @override
  String toString() => '{jwt: $jwt, refreshToken: $refreshToken}';

  final String jwt;
  final String refreshToken;
}
