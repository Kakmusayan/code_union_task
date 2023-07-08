// auth_service.dart

import 'dart:convert';

import 'package:code_union_task/constants/api_constants.dart';
import 'package:code_union_task/model.dart/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<User> login(String email, String password) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/api/v1/auth/login");

    final response = await http.post(
      url,
      body: json.encode(
        {
          "email": email,
          "password": password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      final accessToken = responseData['tokens']['accessToken'] as String;
      final refreshToken = responseData['tokens']['refreshToken'] as String;

      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);

      return User.fromMap(responseData['user']);
    } else {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      String errorMessage = responseData['message'] as String;
      throw errorMessage;
    }
  }

  static void logout() {
    storage.delete(key: 'accessToken');
    storage.delete(key: 'refreshToken');
  }
}
