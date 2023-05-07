import 'package:adope/config/ui_theme/dark_theme.dart';
import 'package:adope/config/ui_theme/light_theme.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData theme({required ThemeMode themeMode}) {
    if (themeMode == ThemeMode.dark) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }
}
