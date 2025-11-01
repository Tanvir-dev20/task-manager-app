import 'package:flutter/material.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool newPasswordInProgress = false;
  String? _message;
  String? get message => _message;
  Future<bool> setNewPassword({
    required String email,
    required String otp,
    required String passsword,
  }) async {
    bool isSuccess = false;
    newPasswordInProgress = true;
    notifyListeners();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": passsword,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.resetPasswordUrl,
      body: requestBody,
    );
    if (response.isSuccess) {
      _message = response.responseData['data'];
      newPasswordInProgress = false;
      notifyListeners();
      return isSuccess = true;
    } else {
      newPasswordInProgress = false;
      notifyListeners();
      _message = response.errorMessage;
      return isSuccess;
    }
  }
}
