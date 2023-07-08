import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

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
