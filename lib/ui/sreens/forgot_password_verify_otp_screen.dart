import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/sreens/reset_password_screen.dart';
import 'package:task_manager_app/ui/sreens/signin_screen.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  ForgotPasswordVerifyOtpScreen();
  static const String name = '/otp';

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreen();
}

class _ForgotPasswordVerifyOtpScreen
    extends State<ForgotPasswordVerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _verifyOtpInProgress = false;
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    final emailArg = ModalRoute.of(context)!.settings.arguments as String;
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
                  "Pin Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  "A 6 digit OTP has been sent to you'r email address",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,

                  controller: _otpTEController,

                  appContext: context,
                ),

                const SizedBox(height: 16),
                Visibility(
                  visible: _verifyOtpInProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: FilledButton(
                    onPressed: () {
                      _recoverVerifyOtp(emailArg, _otpTEController.text);
                    },
                    child: Text('Verify'),
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
    );
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SigninScreen.name,
      (predicate) => false,
    );
  }

  void _onTapVerifyButton() {
    Navigator.pushNamed(context, ResetPasswordScreen.name);
  }

  Future<void> _recoverVerifyOtp(String email, String otp) async {
    _verifyOtpInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.recoverVerifyOtpUrl(email, otp),
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      final message = response.responseData['data'];
      showSnackBarMessage(context, message);
      _verifyOtpInProgress = false;
      _onTapVerifyButton();
      setState(() {});
    } else {
      _verifyOtpInProgress = false;
      setState(() {});
      final message = response.responseData['data'];
      showSnackBarMessage(context, message ?? response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
