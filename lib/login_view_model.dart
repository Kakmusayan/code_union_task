import 'package:code_union_task/service/auth_service.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await AuthService.login(email, password);
      _isLoading = false;
      notifyListeners();
      // Successful login logic here
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Handle error and show error message
    }
  }
}
