import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/ui/sreens/signin_screen.dart';
import 'package:task_manager_app/ui/utilits/assets_path.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nextScreen();
  }

  Future<void> _nextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetsPath.logoSvg, height: 40)),
      ),
    );
  }
}
