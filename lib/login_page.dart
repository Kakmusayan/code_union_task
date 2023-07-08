import 'dart:convert';

import 'package:code_union_task/constants/api_constants.dart';
import 'package:code_union_task/constants/global_class.dart';
import 'package:code_union_task/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants/app_styles.dart';
import 'model.dart/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLoading = false;

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final Map<String?, String?> _loginData = {
    'email': "",
    'password': "",
  };

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse("${ApiConstants.baseUrl}/api/v1/auth/login");

    final response = await http.post(
      url,
      body: json.encode(
        {
          "email": _loginData["email"],
          "password": _loginData['password'],
        },
      ),
      headers: {
        'Content-Type': 'Application/json',
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(
        utf8.decode(response.bodyBytes),
      );

      storage.write(
        key: 'accessToken',
        value: responseData['tokens']["accessToken"],
      );
      storage.write(
        key: 'refreshToken',
        value: responseData['tokens']["refreshToken"],
      );

      GlobalClass.currentUSer = User.fromMap(responseData["user"]);

      setState(() {
        _isLoading = false;
      });
      _loginController.clear();
      _passwordController.clear();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(ProfilePage.routeName);
    } else {
      final responseData = json.decode(
        utf8.decode(response.bodyBytes),
      );
      String errorMessage = responseData["message"];
      showErrorMessage(errorMessage);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorMessage(String errorText) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Ошибка'),
            content: Text(errorText),
            actions: <Widget>[
              CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('ok'))
            ],
          );
        });
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0XFFF3F4F6),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
        middle: FittedBox(
          child: Text(
            "Авторизация",
            style: TextStyle(
              fontFamily: AppStyles.fontFamilyManrope,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: MediaQuery.of(context).viewInsets.bottom == 0 ? 224 : 112,
            child: Container(),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 123,
            child: Column(
              children: [
                //login
                CupertinoTextField(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  placeholder: "Логин или почта",
                  placeholderStyle: TextStyle(
                    color: const Color(0xFFC3C3C3),
                    fontFamily: AppStyles.fontFamilyManrope,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _loginController,

                  // ignore: body_might_complete_normally_nullable
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 1,
                    color: Color(0XFFE0E6ED),
                  ),
                ),
                //password
                CupertinoTextField(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  placeholder: "Пароль",
                  placeholderStyle: TextStyle(
                    color: const Color(0xFFC3C3C3),
                    fontFamily: AppStyles.fontFamilyManrope,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: _passwordController,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 32,
            child: Container(),
          ),
          _isLoading
              ? const CircularProgressIndicator(
                  color: Color(0XFF4631D2),
                )
              : Flexible(
                  flex: 64,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color(0XFF4631D2),
                        onPressed: () {
                          if (_loginController.text.isEmpty) {
                            showErrorMessage('Логин не введен');
                          } else if (_passwordController.text.isEmpty) {
                            showErrorMessage("Пароль не введен");
                          } else {
                            _loginData['email'] = _loginController.text;
                            _loginData['password'] = _passwordController.text;
                            _submit();
                          }
                        },
                        child: FittedBox(
                          child: Text(
                            "Войти",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppStyles.fontFamilyManrope,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Flexible(
            flex: 19,
            child: Container(),
          ),
          Flexible(
            flex: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(6.0),
                  color: const Color(0XFF4631D2),
                  onPressed: () {},
                  child: FittedBox(
                    child: Text(
                      "Зарегистрироваться",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppStyles.fontFamilyManrope,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: MediaQuery.of(context).viewInsets.bottom == 0 ? 198 : 99,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
