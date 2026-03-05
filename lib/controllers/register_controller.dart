import 'package:flutter/foundation.dart';
import '../repositories/auth_repository.dart';

class RegisterVm {
  final bool loading;
  final String? error;
  const RegisterVm({this.loading = false, this.error});

  RegisterVm copy({bool? loading, String? error}) =>
      RegisterVm(loading: loading ?? this.loading, error: error);
}

class RegisterController extends ChangeNotifier {
  final AuthRepository _auth;
  RegisterVm vm = const RegisterVm();

  RegisterController(this._auth);

  Future<bool> register(String email, String pass) async {
    vm = vm.copy(loading: true, error: null);
    notifyListeners();

    final err = await _auth.register(email, pass);

    vm = vm.copy(loading: false, error: err);
    notifyListeners();
    return err == null;
  }
}