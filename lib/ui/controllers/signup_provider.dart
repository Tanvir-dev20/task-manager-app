import 'package:flutter/widgets.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class SignupProvider extends ChangeNotifier {
  bool _signupInProgress = false;
  bool get signupInProgress => _signupInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<bool> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    bool isSuccess = false;
    _signupInProgress = true;
    notifyListeners();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );
    if (response.isSuccess) {
      _errorMessage = null;
      return isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _signupInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
