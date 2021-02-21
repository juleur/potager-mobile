class User {
  User({
    this.id,
    this.username,
    this.email,
    this.registeredAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      registeredAt: json['registeredAt'] as String,
    );
  }

  @override
  String toString() =>
      '{id: $id, username: $username, email: $email, registeredAt: $registeredAt}';

  final int id;
  final String username;
  final String email;
  final String registeredAt;
}
