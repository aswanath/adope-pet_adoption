import 'package:adope/config/ui_theme/theme_config.dart';
import 'package:adope/dependency_injection/injection_container.dart';
import 'package:adope/modules/home/bloc/home_bloc.dart';
import 'package:adope/modules/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Adope extends StatelessWidget {
  const Adope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Adope',
        theme: AppThemes.theme(themeMode: ThemeMode.light),
        darkTheme: AppThemes.theme(themeMode: ThemeMode.dark),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior(),
        home: const SplashScreen(),
      ),
    );
  }
}
