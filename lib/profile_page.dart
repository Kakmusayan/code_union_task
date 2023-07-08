import 'package:code_union_task/constants/global_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants/app_styles.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> _showLogoutDialog() async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Выход'),
          content: const Text('Вы уверены, что хотите выйти?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Остаться'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                _logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Выйти'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    storage.delete(key: "accessToken");
    storage.delete(key: "refreshToken");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 126,
          child: Container(),
        ),
        Flexible(
          flex: 64,
          child: Image.asset("assets/image/ProfileAvatar.png"),
        ),
        Flexible(
          flex: 15,
          child: Container(),
        ),
        Flexible(
          flex: 40,
          child: Text(
            GlobalClass.currentUSer.nickname!,
            style: TextStyle(
              color: Colors.black,
              fontFamily: AppStyles.fontFamilyManrope,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Flexible(
          flex: 12,
          child: Container(),
        ),
        Flexible(
          flex: 22,
          child: FittedBox(
            child: Text(
              GlobalClass.currentUSer.email!,
              style: TextStyle(
                color: const Color(0XFF929292),
                fontFamily: AppStyles.fontFamilyManrope,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 27,
          child: Container(),
        ),
        Flexible(
          flex: 55,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CupertinoButton(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 29),
              color: Colors.white,
              onPressed: _showLogoutDialog,
              child: FittedBox(
                child: Text(
                  "Выйти",
                  style: TextStyle(
                    color: const Color(0xFFEC3A4D),
                    fontFamily: AppStyles.fontFamilyManrope,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 451,
          child: Container(),
        ),
      ],
    );
  }
}
