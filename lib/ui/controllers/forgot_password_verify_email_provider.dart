import 'package:flutter/widgets.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ForgotPasswordVerifyEmailProvider extends ChangeNotifier {
  bool recoverVerifyEmailInProgress = false;
  String? _message;
  String? get message => _message;
  Future<bool> recoverVerifyEmail(String email) async {
    bool isSuccess = false;
    recoverVerifyEmailInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.recoverVerifyEmailUrl(email),
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      _message = response.responseData['data'];
      recoverVerifyEmailInProgress = false;
      notifyListeners();
      return isSuccess = true;
    } else {
      recoverVerifyEmailInProgress = false;
      notifyListeners();
      _message = response.errorMessage;
      return isSuccess;
    }
  }
}
