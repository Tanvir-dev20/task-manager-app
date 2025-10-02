import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/sreens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_app/ui/sreens/forgot_password_verify_otp_screen.dart';
import 'package:task_manager_app/ui/sreens/main_navbar_holder_screen.dart';
import 'package:task_manager_app/ui/sreens/reset_password_screen.dart';
import 'package:task_manager_app/ui/sreens/sign_up_screen.dart';
import 'package:task_manager_app/ui/sreens/signin_screen.dart';
import 'package:task_manager_app/ui/sreens/splash_screen.dart';
import 'package:task_manager_app/ui/sreens/update_profile_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name: (_) => SplashScreen(),
        SignUpScreen.name: (_) => SignUpScreen(),
        SigninScreen.name: (_) => SigninScreen(),
        ForgotPasswordVerifyEmailScreen.name:
            (_) => ForgotPasswordVerifyEmailScreen(),
        ForgotPasswordVerifyOtpScreen.name:
            (_) => ForgotPasswordVerifyOtpScreen(),
        ResetPasswordScreen.name: (_) => ResetPasswordScreen(),
        MainNavbarHolderScreen.name: (_) => MainNavbarHolderScreen(),
        UpdateProfileScreen.name: (_) => UpdateProfileScreen(),
      },
    );
  }
}
