import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

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
