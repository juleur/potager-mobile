import 'package:meta/meta.dart';

class User {
  User({
    @required this.id,
    @required this.username,
    this.description,
    this.email,
    this.registeredAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      description: json['description'] as String,
      email: json['email'] as String,
      registeredAt: json['registeredAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final int id;
  final String username;
  final String description;
  final String email;
  final String registeredAt;
  final String updatedAt;
}
