import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import 'signin_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});
  static const String name = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool newPasswordInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  "Minimum length password 8 character with letter and number combination ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _otpTEController,
                  decoration: InputDecoration(
                    hintText: 'Otp',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    hintText: 'Confirm New Password',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 16),
                Visibility(
                  visible: newPasswordInProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: FilledButton(
                    onPressed: setNewPassword,

                    child: Text('Confirm'),
                  ),
                ),
                const SizedBox(height: 35),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: Colors.green),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = _onTapConfirmButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapConfirmButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }

  Future<void> setNewPassword() async {
    newPasswordInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "OTP": _otpTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.resetPasswordUrl,
      body: requestBody,
    );
    if (response.isSuccess) {
      showSnackBarMessage(context, response.responseData['data']);
      _onTapConfirmButton();
    } else {
      newPasswordInProgress = false;
      setNewPassword();
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _otpTEController.dispose();
    super.dispose();
  }
}
