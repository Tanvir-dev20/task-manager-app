import 'package:flutter/material.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ForgotPasswordVerifyOtpProvider extends ChangeNotifier {
  bool verifyOtpInProgress = false;
  String? _message;
  String? get message => _message;
  Future<bool> recoverVerifyOtp(String email, String otp) async {
    bool isSuccess = false;
    verifyOtpInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.recoverVerifyOtpUrl(email, otp),
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      _message = response.responseData['data'];
      verifyOtpInProgress = false;
      notifyListeners();
      return isSuccess = true;
    } else {
      verifyOtpInProgress = true;
      notifyListeners();
      _message = response.responseData['data'];
      return isSuccess;
    }
  }
}
