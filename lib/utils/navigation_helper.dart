import 'package:flutter/material.dart';

class NavigationHelper {
  static void pushAndRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
      (route) => false,
    );
  }

  static void push(
    BuildContext context,
    Widget screen, {
    Function(dynamic)? onValue,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    ).then(
      onValue ?? (_) {},
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
