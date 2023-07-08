// profile_page.dart

import 'package:code_union_task/constants/app_styles.dart';
import 'package:code_union_task/constants/global_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'service/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const routeName = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                AuthService.logout();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Выйти'),
            ),
          ],
        );
      },
    );
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
            GlobalClass.currentUSer.nickname,
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
              GlobalClass.currentUSer.email,
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
          fit: FlexFit.tight,
          flex: 55,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CupertinoButton(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 21),
              color: Colors.white,
              onPressed: _showLogoutDialog,
              child: FittedBox(
                fit: BoxFit.none,
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
