import '../entities/user_passport.dart';
import '../states/auth_state.dart';

abstract interface class AuthService {
  Future<AuthState> signInWithEmailPassword(UserPassport userPassport);
}
