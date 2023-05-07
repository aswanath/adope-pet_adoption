import 'package:flutter/material.dart';

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar(this.context);

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
