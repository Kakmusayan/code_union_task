// user.dart

import 'dart:convert';

class User {
  final int id;
  final String email;
  final String nickname;

  User({required this.id, required this.email, required this.nickname});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] as int,
      email: data['email'] as String,
      nickname: data['nickname'] as String,
    );
  }

  factory User.fromJson(String data) {
    final Map<String, dynamic> jsonData = json.decode(data);
    return User.fromMap(jsonData);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
    };
  }

  String toJson() {
    final Map<String, dynamic> jsonData = toMap();
    return json.encode(jsonData);
  }
}
