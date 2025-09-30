import 'package:flutter/material.dart';

class PasswordSuffixIcon extends StatelessWidget {
  PasswordSuffixIcon({required this.isObscure, required this.onToggole});
  final bool isObscure;
  final VoidCallback onToggole;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggole,
      icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
    );
  }
}
