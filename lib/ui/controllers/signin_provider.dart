import 'package:flutter/widgets.dart';

import '../../data/model/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SigninProvider extends ChangeNotifier {
  bool _signinInProgress = false;
  bool get signinInProgress => _signinInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn({required String email, required String password}) async {
    bool isSuccess = false;
    _signinInProgress = true;
    notifyListeners();
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.logInUrl,
      body: requestBody,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String accessToken = response.responseData['token'];
      debugPrint('💡💡💡💡this is access token key=>>>${accessToken}');

      await AuthController.saveUserData(accessToken, model);
      _errorMessage = null;
      return isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _signinInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
