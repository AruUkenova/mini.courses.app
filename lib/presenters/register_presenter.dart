import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

class RegisterPresenter extends ChangeNotifier {
  final AuthRepository authRepository;

  bool isLoading = false;
  String? error;

  RegisterPresenter(this.authRepository);

  Future<bool> register(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final err = await authRepository.register(email, password);

    isLoading = false;
    error = err;

    notifyListeners();

    return err == null;
  }
}