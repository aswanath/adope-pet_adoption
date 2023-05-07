import 'package:adope/config/ui_theme/ui_constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: poppins,
  primarySwatch: primarySwatchColors,
  primaryColor: const Color(0xFFFCAB4C),
  focusColor: Colors.brown,
  scaffoldBackgroundColor: primarySwatchColors.shade200,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFFFCAB4C),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0XFF6B8EFE),
  ),
  canvasColor: Colors.white,
  secondaryHeaderColor: const Color(0XFF6B8EFE),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 20,
      color: Colors.orange,
      fontWeight: FontWeight.w500,
    ),
    headline3: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: Colors.black,
    ),
  ),
);
