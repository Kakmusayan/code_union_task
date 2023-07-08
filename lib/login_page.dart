// login_page.dart

import 'package:code_union_task/constants/app_styles.dart';
import 'package:code_union_task/constants/global_class.dart';
import 'package:code_union_task/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'service/auth_service.dart';

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

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      GlobalClass.currentUSer = await AuthService.login(
        _loginController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });
      _loginController.clear();
      _passwordController.clear();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(ProfilePage.routeName);
    } catch (e) {
      showErrorMessage(e.toString());
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
          actions: [
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
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
                CustomCupertinoTextField(
                  placeholder: "Логин или почта",
                  keyboardType: TextInputType.emailAddress,
                  controller: _loginController,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 1,
                    color: Color(0XFFE0E6ED),
                  ),
                ),
                CustomCupertinoTextField(
                  placeholder: "Пароль",
                  controller: _passwordController,
                  obscureText: true,
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
                      child: CustomCupertinoButton(
                        color: const Color(0XFF4631D2),
                        text: "Войти",
                        onPressed: () {
                          if (_loginController.text.isEmpty) {
                            showErrorMessage('Логин не введен');
                          } else if (_passwordController.text.isEmpty) {
                            showErrorMessage("Пароль не введен");
                          } else {
                            _submit();
                          }
                        },
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
                child: CustomCupertinoButton(
                  color: const Color(0XFF4631D2),
                  text: "Зарегистрироваться",
                  onPressed: () {},
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

class CustomCupertinoTextField extends StatelessWidget {
  final String placeholder;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;

  const CustomCupertinoTextField({
    Key? key,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      placeholder: placeholder,
      placeholderStyle: TextStyle(
        color: const Color(0xFFC3C3C3),
        fontFamily: AppStyles.fontFamilyManrope,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
    );
  }
}

class CustomCupertinoButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const CustomCupertinoButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(6.0),
      color: color,
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppStyles.fontFamilyManrope,
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
