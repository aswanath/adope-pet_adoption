import 'package:adope/config/ui_theme/ui_constants.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: poppins,
  primarySwatch: primarySwatchColors,
  primaryColor: const Color(0xFFFCAB4C),
  focusColor: Colors.brown,
  iconTheme: IconThemeData(
    color: primarySwatchColors.shade900,
  ),
  canvasColor: Colors.black,
  scaffoldBackgroundColor: primarySwatchColors.shade900,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFFFCAB4C),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0XFF6B8EFE),
  ),
  secondaryHeaderColor: const Color(0XFF6B8EFE),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 20,
      color: Colors.orange,
      fontWeight: FontWeight.w500,
    ),
    headline3: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    headline4: TextStyle(
      fontSize: 12,
      color: Colors.white,
    ),
    headline5: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: Colors.white,
    ),
  ),
);
