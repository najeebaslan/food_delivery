import 'package:flutter/material.dart';

import 'color_hex.dart';

Color kPrimaryColor = HexColor('#5b77ff');
Color secondPrimaryColor = Colors.orange;
Color thirdPrimaryColor = Colors.red;

class AppColors {
  AppColors._();
  static Color kPrimaryColor = HexColor('#5b77ff');

  static const Color white = Color(0xFFFFFFFF);
  static Color red = const Color(0xFFE8453C);
  static Color nearRed = const Color(0xFFEA574F);
  static Color black = HexColor("#000000");
  static Color green = HexColor("#3AA856");
  static Color yellow = HexColor("#FABB2D");
  static const Color errorColor = Color(0xFFBD1B1B);
  static Color background = const Color(0xFFFFFFFF);
  static Color homeBackground = const Color(0xFFF9FFF6);
  static Color blue = const Color(0xFF4688F0);
}
