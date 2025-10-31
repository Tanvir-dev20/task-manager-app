import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/controllers/forgot_password_verify_email_provider.dart';
import 'package:task_manager_app/ui/sreens/forgot_password_verify_otp_screen.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

import '../widgets/snack_bar_message.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  ForgotPasswordVerifyEmailScreen({super.key});
  static const String name = '/forgot-pass';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreen();
}

class _ForgotPasswordVerifyEmailScreen
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ForgotPasswordVerifyEmailProvider forgotPVEmailProvider =
      ForgotPasswordVerifyEmailProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => forgotPVEmailProvider,
      child: Scaffold(
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
                    "You'r Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "A 6 digit OTP will be sent to you'r email address",
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

                  const SizedBox(height: 16),
                  Consumer<ForgotPasswordVerifyEmailProvider>(
                    builder: (context, forgotPVerifyEmailProvider, _) {
                      return Visibility(
                        visible:
                            forgotPVerifyEmailProvider
                                .recoverVerifyEmailInProgress ==
                            false,
                        replacement: CenteredProgressIndicator(),
                        child: FilledButton(
                          onPressed: () {
                            _recoverVerifyEmail();
                          },

                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    },
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
                                  ..onTap = _onTapSignInButton,
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
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  Future<void> _recoverVerifyEmail() async {
    bool isSuccess = await forgotPVEmailProvider.recoverVerifyEmail(
      _emailTEController.text.trim(),
    );
    if (isSuccess) {
      showSnackBarMessage(context, forgotPVEmailProvider.message ?? '');
      Navigator.pushNamed(
        context,
        ForgotPasswordVerifyOtpScreen.name,
        arguments: _emailTEController.text.trim(),
      );
    } else {
      showSnackBarMessage(
        context,
        forgotPVEmailProvider.message ?? 'Something went wrong',
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
