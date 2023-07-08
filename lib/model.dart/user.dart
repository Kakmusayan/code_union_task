import 'dart:convert';

class User {
  int? id;
  String? email;
  String? nickname;

  User({this.id, this.email, this.nickname});

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        email: data['email'] as String?,
        nickname: data['nickname'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'nickname': nickname,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
