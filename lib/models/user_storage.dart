import 'dart:convert';

class UserStorage {
  UserStorage({
    this.id,
    this.jwt,
    this.refreshToken,
    this.coordonnees,
    this.commune,
  });

  factory UserStorage.fromJson(String jsonString) {
    if (jsonString == null || jsonString.isEmpty) return UserStorage();

    final Map<String, dynamic> rawJson = jsonDecode(jsonString);

    final dynamic coord = jsonDecode(rawJson['coordonnees']);
    List<double> coordonnees;
    if (coord != null) {
      coordonnees = coord.map<double>((s) => s as double).toList();
    }

    return UserStorage(
      id: int.parse(rawJson['id'] as String),
      jwt: rawJson['jwt'] as String,
      refreshToken: rawJson['refreshToken'] as String,
      coordonnees: coordonnees,
      commune: rawJson['commune'] as String,
    );
  }

  String toJson() =>
      '''{"id": "$id", "jwt": "$jwt", "refreshToken": "$refreshToken", "coordonnees": "$coordonnees", "commune": "$commune"}''';

  final int id;
  String jwt;
  final String refreshToken;
  List<double> coordonnees;
  String commune;
}
