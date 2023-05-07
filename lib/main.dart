import 'package:adope/adope.dart';
import 'package:adope/dependency_injection/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await configureDependencies();
  runApp(const Adope());
}
