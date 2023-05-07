import 'package:adope/constant/asset_path.dart';
import 'package:adope/modules/home/screen/home_screen.dart';
import 'package:adope/utils/navigation_helper.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    Future.delayed(const Duration(seconds: 2)).then(
      (_) {
        NavigationHelper.pushAndRemoveUntil(
          context,
          const HomeScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            FadeInDown(
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0XFFFF3B3B),
                      Color(0XFF6B8EFE),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  'ADOPE',
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
              ),
            ),
            Image.asset(
              runningDogPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
