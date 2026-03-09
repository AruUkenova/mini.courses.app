import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

class LoginPresenter extends ChangeNotifier {
  final AuthRepository authRepository;

  bool isLoading = false;
  String? error;

  LoginPresenter(this.authRepository);

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final err = await authRepository.login(email, password);

    isLoading = false;
    error = err;

    notifyListeners();
  }
}
