import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _s;
  AuthRepository(this._s);

  Stream<User?> authStateChanges() => _s.authStateChanges();
  User? get currentUser => _s.currentUser;

  Future<String?> login(String email, String pass) async {
    try {
      await _s.signIn(email, pass);
      return null;
    } on FirebaseAuthException catch (e) {
      return _map(e.code);
    } catch (_) {
      return "Белгісіз қате";
    }
  }

  Future<String?> register(String email, String pass) async {
    try {
      await _s.signUp(email, pass);
      return null;
    } on FirebaseAuthException catch (e) {
      return _map(e.code);
    } catch (_) {
      return "Белгісіз қате";
    }
  }

  Future<void> logout() => _s.signOut();

  String _map(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Қолданушы табылмады';
      case 'wrong-password':
        return 'Пароль қате';
      case 'email-already-in-use':
        return 'Email тіркелген';
      case 'invalid-email':
        return 'Email дұрыс емес';
      case 'weak-password':
        return 'Пароль әлсіз';
      default:
        return 'Қате: $code';
    }
  }
}