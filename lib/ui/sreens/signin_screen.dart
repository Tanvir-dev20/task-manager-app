import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/controllers/signin_provider.dart';
import 'package:task_manager_app/ui/sreens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_app/ui/sreens/main_navbar_holder_screen.dart';
import 'package:task_manager_app/ui/sreens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/password_visibility.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../widgets/centered_Progress_indicator.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static const String name = '/signin';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final SigninProvider _signinProvider = SigninProvider();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _signinProvider,
      child: Scaffold(
        body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 82),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        String inputText = value ?? '';
                        if (EmailValidator.validate(inputText) == false) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: PasswordSuffixIcon(
                          isObscure: isObscure,
                          onToggole: onTapPassordVisibleIcon,
                        ),
                      ),

                      validator: (value) {
                        if ((value?.length ?? 0) < 6) {
                          return 'Password should more than 6 letter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Consumer<SigninProvider>(
                      builder: (context, signinProvider, _) {
                        return Visibility(
                          visible: signinProvider.signinInProgress == false,
                          replacement: CenteredProgressIndicator(),
                          child: FilledButton(
                            onPressed: _onTapSigninButton,
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPasswordButton,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(color: Colors.green),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = _onTapSignUpButton,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void _onTapForgotPasswordButton() {
    Navigator.pushNamed(context, ForgotPasswordVerifyEmailScreen.name);
  }

  void _onTapSigninButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    final bool isSuccess = await _signinProvider.signIn(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavbarHolderScreen.name,
        (predicate) => false,
      );
    } else {
      showSnackBarMessage(context, _signinProvider.errorMessage!);
    }
  }

  void onTapPassordVisibleIcon() {
    isObscure = !isObscure;
    setState(() {});
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
