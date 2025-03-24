import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

      final String? userId = userCredential.user?.uid;

      if (userId != null) {
        // Armazena o token do usuário no armazenamento seguro
        await localStorage.write(key: 'userToken', value: userId);

        // Salva o token no Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'token': userId,
          'email': userPassport.email,
        }, SetOptions(merge: true));
      }

      // Retorna o estado de sucesso com os dados do usuário
      return AuthState(
        userPassport: userPassport.copyWith(id: userId),
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

  Future<AuthState> checkUserLoggedIn() async {
    try {
      // Recupera o token do armazenamento seguro
      final String? userToken = await localStorage.read(key: 'userToken');

      if (userToken != null) {
        // Verifica se o usuário ainda está autenticado no Firebase
        final User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null && currentUser.uid == userToken) {
          // Verifica no banco de dados se o token está vinculado ao usuário
          final DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .get();

          if (userDoc.exists && userDoc['token'] == userToken) {
            // Retorna o estado de sucesso com o usuário autenticado
            return AuthState(
              userPassport: UserPassport(
                  email: currentUser.email ?? '',
                  id: currentUser.uid,
                  password: ''),
              status: AuthStatus.successAuthenticating,
            );
          }
        }
      }

      // Caso o token não exista ou o usuário não esteja autenticado
      return const AuthState(
        userPassport: UserPassport.empty(),
        status: AuthStatus.failureUserNotFound,
      );
    } catch (error) {
      // Retorna um estado de erro em caso de falha
      return const AuthState(
        userPassport: UserPassport.empty(),
        status: AuthStatus.unknownError,
      );
    }
  }
}
