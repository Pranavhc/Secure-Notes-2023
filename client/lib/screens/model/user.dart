import 'dart:convert';

class User {
  final String userId;
  final String name;
  final String email;
  final String token;

  const User({
    this.userId = "",
    required this.name,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'userId': userId,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      userId: map['_id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? email,
    String? name,
    String? userId,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      token: token ?? this.token,
    );
  }
}
