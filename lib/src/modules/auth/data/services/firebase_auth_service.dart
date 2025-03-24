import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/services/auth_service.dart';
import '../../domain/entities/user_passport.dart';
import '../../domain/states/auth_state.dart';

final class FirebaseAuthService implements AuthService {
  const FirebaseAuthService({required this.localStorage});

  final FlutterSecureStorage localStorage;

  @override
  Future<AuthState> signInWithEmailPassword(UserPassport userPassport) async {
    try {
      // Tenta autenticar o usuário com email e senha
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userPassport.email,
        password: userPassport.password,
      );

      // Armazena o token do usuário no armazenamento seguro
      await localStorage.write(
          key: 'userToken', value: userCredential.user?.uid);

      // Retorna o estado de sucesso com os dados do usuário
      return AuthState(
        userPassport: userPassport.copyWith(id: userCredential.user?.uid),
        status: AuthStatus.successAuthenticating,
      );
    } on FirebaseAuthException catch (error) {
      // Caso ocorra um erro, retorna um estado de erro apropriado
      return AuthState(
        userPassport: userPassport,
        status: error.code == 'user-not-found'
            ? AuthStatus.failureUserNotFound
            : error.code == 'wrong-password'
                ? AuthStatus.failureWrongPassword
                : AuthStatus.unknownError,
      );
    } catch (error) {
      // Caso ocorra um erro desconhecido
      return AuthState(
        userPassport: userPassport,
        status: AuthStatus.unknownError,
      );
    }
  }
}
