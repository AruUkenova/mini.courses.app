import 'package:flutter/foundation.dart';
import '../repositories/auth_repository.dart';

class LoginVm {
  final bool loading;
  final String? error;
  const LoginVm({this.loading = false, this.error});

  LoginVm copy({bool? loading, String? error}) =>
      LoginVm(loading: loading ?? this.loading, error: error);
}

class LoginController extends ChangeNotifier {
  final AuthRepository _auth;
  LoginVm vm = const LoginVm();

  LoginController(this._auth);

  Future<void> login(String email, String pass) async {
    vm = vm.copy(loading: true, error: null);
    notifyListeners();

    final err = await _auth.login(email, pass);

    vm = vm.copy(loading: false, error: err);
    notifyListeners();
  }
}